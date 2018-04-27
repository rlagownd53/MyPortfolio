package recipe.model.order;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface CartDao {
	boolean cart(Cart cart);
	List<Cart> list(int no_member);
	boolean delete(int no);
	boolean edit(int no, int menu_cnt);
	boolean deleteAll(int no_member);
	Cart select(int no);
}
