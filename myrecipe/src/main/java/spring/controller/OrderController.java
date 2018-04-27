package spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class OrderController {
	@RequestMapping("/order/order")
	public String order() {
		return "order/order";
	}
	
	@RequestMapping("/order/orderlist")
	public String orderList() {
		return "order/orderlist";
	}
	
	@RequestMapping("/order/pay")
	public String pay() {
		return "order/pay";
	}
	
	@RequestMapping("/order/write")
	public String write() {
		return "order/write";
	}

}
