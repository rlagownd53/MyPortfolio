package recipe.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import recipe.model.member.MemberDaoImpl;
import recipe.model.member.MemberDto;
import recipe.model.menu.MenuDaoImpl;
import recipe.model.menu.MenuDto;
import recipe.model.menu.MenuFileDao;
import recipe.model.menu.MenuFileDaoImpl;
import recipe.model.menu.MenuFileDto;
import recipe.model.order.Cart;
import recipe.model.order.CartDao;
import recipe.model.order.CartDaoImpl;
import recipe.model.order.Order;
import recipe.model.order.OrderDaoImpl;

@Controller
public class OrderController {
   private Logger log = LoggerFactory.getLogger(getClass());

   @Autowired
   private OrderDaoImpl orderDao;

   @Autowired
   private MemberDaoImpl memberDao; 

   @Autowired
   private MenuDaoImpl menuDao; 

   @Autowired
   private MenuFileDaoImpl mfdao;

   @Autowired
   private CartDaoImpl cartDao;

   // 주문페이지
   @RequestMapping("/order")
   public String order(@RequestParam int no, Model m) {
      MenuDto menuInfo = menuDao.info(no);
      List<MenuFileDto> mfInfo = mfdao.list();

      m.addAttribute("menuInfo", menuInfo);
      m.addAttribute("mfdto", mfInfo);
      return "order/order";
   }

   @RequestMapping(value = "/order", method = RequestMethod.POST)
   public String order(int menu_cnt, Model m, HttpServletRequest request, int no_menu,
         @RequestParam String filename) {
      //로그인 정보 확인
      Cookie[] list = request.getCookies();
      for (Cookie c : list) {
         if (c.getName().equals("memberEmail")) {
            String email = c.getValue();

            if (request.getParameter("paybtn") != null) {
               String op1_cnt = request.getParameter("op1_cnt");
               String op2_cnt = request.getParameter("op2_cnt");
               String op3_cnt = request.getParameter("op3_cnt");
               
               log.info("옵션 수량 : " + op1_cnt + " " + op2_cnt + " " + op3_cnt);
               
               m.addAttribute("menu_cnt", menu_cnt);
               m.addAttribute("no_menu", no_menu);
               m.addAttribute("filename", filename);
               
               //재고 차감
               menuDao.minus(no_menu, menu_cnt);
 
               if(op1_cnt != null) {
                  m.addAttribute("op1_cnt" , op1_cnt);
               }
               if(op2_cnt != null)
                  m.addAttribute("op2_cnt" , op2_cnt);
               if(op3_cnt != null)
                  m.addAttribute("op3_cnt" , op3_cnt);
               
               return "redirect:write";
            } else if (request.getParameter("cartbtn") != null) {
               MemberDto memberInfo = memberDao.info(email).get(0);
               MenuDto menuInfo = menuDao.info(no_menu);

               Cart cart = new Cart();
               cart.setNo_member(memberInfo.getNo());
               cart.setNo_menu(no_menu);
               cart.setFilename(filename);
               cart.setMenu_name(menuInfo.getName());
               cart.setMenu_price(menuInfo.getPrice());
               cart.setMenu_cnt(menu_cnt);
               
               String op1_cnt = request.getParameter("op1_cnt");
               String op2_cnt = request.getParameter("op2_cnt");
               String op3_cnt = request.getParameter("op3_cnt");
               
               if(op1_cnt != null) 
                  cart.setOp1_cnt(Integer.parseInt(op1_cnt));
               
               if(op2_cnt != null)
                  cart.setOp2_cnt(Integer.parseInt(op2_cnt));
               if(op3_cnt != null)
                  cart.setOp3_cnt(Integer.parseInt(op3_cnt));
               
               cart.setOp1_name(request.getParameter("op1_name"));
               cart.setOp2_name(request.getParameter("op2_name"));
               cart.setOp3_name(request.getParameter("op3_name"));
               
               cart.setOp1_price(Integer.parseInt(request.getParameter("op1_price")));
               cart.setOp2_price(Integer.parseInt(request.getParameter("op2_price")));
               cart.setOp3_price(Integer.parseInt(request.getParameter("op3_price")));

               boolean res = cartDao.cart(cart);

               return "redirect:cart";
            }
         }
      }
      return "member/login";
   }

