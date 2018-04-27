package recipe.model.menu;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository(value="mfdao")
public class MenuFileDaoImpl implements MenuFileDao {
	private Logger log = LoggerFactory.getLogger(getClass());
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<MenuFileDto> mapper = (rs, idx)->{
		return new MenuFileDto(rs);
	};
	
	public void add(MenuFileDto mfdto) {
		log.debug("추가할 img 값 확인 : "+ 
				mfdto.getMenu_no()+"/"+ mfdto.getImgtype()+"/"+ mfdto.getFilename()+"/"+ 
				mfdto.getFilesize()+"/"+ mfdto.getFiletype());
		String sql = "select menufile_seq.nextval from dual";
		int no = jdbcTemplate.queryForObject(sql, Integer.class);
		sql = "insert into menufile values(?,?,?,?,?,?)";
		Object[] obj = {
				no, mfdto.getMenu_no(), mfdto.getImgtype(), mfdto.getFilename(), mfdto.getFilesize(), mfdto.getFiletype()
				};
		jdbcTemplate.update(sql, obj);
	}
	
	public boolean update(MenuFileDto mfdto) {
		log.debug("수정할 img 값 확인 : "+ 
				mfdto.getMenu_no()+"/"+ mfdto.getImgtype()+"/"+ mfdto.getFilename()+"/"+ 
				mfdto.getFilesize()+"/"+ mfdto.getFiletype());
		String sql = "select menufile_seq.nextval from dual";
		int no = jdbcTemplate.queryForObject(sql, Integer.class);
		sql = "update menufile set fileno=?, filename=?, filesize=? where Menu_no=? and imgtype=?";
		int res = jdbcTemplate.update(sql,
				no, mfdto.getFilename(), mfdto.getFilesize(), mfdto.getMenu_no(), mfdto.getImgtype());
		log.debug(mfdto.getMenu_no()+"번 메뉴 / 수정 완료 ");
		log.debug("수정 내용 :  "+mfdto.toString());
		return res>0;
	}
	
	public List<MenuFileDto> list() {
		String sql = "select * from menufile order by menu_no desc";
		return jdbcTemplate.query(sql,mapper);
	}
	
	public boolean delete(int no) {
		String sql = "delete menufile where menu_no=?";
		int res = jdbcTemplate.update(sql, no);
		log.debug(no+"번 메뉴 img / 삭제 완료 ");
		return res>0;
	}

	@Override
	public List<MenuFileDto> info(int no) {
		String sql = "select * from menufile where menu_no = ?";
		return jdbcTemplate.query(sql,new Object[] {no}, mapper);
	}
	
}
