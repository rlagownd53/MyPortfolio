package recipe.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import recipe.model.admin.AdminDaoImpl;
import recipe.model.admin.AdminDto;
import recipe.model.board.BoardDao;
import recipe.model.board.BoardDto;
import recipe.model.member.MemberDaoImpl;
import recipe.model.member.MemberDto;
import recipe.model.menu.MenuDao;
import recipe.model.menu.MenuDto;
import recipe.model.order.Order;
import recipe.model.order.OrderDaoImpl;

@Controller
public class AdminController {
	private Logger log = LoggerFactory.getLogger(getClass());
	@Autowired
	private OrderDaoImpl orderDao;//주문 기능 임플

	@Autowired
	private MemberDaoImpl memberDaoImpl; // 회원 기능 임플
	
	@Autowired
	private MenuDao mdao; //메뉴 기능 임플
	
	@Autowired
	private AdminDaoImpl adao;//관리자 기능 임플
	
	@Autowired
	private BoardDao bdao;	// 게시판
	
	@RequestMapping("/admin")
	public String AdminMenu(Model model) {
		//오늘 매출 , 신규주문 , 이번달 매출 저번달 매출 , 메뉴별 판매량 ,월별 판매량 구분
		log.info("작동중 확인");
		List<Order> olist = orderDao.olist();
		AdminDto orderdto = adao.ProcessingOrder(olist);
		model.addAttribute("orderlist",orderdto);
		//신규회원
		List<MemberDto> memberlist = memberDaoImpl.list();
		AdminDto memberdto = adao.ProcessingMember(memberlist);
		model.addAttribute("memberdto",memberdto);
		//미답변 문의 글 수
		int noreply=bdao.noReply();
		model.addAttribute("noreply",noreply);
		//메뉴 판매량
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		List<AdminDto> menu_count = adao.ProcessingMenu();
		model.addAttribute("menu",menu_count);
		return "admin/adminmenu";
	}
	//회원 리스트
	@RequestMapping("/memberlist")
	public String List(Model model) {
		List<MemberDto> list = memberDaoImpl.list();
		model.addAttribute("memberlist", list);
		return "admin/memberlist";
	}
	//신규 주문 및 배송중 리스트
	@RequestMapping("/olist")
	public String olist(Model model) {
		List<Order> olist = orderDao.olist();
		model.addAttribute("olist", olist);
		return "admin/orderlist";
	}
	//배송이 완료된 리스트
	@RequestMapping("/olist2")
	public String olist2(Model model) {
		List<Order> olist = orderDao.olist();
		model.addAttribute("olist", olist);
		return "admin/orderlist2";
	}
	//주문 상태값 변경 메소드
	@RequestMapping(value = "/complete", method = RequestMethod.POST)
	public String complete(Model model,@RequestParam int orderNo,@RequestParam String orderSt) {
		String stat;
		 switch (orderSt) {
		    case "입금 확인중" : stat = "입금 완료"; break;
		    case "입금 완료" : stat = "배송중"; break;
		    default : stat = "배송완료"; break;
		  }
		orderDao.complete(orderNo,stat);
		List<Order> olist = orderDao.olist();
		model.addAttribute("olist", olist);
		return "admin/orderlist";
	}
	//주문 상태값 변경 메소드
		@RequestMapping(value = "/complete2", method = RequestMethod.POST)
		public String complete2(Model model,@RequestParam int orderNo,@RequestParam String orderSt) {
			orderDao.complete(orderNo,orderSt);
			List<Order> olist = orderDao.olist();
			model.addAttribute("olist", olist);
			return "admin/orderlist";
		}
	
	//메뉴 관리 리스트 이동
	@RequestMapping("mmodi")
	public String MenuModi(Model model) {
		List<MenuDto> mdto = mdao.list();
		model.addAttribute("mdto", mdto);
		return "admin/menuModi";
	}
	//문의 목록 리스트로 이동
		@RequestMapping("mnqlist")
		public String qnalist(HttpServletRequest req, Model model) {
			String pageStr = req.getParameter("page");
			int pageNo;
			try {
				pageNo = Integer.parseInt(pageStr);
				if(pageNo <=0) throw new Exception();
			}catch(Exception e) {
				pageNo=1;
			}
			int boardSize = 15;
			int boardCount = bdao.noReply();
			
			int start = boardSize * pageNo - boardSize +1;
			int end = start + boardSize -1;
			if(end > boardCount) end = boardCount;
			
			List<BoardDto> bdto = bdao.adminboardlist(start, end);
			
			int blockSize = 3;
			int blockTotal = (boardCount + boardSize -1) / boardSize;
			int startBlock = (pageNo-1)/blockSize*blockSize+1;
			int endBlock = startBlock + blockSize-1;
			if(endBlock > blockTotal) endBlock = blockTotal;
			
			model.addAttribute("bdto", bdto);
			model.addAttribute("startBlock",startBlock);
			model.addAttribute("endBlock",endBlock);
			model.addAttribute("pageNo",pageNo);
			model.addAttribute("blockTotal",blockTotal);
			model.addAttribute("n", boardCount);
			model.addAttribute("replycnt",boardCount);
			return "admin/mnqlist";
		}
		
		@RequestMapping("mncomplete")
		public String completeReply(HttpServletRequest req, Model model) {
			String pageStr = req.getParameter("page");
			int pageNo;
			try {
				pageNo = Integer.parseInt(pageStr);
				if(pageNo <=0) throw new Exception();
			}catch(Exception e) {
				pageNo=1;
			}
			int boardSize = 15;
			int boardCount = bdao.okReply();
			
			int start = boardSize * pageNo - boardSize +1;
			int end = start + boardSize -1;
			if(end > boardCount) end = boardCount;
			
			List<BoardDto> bdto = bdao.completeReply(start, end);
			
			int blockSize = 3;
			int blockTotal = (boardCount + boardSize -1) / boardSize;
			int startBlock = (pageNo-1)/blockSize*blockSize+1;
			int endBlock = startBlock + blockSize-1;
			if(endBlock > blockTotal) endBlock = blockTotal;
			
			model.addAttribute("bdto", bdto);
			model.addAttribute("startBlock",startBlock);
			model.addAttribute("endBlock",endBlock);
			model.addAttribute("pageNo",pageNo);
			model.addAttribute("blockTotal",blockTotal);
			model.addAttribute("replycnt",boardCount);
			return "admin/completeReply";
		}
}
