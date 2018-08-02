package recipe.controller;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.annotation.RequestScope;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import net.sf.jmimemagic.Magic;
import net.sf.jmimemagic.MagicException;
import net.sf.jmimemagic.MagicMatchNotFoundException;
import net.sf.jmimemagic.MagicParseException;
import recipe.model.board.BoardDao;
import recipe.model.board.BoardDto;
import recipe.model.board.ReplyDao;
import recipe.model.board.ReplyDto;
import recipe.model.member.MemberDao;
import recipe.model.member.MemberDto;

@Controller
public class BoardController {
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private BoardDao bdao;
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private ReplyDao rdao;
	
	@RequestMapping("/blist")
	public String list(HttpServletRequest request, Model model) {
		String ckValue=null;
		Cookie[] ck =  request.getCookies();
		if(ck != null) {
			for(Cookie c : ck) {
				if(c.getName().equals("memberEmail")) {
					ckValue = c.getValue();
					model.addAttribute("ckValue", ckValue);
					
					List<MemberDto> dto = memberDao.info(ckValue);
					String auth = dto.get(0).getAuth().toString(); 
				    model.addAttribute("auth", auth);
					break;
				}
			}
		}
		String type = request.getParameter("type");
		String key = request.getParameter("key");
		String cg = request.getParameter("cg");
		
		
		String pageStr = request.getParameter("page");
		int pageNo;
		try {
			pageNo = Integer.parseInt(pageStr);
			if(pageNo <= 0) throw new Exception();
		}catch(Exception e) {
			pageNo=1;
		}
		//한 페이지에 보여질 게시글 갯수
		int boardSize = 10;
		int boardCount = bdao.count(type, key, cg);
		
		//한 페이지에 보여질 게시글의 시작 번호
		int start = boardSize * pageNo - boardSize+1;
		//한 페이지에 보여질 게시글의 끝 번호
		int end = start+boardSize-1;
		if(end > boardCount) end = boardCount;
		
		List<BoardDto> list = bdao.list(type, key, cg, start, end);
	
		//네비게이터에 표시될 숫자 갯수
		int blockSize = 10;
		//총 페이지 수
		int blockTotal = (boardCount + boardSize -1)/boardSize;
		
		//네비게이터 시작 번호
		int startBlock = (pageNo -1) / blockSize * blockSize+1;
		//네비게이터 끝 번호
		int endBlock = startBlock + blockSize -1;
		if(endBlock > blockTotal) endBlock = blockTotal;

		String url;
		if(cg==null || cg=="") {
			url = "blist?";
			if(type!=null && key!=null) 
				url += "type="+type+"&key="+key+"&cg="+cg+"&";
		} else {
			url = "blist?cg="+cg+"&";
		}
		
		model.addAttribute("cg", cg);
		model.addAttribute("type", type);
		model.addAttribute("key", key);
		model.addAttribute("url", url);
		model.addAttribute("startBlock", startBlock);
		model.addAttribute("endBlock", endBlock);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("blockTotal", blockTotal);
		model.addAttribute("list", list);
		
		return "board/list";
	}
	
	@RequestMapping("/bwrite")
	public String write(HttpServletRequest request, Model model) {
		String ckValue=null;
		Cookie[] ck =  request.getCookies();
		if(ck != null) {
			for(Cookie c : ck) {
				if(c.getName().equals("memberEmail")) {
					ckValue = c.getValue();
					List<MemberDto> mdto = memberDao.info(ckValue);
				    model.addAttribute("mdto", mdto.get(0));
					model.addAttribute("ckValue", ckValue);
					model.addAttribute("writeauth", mdto.get(0).getAuth());
					break;
				}
			}
		}
		
		BoardDto bdto = new BoardDto(request);
		model.addAttribute("bdto", bdto);
		if(ckValue!=null) {
			List<MemberDto> dto = memberDao.info(ckValue);
			String auth = dto.get(0).getAuth().toString(); 
		    model.addAttribute("auth", auth);
		}
		return "board/write";
	}
	
	public boolean imgCheck(String mime) throws MagicMatchNotFoundException {
		boolean flag = true;
		switch (mime) {
            case "image/gif": break;
            case "image/jpeg": break;
            case "image/jpg": break;
            case "image/png": break;
            default: flag = false; throw new MagicMatchNotFoundException("GIF, JPG, PNG만 업로드가 가능합니다.");
		}
		return flag;
	}
	