   // 주문 목록 페이지
   @RequestMapping("/orderlist")
   public String orderList(HttpServletRequest request, Model m) {
      Cookie[] list = request.getCookies();
      String email = null;
      for (Cookie c : list) {
         if (c.getName().equals("memberEmail")) {
            email = c.getValue();
         }
      }
      MemberDto memberInfo = memberDao.info(email).get(0);
      List<Order> orderList = orderDao.myorder(memberInfo.getNo());
      HashMap<String , Integer> menulist = new HashMap<String , Integer>();
      String target = null;
      int totalprice = 0;
      for (Order gruop : orderList) {
         target = gruop.getGroupno();
         totalprice = gruop.getTotalprice();
         if(menulist.containsKey(target)) {
            menulist.put(target, menulist.get(target)+gruop.getTotalprice());
         }
         if(!menulist.containsKey(target)) {
            menulist.put(gruop.getGroupno(),gruop.getTotalprice());
         }
      }
      log.info(menulist.toString());
      m.addAttribute("menulist", menulist);
      m.addAttribute("orderList", orderList);
      m.addAttribute("no_member", memberInfo.getNo());
      return "order/orderlist";
   }

   // orderlist - 30일 이후 주문 목록
   @RequestMapping(value = "/html", method = RequestMethod.POST)
   public String getOrderlistHtml(@RequestParam(value = "no_member") int no_member, Model m) {
      List<Order> orderList = orderDao.myorder_more(no_member);

      m.addAttribute("orderList", orderList);

      return "order/html";
   }

   // 주문서 작성 페이지
   @RequestMapping("/write")
   public String write(HttpServletRequest request, int menu_cnt, Model m, 
         int no_menu) {
      
	  String filename = request.getParameter("filename");
      String op1_cnt = request.getParameter("op1_cnt");
      String op2_cnt = request.getParameter("op2_cnt");
      String op3_cnt = request.getParameter("op3_cnt");
      
      if(op1_cnt != null) {
         m.addAttribute("op1_cnt" , op1_cnt);
      }
      if(op2_cnt != null)
         m.addAttribute("op2_cnt" , op2_cnt);
      if(op3_cnt != null)
         m.addAttribute("op3_cnt" , op3_cnt);

      String email = null;
      Cookie[] list = request.getCookies();
      for (Cookie c : list) {
         if (c.getName().equals("memberEmail")) {
            email = c.getValue();
            break;
         }
      }

      if (email != null) {
         MemberDto memberInfo = memberDao.info(email).get(0);
         MenuDto menuInfo = menuDao.info(no_menu);

         // 최근 배송지 정보 첨부
         if (orderDao.check(memberInfo.getNo())) {
            Order recentOrder = orderDao.orderList(memberInfo.getNo());
            m.addAttribute("recentOrder", recentOrder);
         }

         m.addAttribute("memberInfo", memberInfo);
         m.addAttribute("menuInfo", menuInfo);
         m.addAttribute("filename", filename);
      }
      m.addAttribute("menu_cnt", menu_cnt);

      return "order/write";
   }

   @RequestMapping(value = "/write", method = RequestMethod.POST)
   public String write(HttpServletRequest request, HttpSession session, int no_member, int no_menu, int menu_cnt) {
      
      
      String op1_cnt = request.getParameter("op1_cnt");
      String op2_cnt = request.getParameter("op2_cnt");
      String op3_cnt = request.getParameter("op3_cnt");
      
      
      Date today = new Date();
      SimpleDateFormat f = new SimpleDateFormat("yyyyMMddHHmmss");
      String current = f.format(today);

      List<Order> orderList = new ArrayList<>();
      // request�젙蹂대�� session�뿉 ���옣�빐�꽌 session�쑝濡� �꽆寃⑥� �썑, �떎�떆 �궘�젣!
      Order order = new Order();
      order.setNo_member(no_member);
      order.setNo_menu(no_menu);// 硫붾돱 踰덊샇(�엫�떆)
      order.setOrder_name(request.getParameter("name"));
      order.setTel(request.getParameter("tel"));
      order.setMenu_cnt(menu_cnt);
      order.setPost(request.getParameter("post"));
      order.setAddr1(request.getParameter("addr1"));
      order.setAddr2(request.getParameter("addr2"));
      order.setWant_date(request.getParameter("want_date"));
      order.setComments(request.getParameter("comments"));
      MenuDto dto = menuDao.info(no_menu);
      int totalprice = menu_cnt * dto.getPrice();
      if(op1_cnt != null) {
         order.setOp1_cnt(Integer.parseInt(request.getParameter("op1_cnt")));
         totalprice += Integer.parseInt(request.getParameter("op1_cnt"))* dto.getOp1_price();
      }
      if(op2_cnt != null) {
         order.setOp2_cnt(Integer.parseInt(request.getParameter("op2_cnt")));
         totalprice += Integer.parseInt(request.getParameter("op2_cnt"))* dto.getOp2_price();
      }
      if(op3_cnt != null) {
         order.setOp3_cnt(Integer.parseInt(request.getParameter("op3_cnt")));
         totalprice += Integer.parseInt(request.getParameter("op3_cnt"))* dto.getOp3_price();
      }
      order.setTotalprice(totalprice);
      order.setMenu_name(request.getParameter("menu_name"));
      order.setGroupno(current + no_member);
      
      String state = "입금 확인중";
      orderDao.order(order, state);

      return "redirect:orderlist";
   }

