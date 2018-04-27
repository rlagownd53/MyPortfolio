package recipe.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import net.sf.jmimemagic.Magic;
import net.sf.jmimemagic.MagicMatchNotFoundException;
import recipe.model.menu.MenuDao;
import recipe.model.menu.MenuDto;
import recipe.model.menu.MenuFileDao;
import recipe.model.menu.MenuFileDto;

import java.io.File;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class MenuController {
	private Logger log = LoggerFactory.getLogger(getClass());
	@Autowired
	private MenuDao mdao;
	private MenuDto mdto;
	@Autowired
	private MenuFileDao mfdao;
	private MenuFileDto mfdto;
	
	//메뉴 리스트 이동(일반 권한)
	@RequestMapping("mlist")
	public String MenuList(HttpServletRequest request, Model model) {
		List<MenuDto> mdto = mdao.list();
		List<MenuFileDto> mfdto = mfdao.list();
//		for(MenuDto m : mdto) {
//			log.debug("가져온 메뉴 값 : "+m.getName());
//			for(MenuFileDto ma : mfdto) {
//				if(m.getMenu_no() == ma.getMenu_no())
//					log.debug("				가져온 img 값 : "+m.getName());
//				}
//		}
		model.addAttribute("mdto", mdto);
		model.addAttribute("mfdto", mfdto);
		return "menu/menuList";
	}
	
	//메뉴 추가 버튼 클릭시 page전환(관리자 권한)
	@RequestMapping("madd")
	public String MenuAd() {
		return "menu/menuAdd";
	}
	
	//메뉴 추가 기능 수행
	@RequestMapping(value="madd", method=RequestMethod.POST)
	public String MenuAdd(MultipartHttpServletRequest req) throws Exception{
		int no = mdao.add(new MenuDto(req));
		fileAdd(no, req);	//파일 추가 클레스 호출
		return "redirect:/mmodi?no="+no;
	}
	
	//메뉴 추가 시 파일 업로드 기능 수행
	private void fileAdd(int no, MultipartHttpServletRequest req) throws Exception{
		//(main,food,recipe) 중 누락한 경우	거르기 위한 while
		log.debug("up판별 : "+req.getRequestURI());
		Iterator<String> param = req.getFileNames();
		String imgkey = "";
		while(param.hasNext()) {
			String imgname = (String)param.next();
			//파일 업로드 안한 경우
			MultipartFile img = req.getFile(imgname);
			if(img.getSize()>0) {
				log.debug("이미지 파일 추가 하는 중...");
				String name = no+"_"+img.getOriginalFilename();
				int size = (int) img.getSize();
				
				//확장자 판별 하는 라이브러리 이용
				String mime = Magic.getMagicMatch(img.getBytes()).getMimeType();
//				log.debug("추가할 이미지의 확장자 : " + mime);
				switch (mime) {
				case "image/gif": break;
				case "image/jpeg": break;
				case "image/jpg": break;
				case "image/png": break;
				default: throw new MagicMatchNotFoundException("GIF, JPG, PNG만 업로드가 가능합니다.");
				}
//				log.debug("[입력할 데이터 확인] name : "+name +" / size : "+size+" / mime : "+mime);
				String save = req.getServletContext().getRealPath("/resource/menuimg/"+req.getParameter("name"));
				log.debug("저장 위치  = "+save);
				mfdto = new MenuFileDto(no, imgname, name, size, mime);
				File target = new File(save, name);
				if(!target.exists()) target.mkdirs();
				img.transferTo(target);
				imgkey += imgname+"/";
				if(!req.getRequestURI().equals("/myrecipe/mupdate")) {
					log.debug("[새로운 메뉴 이미지 추가]");
					mfdao.add(mfdto);
				}
				else if(req.getRequestURI().equals("/myrecipe/mupdate")) {
					log.debug("[메뉴 이미지 업데이트]");
					mfdao.update(mfdto);
				}
			}
		}
		log.debug("추가한 이미지 파일 : "+imgkey);
	}
	
	//메뉴 상세정보 page전환(관리자 권한)
	@RequestMapping("mdetail")
	public String MenuDetail(@RequestParam("no") int no, Model model) {
		mdto = mdao.info(no);
		List<MenuFileDto> mfdto = mfdao.info(no);
		model.addAttribute("mdto", mdto);
		model.addAttribute("mfdto", mfdto);
		return "menu/menuDetail";
	}
	
	//메뉴 수정 기능 수행
	@RequestMapping(value="mupdate", method=RequestMethod.POST)
	public String MenuUpdate(@RequestParam(value="no", required = true) int no, MultipartHttpServletRequest req) throws Exception {
		log.debug(no+"번 메뉴 / 수정하러 와쩌염");
		mdao.update(new MenuDto(req));
		fileAdd(no, req);
		return "redirect:/mmodi";
	}
	
	//메뉴 삭제 기능 수행
	@RequestMapping("mdelete")
	public String MenuDelete(@RequestParam("no") int no) {
		mdao.delete(no);
		return "redirect:/mmodi";
	}
}
