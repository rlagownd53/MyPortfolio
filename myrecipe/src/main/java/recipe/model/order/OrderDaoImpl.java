package recipe.model.order;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository("orderDao")
public class OrderDaoImpl implements OrderDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	
	@Override
	public boolean order(Order order, String state) {
		String sql = "insert into menu_order values (order_seq.nextval,?,?,?,?,?,?,?,?,?,?,?,sysdate,?,?,?,?,?,?,?,?)";
		Object[] obj = {
				order.getNo_member(), order.getNo_menu(), order.getOrder_name(),
				order.getTel(), order.getMenu_cnt(), order.getOp1_cnt(), order.getOp2_cnt(),
				order.getOp3_cnt(),order.getPost(), order.getAddr1(), order.getAddr2(), 
				order.getWant_date(),order.getReal_date(), state, order.getComments()
				,order.getTotalprice(), order.getMenu_name(), order.getGroupno(),
				order.getGroupsize()
		};
		int result = jdbcTemplate.update(sql, obj);
		return result>0;
	}

	@Override
	public List<Order> orderInfo(String groupno) {
		String sql = "select * from menu_order where groupno=? order by no_order desc";
		RowMapper<Order> mapper = (rs, index) -> {
			return new Order(rs);
		};
		List<Order> orderList = jdbcTemplate.query(sql, new Object[] {groupno}, mapper);
		return orderList;
	}
	
	
	@Override
	public Order orderList(int no_member) {
		String sql = "select * from menu_order where no_member=? order by no_order desc";
		RowMapper<Order> mapper = (rs, index) -> {
			return new Order(rs);
		};
		
		List<Order> orderList = jdbcTemplate.query(sql, new Object[] {no_member}, mapper);
		return orderList.get(0);
	}
	

	@Override
	public List<Order> olist() {
		RowMapper<Order> mapper = (rs,index)->{
			Order order = new Order(rs);
			return order;
		};
		return jdbcTemplate.query("select * from menu_order", mapper);
	}
	
	@Override
	public boolean complete(int orderNo,String stat) {
		int res = jdbcTemplate.update("update menu_order set stat=? where no_order=?",stat,orderNo);
		return res>0;
	}

	RowMapper<Order> mapper = (rs, index) -> {
		return new Order(rs);
	};
	
	@Override
	public List<Order> myorder(int no_member) {
		String sql = "select * from menu_order where order_date between to_date(add_months(sysdate, -1)) "
				+ "and sysdate and no_member=? order by no_order desc";
		
		List<Order> orderList = jdbcTemplate.query(sql, new Object[] {no_member}, mapper);
		return orderList;
	}

	@Override
	public List<Order> myorder_more(int no_member) {
		String sql = "select * from menu_order where order_date < to_date(add_months(sysdate, -1)) "
				+ "and no_member=? order by no_order desc";
		
		List<Order> orderList = jdbcTemplate.query(sql, new Object[] {no_member}, mapper);
		return orderList;
	}

	@Override
	public boolean cancle(String groupno) {
		String sql = "update menu_order set stat='주문취소' where groupno=?";
		
		int result = jdbcTemplate.update(sql, new Object[] {groupno});
		
		return result>0;
	}

	@Override
	public boolean check(int no_member) {
		String sql = "select * from menu_order where no_member = ?";
		int result = jdbcTemplate.update(sql, new Object[] {no_member});
		return result>0;
	}

	public List<String> groupno(int no_member) {
		String sql = "select DISTINCT groupno from menu_order where no_member=?";
		
		return jdbcTemplate.queryForList(sql,new Object[] {no_member}, String.class);
	}

	
}
