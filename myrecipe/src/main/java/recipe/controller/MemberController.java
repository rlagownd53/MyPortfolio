package recipe.controller;

import java.util.List;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import recipe.model.member.MemberDaoImpl;
import recipe.model.member.MemberDto;

@Service
@Controller
public class MemberController {
	private Logger log = LoggerFactory.getLogger(getClass());
	@Autowired
	MemberDaoImpl memberDaoImpl;

	/* 회원 가입 컨트롤러 */
	@RequestMapping(value = "/signcheck", method = RequestMethod.GET)
	public String SignPage(@RequestParam String email, @RequestParam String myname, Model model) {
		boolean res = memberDaoImpl.signcheck(email);
		if (res) {
			return "redirect:/login?error=signfalse";
		}
		model.addAttribute("email", email);
		model.addAttribute("name", myname);
		return "member/sign";
	}

	@RequestMapping(value = "/sign", method = RequestMethod.POST)
	public String Sign(MemberDto dto) {
		memberDaoImpl.sign(dto);
		return "redirect:/";
	}

	/* 회원 정보 컨트롤러 */
	@RequestMapping("/info")
	public String Info(HttpServletRequest request, Model model) {
		Cookie[] cookies = request.getCookies();
		String email = null;
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie c = cookies[i];
				String cName = c.getName();
				if (cName.equalsIgnoreCase("memberEmail")) {
					email = c.getValue();
				}
			}
		}
		if (email == null) {
			return "member/login";
		} else {
			List<MemberDto> dto = memberDaoImpl.info(email);
			model.addAttribute("dto", dto.get(0));
			return "member/info";
		}
	}

	/* 회원 정보 수정 컨트롤러 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String EditPage(HttpServletRequest request, Model model) {
		Cookie[] cookies = request.getCookies();
		String email = null;
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie c = cookies[i];
				String cName = c.getName();
				if (cName.equalsIgnoreCase("memberEmail")) {
					email = c.getValue();
				}
			}
		}
		List<MemberDto> dto = memberDaoImpl.info(email);
		model.addAttribute("dto", dto.get(0));
		return "member/edit";
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public String Edit(MemberDto dto) {
		boolean result = memberDaoImpl.edit(dto);
		return "redirect:/info";
	}

	/* 로그인 페이지 컨트롤러 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginPage(HttpServletRequest request,HttpSession session) {
		String error = request.getParameter("error");
		if(error == null) {
			String referrer = request.getHeader("Referer");
			request.getSession().setAttribute("prevPage", referrer);
		}
		return "member/login";
	}
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String Login(HttpServletResponse response, HttpSession session, HttpServletRequest request,
			@RequestParam String email, @RequestParam String password) {
		String rem = request.getParameter("remember");

		//이전 페이지 저장
		String prevPage = (String) session.getAttribute("prevPage");
		boolean result = memberDaoImpl.login(email, password);
		if (!result) {
			return "redirect:/login?error=loginfalse";
		} else {
			//쿠키 생성
			Cookie c = new Cookie("memberEmail", email);
			c.setComment("회원 이메일");
			if (rem != null && rem == "remeber") {
				// 일주일간 로그인 유지
				c.setMaxAge(60 * 60 * 24 * 7);
			} else {
				// 웹 브라우저 종료시 쿠키삭제
				c.setMaxAge(-1);
			}
			response.addCookie(c);
			//관리자 일시 관리자 페이지로
			if (email.equals("admin@admin.com")) {
				return "admin/adminmenu";
				//return "redirect:/admin";
				//아니면 이전 페이지로
			}else {
				String uri = request.getHeader("Referer");
				if(uri.contains("login")) {
					return "redirect:/";
				}else {
					return prevPage;
				}
			}
		}
	}

	/* 로그아웃 컨트롤러 */
	@RequestMapping("/logout")
	public String Logout(HttpServletResponse response, HttpSession session, HttpServletRequest request) {
		// 전체 쿠키 삭제하기
		/*
		 * Cookie[] cookies = request.getCookies() ;
		 * 
		 * if(cookies != null){ for(int i=0; i < cookies.length; i++){
		 * 
		 * // 쿠키의 유효시간을 0으로 설정하여 만료시킨다 cookies[i].setMaxAge(0) ;
		 * 
		 * // 응답 헤더에 추가한다 response.addCookie(cookies[i]) ; } }
		 */
		Cookie[] cookies = request.getCookies();
		String email = null;
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie c = cookies[i];
				String cName = c.getName();
				if (cName.equalsIgnoreCase("memberEmail")) {
					email = c.getValue();
				}
			}
		}
		// 인증 번호 삭제
		memberDaoImpl.logout(email);
		// 특정 쿠키만 삭제하기
		Cookie kc = new Cookie("memberEmail", null);
		kc.setMaxAge(0);
		response.addCookie(kc);
		session.invalidate();
		return "redirect:/";
	}

	@RequestMapping("tac")
	public String Check() {
		return "member/tac";
	}

	@RequestMapping(value = "/passwordfind", method = RequestMethod.GET)
	public String passwordfind(@RequestParam String email) {
		boolean res = memberDaoImpl.signcheck(email);
		return "member/login";
	}
}