package recipe.model.order;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Cart {
	private int no;
	private int no_member;
	private int no_menu;
	private String filename;
	private String menu_name;
	private int menu_price;
	private int menu_cnt;
	private int op1_cnt;
	private int op2_cnt;
	private int op3_cnt;
	private String op1_name;
	private String op2_name;
	private String op3_name;
	private int op1_price;
	private int op2_price;
	private int op3_price;
	
	public Cart() {
		super();
	}
	
	public Cart(ResultSet rs) throws SQLException {
		setNo(rs.getInt("no"));
		setNo_member(rs.getInt("no_member"));
		setNo_menu(rs.getInt("no_menu"));
		setFilename(rs.getString("filename"));
		setMenu_name(rs.getString("menu_name"));
		setMenu_price(rs.getInt("menu_price"));
		setMenu_cnt(rs.getInt("menu_cnt"));
		setOp1_cnt(rs.getInt("op1_cnt"));
		setOp2_cnt(rs.getInt("op2_cnt"));
		setOp3_cnt(rs.getInt("op3_cnt"));
		setOp1_name(rs.getString("op1_name"));
		setOp2_name(rs.getString("op2_name"));
		setOp3_name(rs.getString("op3_name"));
		setOp1_price(rs.getInt("op1_price"));
		setOp2_price(rs.getInt("op2_price"));
		setOp3_price(rs.getInt("op3_price"));
	}
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getNo_member() {
		return no_member;
	}
	public void setNo_member(int no_member) {
		this.no_member = no_member;
	}
	public int getNo_menu() {
		return no_menu;
	}
	public void setNo_menu(int no_menu) {
		this.no_menu = no_menu;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	public int getMenu_price() {
		return menu_price;
	}
	public void setMenu_price(int menu_price) {
		this.menu_price = menu_price;
	}
	public int getMenu_cnt() {
		return menu_cnt;
	}
	public void setMenu_cnt(int menu_cnt) {
		this.menu_cnt = menu_cnt;
	}
	public int getOp1_cnt() {
		return op1_cnt;
	}
	public void setOp1_cnt(int op1_cnt) {
		this.op1_cnt = op1_cnt;
	}
	public int getOp2_cnt() {
		return op2_cnt;
	}
	public void setOp2_cnt(int op2_cnt) {
		this.op2_cnt = op2_cnt;
	}
	public int getOp3_cnt() {
		return op3_cnt;
	}
	public void setOp3_cnt(int op3_cnt) {
		this.op3_cnt = op3_cnt;
	}
	
	public String getOp1_name() {
		return op1_name;
	}

	public void setOp1_name(String op1_name) {
		this.op1_name = op1_name;
	}

	public String getOp2_name() {
		return op2_name;
	}

	public void setOp2_name(String op2_name) {
		this.op2_name = op2_name;
	}

	public String getOp3_name() {
		return op3_name;
	}

	public void setOp3_name(String op3_name) {
		this.op3_name = op3_name;
	}
	

	public int getOp1_price() {
		return op1_price;
	}

	public void setOp1_price(int op1_price) {
		this.op1_price = op1_price;
	}

	public int getOp2_price() {
		return op2_price;
	}

	public void setOp2_price(int op2_price) {
		this.op2_price = op2_price;
	}

	public int getOp3_price() {
		return op3_price;
	}

	public void setOp3_price(int op3_price) {
		this.op3_price = op3_price;
	}

	@Override
	public String toString() {
		return "Cart [no=" + no + ", no_member=" + no_member + ", no_menu=" + no_menu + ", filename=" + filename
				+ ", menu_name=" + menu_name + ", menu_price=" + menu_price + ", menu_cnt=" + menu_cnt + ", op1_cnt="
				+ op1_cnt + ", op2_cnt=" + op2_cnt + ", op3_cnt=" + op3_cnt + ", op1_name=" + op1_name + ", op2_name="
				+ op2_name + ", op3_name=" + op3_name + ", op1_price=" + op1_price + ", op2_price=" + op2_price
				+ ", op3_price=" + op3_price + "]";
	}

}