   // 장바구니 페이지
   @RequestMapping("/cart")
   public String cart(HttpServletRequest request, Model m) {

      String email = null; 
      Cookie[] list = request.getCookies();
      for (Cookie c : list) {
         if (c.getName().equals("memberEmail")) {
            email = c.getValue();
            break;
         }
      }

      if (email != null) {
         MemberDto memberInfo = memberDao.info(email).get(0);
         List<Cart> cartList = cartDao.list(memberInfo.getNo());

         m.addAttribute("cartList", cartList);
         m.addAttribute("no_member", memberInfo.getNo());

         return "order/cart";
      }

      return "member/login";
   }

   @RequestMapping(value = "/cart", method = RequestMethod.POST)
   public String addOrder(Model m, HttpServletRequest request) {
      String[] no = request.getParameterValues("del_check");
      m.addAttribute("no", no);
      return "redirect:write2";
   }

   // 장바구니에서 주문서 작성으로 이동할 때
   @RequestMapping("/write2")
   public String write2(@RequestParam String[] no, Model m, HttpServletRequest request) {
      List<Cart> cartList = new ArrayList<>();
      m.addAttribute("no", no);//장바구니 시퀀스 번호 배열 전송
      for (String sel_no : no) {
         Cart c = cartDao.select(Integer.parseInt(sel_no));
         menuDao.minus(c.getNo_menu(), c.getMenu_cnt()); //재고 차감
         cartList.add(c);
      }
      String email = null; 
      Cookie[] list = request.getCookies();
      for (Cookie c : list) {
         if (c.getName().equals("memberEmail")) {
            email = c.getValue();
            break;
         }
      }
      if (email != null) {
         MemberDto memberInfo = memberDao.info(email).get(0);
         m.addAttribute("memberInfo", memberInfo);
      }
      m.addAttribute("cartList", cartList);
      /* log.info(cartList.toString()); */
      return "order/write2";
   }

   @RequestMapping(value = "/write2", method = RequestMethod.POST)
   public String write2(@RequestParam String[] no, HttpServletRequest request) {

      Date today = new Date();
      SimpleDateFormat f = new SimpleDateFormat("yyyyMMddHHmmss");
      String current = f.format(today);
      log.info(current);

      Order order = new Order();
      order.setGroupno(current + request.getParameter("no_member"));// 洹몃９踰덊샇 : �쁽�옱 �궇吏� + 硫ㅻ쾭踰덊샇
      order.setNo_member(Integer.parseInt(request.getParameter("no_member")));
      order.setOrder_name(request.getParameter("name"));
      order.setTel(request.getParameter("tel"));
      order.setPost(request.getParameter("post"));
      order.setAddr1(request.getParameter("addr1"));
      order.setAddr2(request.getParameter("addr2"));
      order.setWant_date(request.getParameter("want_date"));
      String state = "입금 확인중";
      order.setComments(request.getParameter("comments"));
      List<Cart> cartList = new ArrayList<>();
      for (String sel_no : no) {
         Cart c = cartDao.select(Integer.parseInt(sel_no));
         cartList.add(c);
      }
      log.info("동시에 주문한 상품수 : " + no.length);
      order.setGroupsize(no.length);
      
      for (Cart list : cartList) {
         order.setNo_menu(list.getNo_menu());
         order.setMenu_name(list.getMenu_name());
         order.setMenu_cnt(list.getMenu_cnt());
         order.setOp1_cnt(list.getOp1_cnt());
         order.setOp2_cnt(list.getOp2_cnt());
         order.setOp3_cnt(list.getOp3_cnt());
         MenuDto dto = menuDao.info(list.getNo_menu());
         int p1 = list.getMenu_cnt() * dto.getPrice();
         int o1 = list.getOp1_cnt() * dto.getOp1_price();
         int o2 = list.getOp2_cnt() * dto.getOp2_price();
         int o3 = list.getOp3_cnt() * dto.getOp3_price();
         order.setTotalprice(p1 + o1 + o2 + o3);
         orderDao.order(order, state);
         cartDao.delete(list.getNo());
      }
      
      return "redirect:orderlist";
   }

