package recipe.model.admin;

public class AdminDto {
	private int tmoney;
	private int neworder;
	private int tmmoney;
	private int lmmoney;
	private int tolmmoney;
	private String today;
	private int tojoin;
	private int lastjoin;
	private int tolastjoin;
	private String menu_name;
	private int menu_count;
	
	@Override
	public String toString() {
		return "AdminDto [tmoney=" + tmoney + ", neworder=" + neworder + ", tmmoney=" + tmmoney + ", lmmoney=" + lmmoney
				+ ", today=" + today + "]";
	}

	public AdminDto() {
	}
	
	public String getMenu_name() {
		return menu_name;
	}

	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}

	public int getMenu_count() {
		return menu_count;
	}

	public void setMenu_count(int menu_count) {
		this.menu_count = menu_count;
	}

	public int getTojoin() {
		return tojoin;
	}

	public void setTojoin(int tojoin) {
		this.tojoin = tojoin;
	}

	public int getLastjoin() {
		return lastjoin;
	}

	public void setLastjoin(int lastjoin) {
		this.lastjoin = lastjoin;
	}

	public int getTolastjoin() {
		return tolastjoin;
	}

	public void setTolastjoin(int tolastjoin) {
		this.tolastjoin = tolastjoin;
	}

	public int getTolmmoney() {
		return tolmmoney;
	}


	public void setTolmmoney(int tolmmoney) {
		this.tolmmoney = tolmmoney;
	}


	public int getLmmoney() {
		return lmmoney;
	}


	public void setLmmoney(int lmmoney) {
		this.lmmoney = lmmoney;
	}


	public int getTmmoney() {
		return tmmoney;
	}


	public void setTmmoney(int tmmoney) {
		this.tmmoney = tmmoney;
	}


	public String getToday() {
		return today;
	}


	public void setToday(String today) {
		this.today = today;
	}


	public int getNeworder() {
		return neworder;
	}


	public void setNeworder(int neworder) {
		this.neworder = neworder;
	}


	public int getTmoney() {
		return tmoney;
	}

	public void setTmoney(int tmoney) {
		this.tmoney = tmoney;
	}
}