	@RequestMapping(value="/bwrite", method=RequestMethod.POST)
	public String write(MultipartHttpServletRequest request, Model model) throws Exception {
		MultipartFile file = request.getFile("file");
		String title = file.getOriginalFilename();
		long size = file.getSize();
		String auth = request.getParameter("auth");
		
		if(title!="") {
			//확장자 판별 하는 라이브러리 이용
			String mime = Magic.getMagicMatch(file.getBytes()).getMimeType();
			switch (mime) {
	            case "image/gif": break;
	            case "image/jpeg": break;
	            case "image/jpg": break;
	            case "image/png": break;
	            default: throw new MagicMatchNotFoundException("GIF, JPG, PNG만 업로드가 가능합니다.");
            }
			String save = request.getServletContext().getRealPath("/file/"+request.getParameter("name"));
			BoardDto bdto = new BoardDto(request);
			bdto.setFilename(title);
			bdto.setFilesize(size);
			bdto.setFiletype(mime);
			int no = bdao.write(bdto);
			File target = new File(save, title);
			if(!target.exists()) target.mkdirs();
			file.transferTo(target);
			
			model.addAttribute("auth", auth);
			return "redirect:/binfo?no="+no;
		} else {
			BoardDto bdto = new BoardDto(request);
			int no = bdao.write(bdto);
			model.addAttribute("auth", auth);
			return "redirect:/binfo?no="+no;
		}
	}
	
	@RequestMapping("/binfo")
	public String info(HttpServletRequest request,
					   @RequestParam("no") int no, 
					   @RequestParam("auth") String auth,
					   Model model, HttpServletResponse response) throws Exception {
		String ckValue=null;
		Cookie[] ck =  request.getCookies();
		if(ck != null) {
			for(Cookie c : ck) {
				if(c.getName().equals("memberEmail")) {
					ckValue = c.getValue();
					model.addAttribute("ckValue", ckValue);
					break;
				}
			}
		}
		
		bdao.read(no);
		BoardDto bdto = bdao.info(no);
		model.addAttribute("bdto", bdto);
		
		List<MemberDto> mdto = null;
		if(ckValue!=null) {
			mdto = memberDao.info(ckValue);
		}else if(ckValue==null && bdto.getAuthck().equals("t")) {
			return "board/info";
		}
		
		model.addAttribute("auth", mdto.get(0).getAuth());
		
		List<ReplyDto> rdto = rdao.list(no);
		model.addAttribute("rdto", rdto);
		
		
		/*
		 * ckValue==null -> 로그인이 안 된  비회원이 접속하려는 경우
		 * ---------------------------------------------------------------------------
		 * !ckValue.equals(bdto.getEmail()) -> 로그인 된 계정과 게시글 작성자의 이메일이 다른 경우(남의 게시글 침범)
		 * */
		if(!mdto.get(0).getAuth().equals("관리자")) {
			if(!ckValue.equals(bdto.getEmail())) {
				if(bdto.getAuthck().equals("t") ) {
					return "board/info";
				}
				throw new Exception(); 
			}
		} 
		return "board/info";
	}
	
	@RequestMapping("/bedit")
	public String edit(HttpServletRequest request,
					   @RequestParam("no") int no,
					   @RequestParam("auth") String auth,
					   Model model) throws Exception {
		String ckValue=null;
		Cookie[] ck =  request.getCookies();
		if(ck != null) {
			for(Cookie c : ck) {
				if(c.getName().equals("memberEmail")) {
					ckValue = c.getValue();
					model.addAttribute("ckValue", ckValue);
					break;
				}
			}
		}
		
		BoardDto bdto = bdao.info(no);
		model.addAttribute("bdto", bdto);
		model.addAttribute("no", no);
		model.addAttribute("auth",auth);
		
		if(!ckValue.equals(bdto.getEmail()))
			throw new Exception();
		
		return "board/bedit";
	}
	