   @RequestMapping("/cancle")
   public String cancle(@RequestParam String groupno, Model m) {
      List<Order> orderList = orderDao.orderInfo(groupno);
      List<MenuFileDto> mfdto = mfdao.list();
      
      m.addAttribute("groupno", groupno);
      m.addAttribute("orderList", orderList);
      m.addAttribute("mfdto", mfdto);

      return "order/cancle";
   }

   @RequestMapping(value = "/cancle", method = RequestMethod.POST)
   public String cancle(@RequestParam String groupno) {

      boolean result = orderDao.cancle(groupno);

      return "redirect:orderlist";
   }

   @RequestMapping(value = "/editcart", method = RequestMethod.POST)
   public String editCart(@RequestParam int menu_cnt, @RequestParam int no, HttpServletRequest request, Model m) {
      boolean res = cartDao.edit(no, menu_cnt);

      return "redirect:cart";
   }

   @RequestMapping(value = "/delete", method = RequestMethod.POST)
   public String delete(@RequestParam String[] no) {

      for (String del_no : no) {
         log.info(del_no);
         cartDao.delete(Integer.parseInt(del_no));
      }
      return "redirect:cart";
   }

   @RequestMapping(value = "/deleteAll")
   public String deleteAll(HttpServletRequest request) {
	   
	   String email = null; 
	      Cookie[] list = request.getCookies();
	      for (Cookie c : list) {
	         if (c.getName().equals("memberEmail")) {
	            email = c.getValue();
	            break;
	         }
	      }

	      if (email != null) {
	    	  MemberDto member = memberDao.info(email).get(0);
	    	  cartDao.deleteAll(member.getNo());
	      }
      
      return "redirect:cart";
   }
   
   @RequestMapping("/detail")
   public String detail(@RequestParam String groupno,@RequestParam int price, Model m, HttpServletRequest request) {
      
      String email = null;
      Cookie[] list = request.getCookies();
      for (Cookie c : list) {
         if (c.getName().equals("memberEmail")) {
            email = c.getValue();
            break;
         }
      }

      if (email != null) {
         MemberDto memberInfo = memberDao.info(email).get(0);
         m.addAttribute("memberInfo", memberInfo);
      }
      
      List<Order> orderList = orderDao.orderInfo(groupno);
      List<MenuFileDto> mfdto = mfdao.list();
      List<MenuDto> menuList = menuDao.list();
      
      m.addAttribute("price",price);
      m.addAttribute("groupno", groupno);
      m.addAttribute("orderList", orderList);
      m.addAttribute("mfdto", mfdto);
      m.addAttribute("want_date", orderList.get(0).getWant_date());
      m.addAttribute("comments", orderList.get(0).getComments());
      m.addAttribute("menuList", menuList);
      
      return "order/detail";
   }

   //재고 복구
   @RequestMapping(value="/back", method=RequestMethod.POST)
   public String back(@RequestParam int no_menu, @RequestParam int menu_cnt, Model m) {
	   menuDao.plus(no_menu, menu_cnt);
	   m.addAttribute("menu_cnt",menu_cnt);
	   m.addAttribute("no_menu", no_menu);
	   
	   return "redirect:write";
   }
   
   //장바구니에서 재고 복구
   @RequestMapping(value="/back2", method=RequestMethod.POST)
   public String back2(@RequestParam String[] no) {
	   
	  for(String s : no) {
		  Cart c = cartDao.select(Integer.parseInt(s));
		  menuDao.plus(c.getNo_menu(), c.getMenu_cnt());
	  } 
	  return "redirect:cart";
   }

}