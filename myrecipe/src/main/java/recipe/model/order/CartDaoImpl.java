package recipe.model.order;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository("cartDao")
public class CartDaoImpl implements CartDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	RowMapper<Cart> mapper = (rs, index) -> {
		return new Cart(rs);
	};
	
	@Override
	public boolean cart(Cart cart) {
		String sql = "select * from cart where no_member=? and no_menu=?";
		boolean result= jdbcTemplate.update(sql, new Object[] { cart.getNo_member(), cart.getNo_menu() })>0;

		if (result) {
			Cart c = jdbcTemplate.query(sql, new Object[] { cart.getNo_member(), cart.getNo_menu() }, mapper).get(0);
			sql = "update cart set menu_cnt=menu_cnt+?, op1_cnt=op1_cnt+?, op2_cnt=op2_cnt+?, "
					+ "op3_cnt=op3_cnt+? where no=?";
			return jdbcTemplate.update(sql, new Object[] {cart.getMenu_cnt(),cart.getOp1_cnt(), 
					cart.getOp2_cnt(), cart.getOp3_cnt(), c.getNo() }) > 0;
			
		} else {
			sql = "insert into cart values(cart_seq.nextval,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

			Object[] obj = { cart.getNo_member(), cart.getNo_menu(), cart.getFilename(), cart.getMenu_name(),
					cart.getMenu_price(), cart.getMenu_cnt(), cart.getOp1_cnt(), cart.getOp2_cnt(), cart.getOp3_cnt(),
					cart.getOp1_name(), cart.getOp2_name(), cart.getOp3_name(), cart.getOp1_price(), cart.getOp2_price(),
					cart.getOp3_price()};

			int res = jdbcTemplate.update(sql, obj);

			return res > 0;
		}
	}

	@Override
	public List<Cart> list(int no_member) {
		String sql = "select * from cart where no_member=? order by no";

		return jdbcTemplate.query(sql, new Object[] { no_member }, mapper);

	}

	@Override
	public boolean delete(int no) {
		String sql = "delete from cart where no=?";
		return jdbcTemplate.update(sql, new Object[] { no }) > 0;
	}

	@Override
	public boolean edit(int no, int menu_cnt) {
		String sql = "update cart set menu_cnt=? where no=?";
		return jdbcTemplate.update(sql, new Object[] { menu_cnt, no }) > 0;
	}

	@Override
	public boolean deleteAll(int no_member) {
		String sql = "delete from cart where no_member=?";
		return jdbcTemplate.update(sql, new Object[] { no_member }) > 0;
	}

	@Override
	public Cart select(int no) {
		String sql = "select * from cart where no=?";

		return jdbcTemplate.query(sql, new Object[] { no }, mapper).get(0);
	}

}