	@RequestMapping(value="/bedit", method=RequestMethod.POST)
	public String edit(MultipartHttpServletRequest request,
					   @RequestParam("board_no") int num, Model model) throws Exception {
		int no = 0;
		MultipartFile file = request.getFile("file");
		//바꿀 사진 
		String title = file.getOriginalFilename();
		long size = file.getSize();
		
		//기존의 사진
		String origin = request.getParameter("origin");
		String save = request.getServletContext().getRealPath("/file/"+request.getParameter("name"));
		
		//이미지를 바꾼 경우
		if(title!="") {
			String mime = Magic.getMagicMatch(file.getBytes()).getMimeType();
			boolean check = imgCheck(mime);
			
			BoardDto bdto = new BoardDto(request);
			bdto.setFilename(title);
			bdto.setFilesize(size);
			bdto.setFiletype(mime);
			no = bdao.edit(bdto);
			
			if(origin!=null) {
				File target = new File(save, origin);
				//f==null이면 target유지, f!=null이면 target삭제
				if(file!=null) {
					target.delete();
					target = new File(save, title);
				}
			}
			File target = new File(save, title);
			if(!target.exists()) target.mkdirs();
			file.transferTo(target);
			
			model.addAttribute("auth", request.getParameter("auth"));
			return "redirect:/binfo?no="+no;
		} else{	//기존에 이미지가 있고 새로 첨부한 이미지는 없는 경우
			if(origin!=null) {
				BoardDto bdto = bdao.info(num);
				size = bdto.getFilesize();
				String type = bdto.getFiletype();
				
				bdto = new BoardDto(request);
				bdto.setFilename(origin);
				bdto.setFilesize(size);
				bdto.setFiletype(type);
				no = bdao.edit(bdto);
				
				model.addAttribute("auth", request.getParameter("auth"));
				return "redirect:/binfo?no="+no;
			} else {
				no = bdao.edit(new BoardDto(request));
				model.addAttribute("auth", request.getParameter("auth"));
				return "redirect:/binfo?no="+no;
			}
		} 
	}
	
	/*@RequestMapping(value="/bedit", method=RequestMethod.POST)
	public String edit(MultipartHttpServletRequest request,
					   @RequestParam("board_no") int num, Model model) throws Exception {
		int no = 0;
		MultipartFile file = request.getFile("file");
		//바꿀 사진 
		String title = file.getOriginalFilename();
		long size = file.getSize();
		
		//기존의 사진
		String origin = request.getParameter("origin");
		String save = request.getServletContext().getRealPath("/file/"+request.getParameter("name"));
		
		//이미지를 바꾼 경우
		if(title!="") {
			String mime = Magic.getMagicMatch(file.getBytes()).getMimeType();
			switch (mime) {
	            case "image/gif": break;
	            case "image/jpeg": break;
	            case "image/jpg": break;
	            case "image/png": break;
	            default: throw new MagicMatchNotFoundException("GIF, JPG, PNG만 업로드가 가능합니다.");
            }
			BoardDto bdto = new BoardDto(request);
			bdto.setFilename(title);
			bdto.setFilesize(size);
			bdto.setFiletype(mime);
			no = bdao.edit(bdto);
			
			
			if(origin!=null) {
				File target = new File(save, origin);
				//f==null이면 target유지, f!=null이면 target삭제
				if(file!=null) {
					target.delete();
					target = new File(save, title);
				}
			}
			File target = new File(save, title);
			if(!target.exists()) target.mkdirs();
			file.transferTo(target);
			
			model.addAttribute("auth", request.getParameter("auth"));
			return "redirect:/binfo?no="+no;
		} else{	//기존에 이미지가 있고 새로 첨부한 이미지는 없는 경우
			if(origin!=null) {
				BoardDto bdto = bdao.info(num);
				size = bdto.getFilesize();
				String type = bdto.getFiletype();
				
				bdto = new BoardDto(request);
				bdto.setFilename(origin);
				bdto.setFilesize(size);
				bdto.setFiletype(type);
				no = bdao.edit(bdto);
				
				model.addAttribute("auth", request.getParameter("auth"));
				return "redirect:/binfo?no="+no;
			} else {
				no = bdao.edit(new BoardDto(request));
				model.addAttribute("auth", request.getParameter("auth"));
				return "redirect:/binfo?no="+no;
			}
		} 
	}*/
	
	@RequestMapping("/bdelete")
	public String delete(HttpServletRequest request,
						@RequestParam("no") int no, 
					     @RequestParam("filename") String filename,
					     @RequestParam("name") String name,
						 Model model) {
		
		if(filename=="") {
			bdao.delete(no);
			return "redirect:/blist#q2";
		}else {
			String save = request.getServletContext().getRealPath("/file/"+request.getParameter("name"));
			File target = new File(save, filename);
			target.delete();
			bdao.delete(no);
			return "redirect:/blist#q2";
		}
	}
	
	@RequestMapping("/download/{filename:.+}")
	public void download(@PathVariable String filename,
					HttpServletRequest request,
					HttpServletResponse response) throws Exception { 
		String sendName = URLEncoder.encode(filename, "UTF-8").replace("+", "%20").replace("%25","%");
		
		String save = request.getServletContext().getRealPath("/file/"+request.getParameter("name"));
		File target = new File(save, filename);
		byte[] data = FileUtils.readFileToByteArray(target);
		
		response.setContentType("application/octet-stream");		//전송 할 유형
		response.setContentLength(data.length);						//전송 할 크기
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Disposition",
							"attachment:fileName=\""+filename+"\";");
		
