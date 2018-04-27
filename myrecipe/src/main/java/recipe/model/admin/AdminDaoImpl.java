package recipe.model.admin;

import java.text.SimpleDateFormat;
import java.time.Month;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import recipe.model.member.MemberDto;
import recipe.model.order.Order;

@Repository(value="adao")
public class AdminDaoImpl implements AdminDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	private Logger log = LoggerFactory.getLogger(getClass());
	public String today() {
		Date d = new Date();
        String s = d.toString();
        SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
		return sdf.format(d);
	}
	public String today2() {
		Date d = new Date();
        String s = d.toString();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy년M월d일");
		return sdf.format(d);
	}
	public String lastmonth() {
		Calendar cal = Calendar.getInstance();
		cal.add(cal.MONTH,-1);
        SimpleDateFormat sdf = new SimpleDateFormat("MM");
        String mon = sdf.format(cal.getTime());
		return mon;
	}
	public String tolastmonth() {
		Calendar cal = Calendar.getInstance();
		cal.add(cal.MONTH,-2);
        SimpleDateFormat sdf = new SimpleDateFormat("MM");
        String mon = sdf.format(cal.getTime());
		return mon;
	}
	//오더리스트를 받아 원하는 데이터를 가공
	public AdminDto ProcessingOrder(List<Order> Order){
		AdminDto dto = new AdminDto();
		int lmmoney = 0;
		int todaymoney = 0;
		int neworder = 0;
		int tommoney = 0;
		int tolmmoney = 0;
		for (Order data:Order) {
			//신규 주문
			if(data.getStat().equals("입금 확인중") || data.getStat().equals("입금 완료")) {
				neworder+=1;
			}
			//오늘 매출
			if(data.getOrder_date().equals(today())) {
				todaymoney+= data.getTotalprice();
			}
			//이번달 매출
			if(data.getOrder_date().substring(3,5).equals(today().substring(3,5))) {
				tommoney+= data.getTotalprice();
			}
			//저번달 매출
			if(data.getOrder_date().substring(3,5).equals(lastmonth())) {
				lmmoney += data.getTotalprice();
			}
			//그전달 매출
			if(data.getOrder_date().substring(3,5).equals(tolastmonth())) {
				tolmmoney += data.getTotalprice();
			}}
		dto.setToday(today2());
		dto.setTmoney(todaymoney);
		dto.setTmmoney(tommoney);
		dto.setNeworder(neworder);
		dto.setLmmoney(lmmoney);
		dto.setTolmmoney(tolmmoney);
		return dto;
	}
	public AdminDto ProcessingMember(List<MemberDto> memberdto){
		AdminDto dto = new AdminDto();
		int tojoin = 0;
		int lastjoin = 0;
		int tolastjoin = 0;
		for(MemberDto member:memberdto) {
			//이번달 가입자
			if(member.getReg().substring(5,7).equals(today().substring(3,5))) {
				tojoin+=1;
			}
			//지난달 가입자
			if(member.getReg().substring(5,7).equals(lastmonth())) {
				lastjoin+=1;
			}
			//지지난달 가입자
			if(member.getReg().substring(5,7).equals(tolastmonth())) {
				tolastjoin+=1;
			}
		}
		dto.setTojoin(tojoin);
		dto.setLastjoin(lastjoin);
		dto.setTolastjoin(tolastjoin);
		return dto;
	}
	public List<AdminDto> ProcessingMenu() {
		String sql = "select menu_name, count(menu_name) from menu_order group by menu_name order by count(menu_name) desc";
		RowMapper<AdminDto> mapper = (rs,index)->{
			AdminDto dto = new AdminDto();
			dto.setMenu_name(rs.getString("menu_name"));
			dto.setMenu_count(rs.getInt("count(menu_name)"));
			return dto;
		};
		return jdbcTemplate.query(sql,mapper);
	}
}
