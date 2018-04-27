package recipe.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	@RequestMapping("/home")
	public String home() {
		return "home";
	}
//	@RequestMapping("/useway")
//	public String useway() {
//		
//		return "useandnotice/useway";
//	}
//	@RequestMapping("/notice")
//	public String notice() {
//		
//		return "useandnotice/notice";
//	}
}
