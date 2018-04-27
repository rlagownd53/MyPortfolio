package recipe.model.order;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface OrderDao {
	boolean order(Order order, String state);
	List<Order> myorder(int no_member);
	List<Order> myorder_more(int no_member);
	Order orderList(int no_member);
	List<Order> orderInfo(String groupno);
	List<Order> olist();
	boolean complete(int orderNo,String stat);
	boolean cancle(String groupno);
	boolean check(int no_member);
	List<String> groupno(int no_member);
}