		OutputStream out = response.getOutputStream();
		out.write(data);
		out.close();
	}
	
	
	@RequestMapping(value="/replywrite", method=RequestMethod.POST)
	public String replywrite(HttpServletRequest request, Model model) {
		String writer = request.getParameter("writer");
		String context = request.getParameter("context");
		String auth = request.getParameter("auth");
		
		BoardDto bdto = bdao.info(Integer.parseInt(context));
		rdao.insert(new ReplyDto(request), auth);
		bdao.plusReply(Integer.parseInt(context));
		model.addAttribute("auth", auth);
		if(auth.equals("관리자"))
			return "redirect:/mnqlist";
		return "redirect:binfo?no="+context;
	}
	
	@RequestMapping("/replydelete")
	public String replydelete(@RequestParam("no") int no,
							  @RequestParam("writer") String writer,
							  @RequestParam("auth") String auth,
							  Model model) {
		int context = rdao.delete(no, writer);
		bdao.minusReply(context);
		
		model.addAttribute("no", context);
		model.addAttribute("auth", auth);
		return "redirect:/binfo";
	}
	
	
	@RequestMapping("/myqna")
	public String myQna(HttpServletRequest request, Model model) {
		String ckValue=null;
		Cookie[] ck =  request.getCookies();
		if(ck != null) {
			for(Cookie c : ck) {
				if(c.getName().equals("memberEmail")) {
					ckValue = c.getValue();
					break;
				}
			}
		}
		
		String pageStr = request.getParameter("page");
		int pageNo;
		try {
			pageNo = Integer.parseInt(pageStr);
			if(pageNo <= 0) throw new Exception();
		}catch(Exception e) {
			pageNo=1;
		}
		int boardSize = 10;
		int boardCount = bdao.mylistCnt(ckValue);
		
		int start = boardSize * pageNo - boardSize+1;
		int end = start+boardSize-1;
		if(end > boardCount) end = boardCount;
		
		List<BoardDto> list = bdao.myQnA(start, end, ckValue);
		
		int blockSize = 10;
		int blockTotal = (boardCount + boardSize -1)/boardSize;
		int startBlock = (pageNo -1) / blockSize * blockSize+1;
		int endBlock = startBlock + blockSize -1;
		if(endBlock > blockTotal) endBlock = blockTotal;
		
		model.addAttribute("startBlock", startBlock);
		model.addAttribute("endBlock", endBlock);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("blockTotal", blockTotal);
		model.addAttribute("list", list);
		
		return "board/myqna";
	}
	
	@RequestMapping("/guide")
	public String guide() {
		return "board/guide";
	}
	
	@RequestMapping("/not")
	public String notice(HttpServletRequest request, Model model) {
		String ckValue=null;
		Cookie[] ck =  request.getCookies();
		if(ck != null) {
			for(Cookie c : ck) {
				if(c.getName().equals("memberEmail")) {
					ckValue = c.getValue();
					model.addAttribute("ckValue", ckValue);
					
					List<MemberDto> dto = memberDao.info(ckValue);
					String auth = dto.get(0).getAuth().toString(); 
				    model.addAttribute("auth", dto.get(0).getAuth());
					break;
				}
			}
		}
		
		String pageStr = request.getParameter("page");
		int pageNo;
		try {
			pageNo = Integer.parseInt(pageStr);
			if(pageNo <= 0) throw new Exception();
		}catch(Exception e) {
			pageNo=1;
		}
		int boardSize = 10;
		int boardCount = bdao.noticeCnt();
		int start = boardSize * pageNo - boardSize+1;
		int end = start+boardSize-1;
		if(end > boardCount) end = boardCount;
		
		List<BoardDto> list = bdao.notice(start, end);
		int blockSize = 10;
		int blockTotal = (boardCount + boardSize -1)/boardSize;
		int startBlock = (pageNo -1) / blockSize * blockSize+1;
		int endBlock = startBlock + blockSize -1;
		if(endBlock > blockTotal) endBlock = blockTotal;
		
		model.addAttribute("startBlock", startBlock);
		model.addAttribute("endBlock", endBlock);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("blockTotal", blockTotal);
		model.addAttribute("list", list);
		
		return "board/not";
	}
	
	@ExceptionHandler(Exception.class)
	public String Error() {
		return "error/err";
	}
}










