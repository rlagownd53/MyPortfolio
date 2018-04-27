package recipe.model.menu;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartHttpServletRequest;
public class MenuDto {
	private Logger log = LoggerFactory.getLogger(getClass());
	
	private int menu_no;
	private String type;
	private String name;
	private int price;
	private String op1_name;
	private int op1_price;
	private String op2_name;
	private int op2_price;
	private String op3_name;
	private int op3_price;
	private String stat;
	private String stat_grade;
	private String reg;
	private int stock;


	//	public MenuDto(String name, int price, String type, 
//			String op1_name, int op1_price, String op2_name, int op2_price, String op3_name, int op3_price,
//			String stat, String stat_grade) {
//		super();
//		log.info("mdto 셋팅");
//		this.name = name;
//		this.price = price;
//		this.type = type;
//		this.op1_name = op1_name;
//		this.op1_price = op1_price;
//		this.op2_name = op2_name;
//		this.op2_price = op2_price;
//		this.op3_name = op3_name;
//		this.op3_price = op3_price;
//		this.stat = stat;
//		this.stat_grade = stat_grade;
//	}
//	public MenuDto() {
//		log.info("기본 방문");
//	}
	public MenuDto(ResultSet rs) throws SQLException {
		setMenu_no(rs.getInt("menu_no"));
		setName(rs.getString("name"));
		setPrice(rs.getInt("price"));
		setType(rs.getString("type"));
		setOp1_name(rs.getString("op1_name"));
		setOp1_price(rs.getInt("op1_price"));
		setOp2_name(rs.getString("op2_name"));
		setOp2_price(rs.getInt("op2_price"));
		setOp3_name(rs.getString("op3_name"));
		setOp3_price(rs.getInt("op3_price"));
		setStat(rs.getString("stat"));
		setStat_grade(rs.getString("stat_grade"));
		setReg(rs.getString("reg"));
		setStock(rs.getInt("stock"));
	}

	public MenuDto(MultipartHttpServletRequest req) throws SQLException {
		log.debug("req 받아서 셋터 하는 중");
		String no = req.getParameter("no");
		if(no == null || no == "") no = "0";
		setMenu_no(no==("0")?0:Integer.parseInt(no));
		setName(req.getParameter("name"));
		setType(req.getParameter("type"));
		String price = req.getParameter("price");
		setPrice(price==null?0:Integer.parseInt(price));
		
		setOp1_name(req.getParameter("op1_name"));
		String op1_price = (req.getParameter("op1_price"));
		setOp1_price(op1_price==""?0:Integer.parseInt(op1_price));
		
		setOp2_name(req.getParameter("op2_name"));
		String op2_price = (req.getParameter("op2_price"));
		setOp2_price(op2_price==""?0:Integer.parseInt(op2_price));
		
		setOp3_name(req.getParameter("op3_name"));
		String op3_price = (req.getParameter("op3_price"));
		setOp3_price(op3_price==""?0:Integer.parseInt(op3_price));
		
		setStat(req.getParameter("stat"));
		setStat_grade(req.getParameter("stat_grade"));
		
		String stock = req.getParameter("stock");
		if(stock == null || stock == "") stock ="0";
		setStock(Integer.parseInt(stock));
	}
	
	
	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}
	public int getMenu_no() {
		return menu_no;
	}
	public void setMenu_no(int menu_no) {
		this.menu_no = menu_no;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getOp1_name() {
		return op1_name;
	}
	public void setOp1_name(String op1_name) {
		this.op1_name = op1_name;
	}
	public int getOp1_price() {
		return op1_price;
	}
	public void setOp1_price(int op1_price) {
		this.op1_price = op1_price;
	}
	public String getOp2_name() {
		return op2_name;
	}
	public void setOp2_name(String op2_name) {
		this.op2_name = op2_name;
	}
	public int getOp2_price() {
		return op2_price;
	}
	public void setOp2_price(int op2_price) {
		this.op2_price = op2_price;
	}
	public String getOp3_name() {
		return op3_name;
	}
	public void setOp3_name(String op3_name) {
		this.op3_name = op3_name;
	}
	public int getOp3_price() {
		return op3_price;
	}
	public void setOp3_price(int op3_price) {
		this.op3_price = op3_price;
	}
	public String getStat() {
		return stat;
	}
	public void setStat(String stat) {
		this.stat = stat;
	}
	public String getStat_grade() {
		return stat_grade;
	}
	public void setStat_grade(String stat_grade) {
		this.stat_grade = stat_grade;
	}
	public String getReg() {
		return reg;
	}
	public void setReg(String reg) {
		long time = System.currentTimeMillis(); 
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd");
		String sysdate = dayTime.format(new Date(time));
		String indate = reg.substring(0,10);
		if(indate.equals(sysdate)){
//			log.debug("오늘 등록했습니다. "+indate);
			this.reg = reg.substring(11, reg.length()-2);
		}else {
//			log.debug("reg : "+reg +" / sysdate : "+sysdate);
			this.reg = indate;
		}
	}

	@Override
	public String toString() {
		return "MenuDto [menu_no=" + menu_no + ", type=" + type + ", name=" + name + ", price=" + price + ", op1_name="
				+ op1_name + ", op1_price=" + op1_price + ", op2_name=" + op2_name + ", op2_price=" + op2_price
				+ ", op3_name=" + op3_name + ", op3_price=" + op3_price + ", stat=" + stat + ", stat_grade="
				+ stat_grade + ", reg=" + reg + ", stock=" + stock + "]";
	}

	
	
}
