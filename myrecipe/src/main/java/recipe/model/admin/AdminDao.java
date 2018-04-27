package recipe.model.admin;

import java.util.List;

import org.springframework.stereotype.Repository;

import recipe.model.order.Order;

@Repository
public interface AdminDao {
	AdminDto ProcessingOrder(List<Order> Order);
}
