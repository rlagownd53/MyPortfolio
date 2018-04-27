package recipe.security;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
@RequestMapping("common/error")
public class CommonErrorController {
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value="/throwable")
	public String throwable(HttpServletRequest request,Model model) {
		log.info("throwable");
		pageErrorLog(request);
		model.addAttribute("msg","예외가 발생하였습니다");
		return "/error/errorpage";
	}
	@RequestMapping(value="/exception")
	public String exception(HttpServletRequest request,Model model) {
		log.info("exception");
		pageErrorLog(request);
		model.addAttribute("msg","예외가 발생하였습니다");
		return "/error/errorpage";
	}
	@RequestMapping(value="/400")
	public String pageError400(HttpServletRequest request,Model model) {
		log.info("page error code 400");
		pageErrorLog(request);
		model.addAttribute("msg","예외가 발생하였습니다");
		return "/error/errorpage";
	}
	@RequestMapping(value="/403")
	public String pageError403(HttpServletRequest request,Model model) {
		log.info("page error code 403");
		pageErrorLog(request);
		model.addAttribute("msg","예외가 발생하였습니다");
		return "/error/errorpage";
	}
	@RequestMapping(value="/404")
	public String pageError404(HttpServletRequest request,Model model) {
		log.info("page error code 404");
		pageErrorLog(request);
		model.addAttribute("msg","예외가 발생하였습니다");
		return "/error/errorpage";
	}
	@RequestMapping(value="/405")
	public String pageError405(HttpServletRequest request,Model model) {
		log.info("page error code 405");
		pageErrorLog(request);
		model.addAttribute("msg","예외가 발생하였습니다");
		return "/error/errorpage";
	}
	@RequestMapping(value="/500")
	public String pageError500(HttpServletRequest request,Model model) {
		log.info("page error code 500");
		pageErrorLog(request);
		model.addAttribute("msg","예외가 발생하였습니다");
		return "/error/errorpage";
	}
	@RequestMapping(value="/503")
	public String pageError503(HttpServletRequest request,Model model) {
		log.info("page error code 503");
		pageErrorLog(request);
		model.addAttribute("msg","예외가 발생하였습니다");
		return "/error/errorpage";
	}

	private void pageErrorLog(HttpServletRequest request) {
		log.error("status_code: "+request.getAttribute("javax.servlet.error.status_code"));
		log.error("exception_type: "+request.getAttribute("javax.servlet.error.exception_type"));
		log.error("message: "+request.getAttribute("javax.servlet.error.message"));
		log.error("request_uri: "+request.getAttribute("javax.servlet.error.request_uri"));
		log.error("exception: "+request.getAttribute("javax.servlet.error.exception"));
		log.error("servlet_name: "+request.getAttribute("javax.servlet.error.servlet_name"));
		log.error("------------------------------------------------------------------------");
	}
	
}
