package recipe.model.menu;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface MenuFileDao {
	public void add(MenuFileDto mfdto);
	public List<MenuFileDto> list();
	public List<MenuFileDto> info(int no);
	public boolean update(MenuFileDto mfdto);
	public boolean delete(int no);
}
