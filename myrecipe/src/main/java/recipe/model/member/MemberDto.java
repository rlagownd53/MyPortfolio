package recipe.model.member;

import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberDto { 
	private int no; 
	private String email;
	private String password;
	private String name;
	private int phone;
	private int post;
	private String addr1;
	private String addr2;
	private int mile;
	private String auth;
	private String reg;
	private String telecom;
	
	@Override
	public String toString() {
		return "MemberDto [no=" + no + ", email=" + email + ", password=" + password + ", name=" + name + ", phone="
				+ phone + ", post=" + post + ", addr1=" + addr1 + ", addr2=" + addr2 + ", mile=" + mile + ", auth="
				+ auth + ", reg=" + reg + ", telecom=" + telecom + "]";
	}
	public MemberDto() {
	}
	public MemberDto(ResultSet rs) throws SQLException {
		setNo(rs.getInt("no"));
		setEmail(rs.getString("email"));
		setPassword(rs.getString("password"));
		setName(rs.getString("name"));
		setPhone(rs.getInt("phone"));
		setPost(rs.getInt("post"));
		setAddr1(rs.getString("addr1"));
		setAddr2(rs.getString("addr2"));
		setMile(rs.getInt("mile"));
		setAuth(rs.getString("auth"));
		setReg(rs.getString("reg"));
		setTelecom(rs.getString("telecom"));
	}
	
	public MemberDto(int no, String email, String password, String name, int phone, int post, String addr1,
			String addr2, int mile, String auth, String reg,String telecom) {
		super();
		this.no = no;
		this.email = email;
		this.password = password;
		this.name = name;
		this.phone = phone;
		this.post = post;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.mile = mile;
		this.auth = auth;
		this.reg = reg;
	}
	
	public String getTelecom() {
		return telecom;
	}
	public void setTelecom(String telecom) {
		this.telecom = telecom;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPhone() {
		return phone;
	}
	public void setPhone(int phone) {
		this.phone = phone;
	}
	public int getPost() {
		return post;
	}
	public void setPost(int post) {
		this.post = post;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public int getMile() {
		return mile;
	}
	public void setMile(int mile) {
		this.mile = mile;
	}
	public String getAuth() {
		return auth;
	}
	public void setAuth(String auth) {
		this.auth = auth;
	}
	public String getReg() {
		return reg;
	}
	public void setReg(String reg) {
		this.reg = reg;
	}
	
}
