package recipe.model.member;

import java.util.List;
import java.util.Random;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import recipe.security.securityimpl;

@Repository(value = "memberDao")
public class MemberDaoImpl implements MemberDao {
	private Logger log = LoggerFactory.getLogger(getClass());
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private securityimpl sec;

	@Override
	public void sign(MemberDto dto) {
		String sql = "insert into member values(member_seq.nextval,?,?,?,?,?,?,?,0,'일반',sysdate,?)";
		Object[] args = { dto.getEmail(), sec.ChangePw(dto.getPassword()), dto.getName(), dto.getPhone(), dto.getPost(),
				dto.getAddr1(), dto.getAddr2(), dto.getTelecom() };
		jdbcTemplate.update(sql, args);

		sql = "insert into mysecurity values(?,?,'true','ROLE_user','0')";
		
		jdbcTemplate.update(sql, new Object[] { dto.getEmail(), dto.getPassword() });
	}

	private RowMapper<MemberDto> mapper = (rs, index) -> {
		return new MemberDto(rs);
	};

	@Override
	public boolean login(String email, String password) {
		String origin = null;
		try {
			origin = jdbcTemplate.queryForObject("select password from member where email=?",new Object[] {email},String.class);
		}catch(Exception e) {
			e.printStackTrace();
		}
		Random rnd = new Random();
		StringBuffer buf = new StringBuffer();
		for (int i = 0; i < 20; i++) {
			if (rnd.nextBoolean()) {
				buf.append((char) ((int) (rnd.nextInt(26)) + 97));
			} else {
				buf.append((rnd.nextInt(10)));
			}
		}
		
		jdbcTemplate.update("update mysecurity set CERTIFICATION=? where username=?", new Object[] { buf, email });
		return origin.matches(sec.ChangePw(password));
	}

	@Override
	public List<MemberDto> info(String email) {
		RowMapper<MemberDto> mapper = (rs, index) -> {
			MemberDto dto = new MemberDto(rs);
			return dto;
		};
		return jdbcTemplate.query("select * from member where email=?", new Object[] { email }, mapper);
	}

	@Override
	public boolean edit(MemberDto dto) {
		String sql = "update member set password=?, name=?, phone=?,telecom=?, post=?, addr1=?, addr2=? where email=?";
		int res = jdbcTemplate.update(sql, sec.ChangePw(dto.getPassword()), dto.getName(), dto.getPhone(),
				dto.getTelecom(), dto.getPost(), dto.getAddr1(), dto.getAddr2(), dto.getEmail());
		sql = "update mysecurity set password=? where username=?";
		jdbcTemplate.update(sql, new Object[] { dto.getPassword(), dto.getEmail() });
		return res > 0;
	}

	@Override
	public boolean signcheck(String email) {
		Integer origin = jdbcTemplate.queryForObject("select count(email) from member where email=?", Integer.class,
				new Object[] { email });
		return origin != null && origin > 0;
	}

	@Override
	public List<MemberDto> list() {
		RowMapper<MemberDto> mapper = (rs, index) -> {
			MemberDto dto = new MemberDto(rs);
			return dto;
		};
		return jdbcTemplate.query("select * from member", mapper);
	}
	public void logout(String username) {
		String sql = "update mysecurity set CERTIFICATION='0' where username=?";
		jdbcTemplate.update(sql,new Object[] {username});
	}
}