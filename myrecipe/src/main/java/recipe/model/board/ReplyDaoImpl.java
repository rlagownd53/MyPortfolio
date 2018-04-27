package recipe.model.board;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository(value="rdao")
public class ReplyDaoImpl implements ReplyDao{
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private JdbcTemplate jdbcTemplate;

	private RowMapper<ReplyDto> mapper = (rs, idx)->{
		return new ReplyDto(rs);
	};
	@Override
	public void insert(ReplyDto rdto, String auth) {
		String sql = "select reply from board where board_no= ?";
		jdbcTemplate.queryForObject(sql, new Object[] {rdto.getContext()},Integer.class);
		
		int gno = rdto.getGno();
		int gseq = rdto.getGseq();
		int depth = rdto.getDepth();
		
		if(gno == 0) {
			sql = "select max(gno) from reply where context=?";
			Integer g = jdbcTemplate.queryForObject(sql, new Object[] {rdto.getContext()}, Integer.class);
			if(g==null) {
				gno = 1;
				gseq = 0;
				depth = 0;
			}
			else {
				gno = g+1;
				gseq = 0;
				depth = 0;
			}
		}else {
			sql = "select min(gseq) from reply where gno=? and gseq>? and depth<? and context=?";
			Integer f = jdbcTemplate.queryForObject(sql, new Object[] {gno, gseq, depth, rdto.getContext()}, Integer.class);
			if(f==null) f=0;
			int first = f;

			sql = "select min(gseq) from reply where gno=? and gseq>? and depth=? and context=?";
			Integer s = jdbcTemplate.queryForObject(sql, new Object[] {gno, gseq, depth, rdto.getContext()}, Integer.class);
			if(s==null) s=0;
			int second = s;
			
			sql = "select count(*) from reply where gno=? and context=?";
			Integer l = jdbcTemplate.queryForObject(sql, new Object[] {gno, rdto.getContext()}, Integer.class);
			if(l==null) l=0;
			int last = l;
			

			/*
			 * [1] first, second 둘다 0 => 그룹 마지막
			 * [2] first, second 둘다 0이 아닌 경우 => 둘중 작은 값
			 * [3] first!=0, second==0 또는 first==0, second!=0 인 경우 => 둘 중 큰값 
			 */
			
			int location;
			if(first + second == 0 ) {
				location = last;
			}else if(first!=0 && second!=0) {
				location = Math.min(first, second);
			}else {
				location = Math.max(first, second);
			}
			
			sql = "update reply set gseq=gseq+1 where gno=? and gseq>=? and context=?";
			jdbcTemplate.update(sql, gno, location, rdto.getContext());
			
			gseq=location;
			depth++;
		}
		if(auth.equals("관리자")) {
			sql = "update board set replyck = 'y' where board_no=?";
			jdbcTemplate.update(sql, rdto.getContext());
		}
		
		sql = "insert into reply values(reply_seq.nextval,?,?,sysdate,?,?,?,?)";
		Object[] obj = {
				rdto.getWriter(), rdto.getDetail(), rdto.getContext(), gno, gseq, depth};
		jdbcTemplate.update(sql, obj);
	}

	@Override
	public List<ReplyDto> list(int context) {
		String sql = "select * from reply where context=? order by gno asc, gseq asc";
		return jdbcTemplate.query(sql, new Object[] {context}, mapper);
	}

	@Override
	public int delete(int no, String email) {
		String sql = "select context from reply where no=? and writer=?";
		int context = jdbcTemplate.queryForObject(sql, new Object[] {no, email}, Integer.class);
		
		sql = "delete reply where no=?";
		jdbcTemplate.update(sql,no);
		return context;
	}
	
}
