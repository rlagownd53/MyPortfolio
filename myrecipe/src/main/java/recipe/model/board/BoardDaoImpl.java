package recipe.model.board;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import recipe.security.securityimpl;

@Repository(value="bdao")
public class BoardDaoImpl implements BoardDao {
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	public static final String TITLE = "title";
	public static final String NAME = "name";
	public static final String CATEGORY = "category";
		
	public static final String CG_1 = "1";
	public static final String CG_2 = "2";
	public static final String CG_3 = "3";
	public static final String CG_4 = "4";
	public static final String CG_5 = "5";
	public static final String CG_6 = "6";
	
	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private securityimpl sec; 
	
	private RowMapper<BoardDto> mapper = (rs, idx)->{
		return new BoardDto(rs);
	};
	
	private ResultSetExtractor<BoardDto> extractor = (rs)->{
		return rs.next()?new BoardDto(rs):null;
	};
	
	
	@Override
	public int write(BoardDto bdto) {
		int gno = bdto.getGno();
		int gseq = bdto.getGseq();
		int depth = bdto.getDepth();
		if(gno == 0) {
			String sql = "select max(gno) from board";
			Integer g = jdbcTemplate.queryForObject(sql, Integer.class);
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
			String sql = "select min(gseq) from board where gno=? and gseq>? and depth<?";
			Integer f = jdbcTemplate.queryForObject(sql, new Object[] {gno, gseq, depth}, Integer.class);
			if(f==null) f=0;
			int first = f;

			sql = "select min(gseq) from board where gno=? and gseq>? and depth=?";
			Integer s = jdbcTemplate.queryForObject(sql, new Object[] {gno, gseq, depth}, Integer.class);
			if(s==null) s=0;
			int second = s;
			
			
			sql = "select count(*) from board where gno=?";
			Integer l = jdbcTemplate.queryForObject(sql, new Object[] {gno}, Integer.class);
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
			sql = "update board set gseq=gseq+1 where gno=? and gseq>=?";
			jdbcTemplate.update(sql, gno, location);
			
			gseq=location;
			depth++;
		}
		String sql = "select board_seq.nextval from dual";
		int no = (int)jdbcTemplate.queryForObject(sql, Integer.class);
		sql = "insert into board values(?,?,?,?,?,?,?,0,?,?,?,?,?,?,0,?,sysdate,?,'n')";
		Object[] obj = {
				no,  bdto.getName(), bdto.getEmail(), bdto.getCategory(), bdto.getTitle(),
				bdto.getDetail(), bdto.getPw(), bdto.getFilename(), bdto.getFilesize(), 
				bdto.getFiletype(), gno, gseq, depth, bdto.getNotice(), bdto.getAuthck() };
		
		try{
			jdbcTemplate.update(sql, obj);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return no; 	
	}
	
	
	@Override
	public BoardDto info(int no) {
		String sql = "select * from board where board_no = ?";
		return jdbcTemplate.query(sql, new Object[] {no}, extractor);
	}
	

	@Override
	public List<BoardDto> list(int start, int end, String cg) {
		String sql = null;
		if(cg==null) {
			sql = "select * from "
					+ "(select rownum rn, A.* from "
					+ "(select * from board where notice is null order by gno desc, gseq asc)A)"
					+ "where rn between ? and ?";
			return jdbcTemplate.query(sql, new Object[] {start, end}, mapper);
		} else {
			switch(cg) {
			case CG_1: cg="배송지연/불만"; break;
			case CG_2: cg="반품문의"; break;
			case CG_3: cg="환불문의"; break;
			case CG_4: cg="교환/취소문의"; break;
			case CG_5: cg="상품정보문의"; break;
			case CG_6: cg="기타문의"; break;
			}
			sql = "select * from "
							+ "(select rownum rn, A.* from "
							+ "(select * from board where category = ? order by notice asc, gno desc, gseq asc)A)"
							+ "where rn between ? and ?";
			return jdbcTemplate.query(sql, new Object[] {cg, start, end}, mapper);
		}
	}
	
	@Override
	public List<BoardDto> list(String type, String key, String cg, int start, int end) {
		if(type==null || key==null) {
			return list(start, end, cg);
		} else {
			switch(type) {
			case TITLE:
			case NAME:
			case CATEGORY:
				return oneSearch(type, key, cg, start, end);
			}
		}
		return null;
	}
	
	@Override
	public List<BoardDto> oneSearch(String type, String key, String cg, int start, int end) {
		switch(type) {
			case TITLE: type="title"; break;
			case NAME: type="name"; break;
			case CATEGORY: type="category"; break;
			}
		if(cg!="") {
			switch(cg) {
			case CG_1: cg="배송지연/불만"; break;
			case CG_2: cg="반품문의"; break;
			case CG_3: cg="환불문의"; break;
			case CG_4: cg="교환/취소문의"; break;
			case CG_5: cg="상품정보문의"; break;
			case CG_6: cg="기타문의"; break;
			}
			String sql = "select * from "
								+ "(select rownum rn, TMP.* from "
									+ "(select * from board "
										+ "where "+type+" like '%'||?||'%' and category = ? "
										+ "order by gno desc, gseq asc, depth asc)TMP) "
								+ "where notice is null and rn between ? and ?";
			return jdbcTemplate.query(sql, new Object[] {key, cg, start, end}, mapper);
		} else {
			String sql = "select * from "
								+ "(select rownum rn, TMP.* from "
										+ "(select * from board "
												+ "where "+type+" like '%'||?||'%' and notice is null "
												+ "order by gno desc, gseq asc, depth asc)TMP) "
								+ "where rn between ? and ?";
			return jdbcTemplate.query(sql, new Object[] {key, start, end},mapper);
		}
	}
	

	@Override
	public int edit(BoardDto bdto) {
		String sql = "update board set name=?, email=?, category=?, title=?, detail=?, pw=?,"
				+ "filename=?, filesize=?, filetype=?, notice=? where board_no = ?";
		Object[] obj = {
				bdto.getName(), bdto.getEmail(), bdto.getCategory(), bdto.getTitle(), bdto.getDetail(),
				bdto.getPw(), bdto.getFilename(), bdto.getFilesize(), bdto.getFiletype(), 
				bdto.getNotice(), bdto.getNo()};
		jdbcTemplate.update(sql, obj);
		return bdto.getNo();
	}

	@Override
	public void read(int no) {
		String sql = "update board set read=read+1 where board_no = ?";
		jdbcTemplate.update(sql, no);
	}

	@Override
	public int count(String type, String key, String cg) {
		if(cg!=null) {
			switch(cg) {
				case CG_1: cg="배송지연/불만"; break;
				case CG_2: cg="반품문의"; break;
				case CG_3: cg="환불문의"; break;
				case CG_4: cg="교환/취소문의"; break;
				case CG_5: cg="상품정보문의"; break;
				case CG_6: cg="기타문의"; break;
			}
		}
		//검색 하지 않은 경우
		if(type==null || key==null) {
			return listCount(cg);
		}
		
		switch(type) {
		case TITLE:
		case NAME:
		case CATEGORY:
			return oneSearchCount(type, key, cg);
		}
		return 0;
	}
	
	@Override
	public int listCount(String cg) {
		if(cg==null) {
			String sql = "select count(board_no) from board where notice is null";
			return jdbcTemplate.queryForObject(sql,Integer.class);
		} else {
			String sql = "select count(*) from board where category=?";
			return jdbcTemplate.queryForObject(sql, new Object[] {cg}, Integer.class);
		}
	}

	@Override
	public int oneSearchCount(String type, String key, String cg) {
		if(cg!="") {
			switch(cg) {
			case CG_1: cg="배송지연/불만"; break;
			case CG_2: cg="반품문의"; break;
			case CG_3: cg="환불문의"; break;
			case CG_4: cg="교환/취소문의"; break;
			case CG_5: cg="상품정보문의"; break;
			case CG_6: cg="기타문의"; break;
			}
			switch(type) {
				case TITLE: type="title"; break;
				case NAME: type="name"; break;
				case CATEGORY: type="category"; break;
			}
			String sql = "select count(board_no) from board where "+type+" like '%'||?||'%' and category=? and notice is null";
			return jdbcTemplate.queryForObject(sql, new Object[] {key, cg}, Integer.class);
		} else {
			switch(type) {
			case TITLE: type="title"; break;
			case NAME: type="name"; break;
			case CATEGORY: type="category"; break;
		}
		String sql = "select count(board_no) from board where "+type+" like '%'||?||'%' and notice is null";
		return jdbcTemplate.queryForObject(sql, new Object[] {key}, Integer.class);
		}
	}

	@Override
	public void delete(int no) {
		String sql = "delete board where board_no = ?";
		jdbcTemplate.update(sql, no);
	}
	
	@Override
	public void plusReply(int no) {
		String sql = "update board set reply=reply+1 where board_no=?";
		jdbcTemplate.update(sql, no);
	}
	
	@Override
	public void minusReply(int no) {
		String sql = "update board set reply=reply-1 where board_no=?";
		jdbcTemplate.update(sql,no);
	}

	@Override
	public int noReply() {
		String sql = "select count(*) from board where replyck='n' and authck='f'";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}
	
	@Override
	public int okReply() {
		String sql = "select count(*) from board where replyck='y' and authck='f'";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}
	
	@Override
	public List<BoardDto> adminboardlist(int start, int end) {
		String sql = "select * from "
				+ "(select rownum rn, A.* from "
				+ "(select * from board where replyck ='n' and authck='f' order by reg asc, reply desc)A) "
				+ "where rn between ? and ?";
		return jdbcTemplate.query(sql, new Object[] {start, end}, mapper);
	}
	
	@Override
	public List<BoardDto> completeReply(int start, int end) {
		String sql = "select * from "
				+ "(select rownum rn, A.* from "
				+ "(select * from board where replyck ='y' and authck='f' order by reg asc, reply desc)A) "
				+ "where rn between ? and ?";
		return jdbcTemplate.query(sql, new Object[] {start, end}, mapper);
	}

	
	@Override
	public List<BoardDto> myQnA(int start, int end, String name) {
		String sql = "select * from "
						+ "(select rownum rn, A.* from "
						+ "(select * from board where email = ? order by replyck asc, reg asc)A)"
					+ " where rn between ? and ?";
		return jdbcTemplate.query(sql, new Object[] {name, start, end},mapper);
	}
	@Override
	public int mylistCnt(String email) {
		String sql = "select count(*) from board where email = ?";
		return jdbcTemplate.queryForObject(sql,new Object[] {email}, Integer.class);
	}
	
	@Override
	public int noticeCnt() {
		String sql = "select count(*) from board where notice is not null";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}
	
	@Override
	public List<BoardDto> notice(int start, int end) {
		String sql = "select * from "
				+ "(select rownum rn, A.* from "
				+ "(select * from board where notice is not null order by reg desc)A)"
			+ " where rn between ? and ?";
		return jdbcTemplate.query(sql, new Object[] {start, end} ,mapper);
	}
}
