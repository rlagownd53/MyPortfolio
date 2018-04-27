package recipe.model.menu;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface MenuDao {
	int add(MenuDto mdto);
	MenuDto info(int no);
	List<MenuDto> list();
	boolean update(MenuDto mdto);
	boolean delete(int no);
	boolean minus(int menu_no, int menu_cnt);
	boolean plus(int menu_no, int menu_cnt);
}
