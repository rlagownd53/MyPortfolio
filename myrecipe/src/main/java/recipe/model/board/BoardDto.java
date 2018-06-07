package recipe.model.board;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;


public class BoardDto {
	private int no;
	private String name;
	private String email;
	private String category;
	private String title;
	private String detail;
	private String pw;
	private int read;
	private String reg;
	private String filename;
	private long filesize;
	private String filetype;
	private int reply;

	private int gno;
	private int gseq;
	private int depth;

	private String notice;
	
	private String authck;
	
	private String replyck;
	
	public BoardDto() {
		super();
	}
	
	public String getReplyck() {
		return replyck;
	}

	public void setReplyck(String replyck) {
		this.replyck = replyck;
	}

	public String getAuthck() {
		return authck;
	}
	public void setAuthck(String authck) {
		this.authck = authck;
	}

	public int getGno() {
		return gno;
	}

	public void setGno(int gno) {
		this.gno = gno;
	}

	public int getGseq() {
		return gseq;
	}

	public void setGseq(int gseq) {
		this.gseq = gseq;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public int getReply() {
		return reply;
	}

	public void setReply(int reply) {
		this.reply = reply;
	}

	public BoardDto(HttpServletRequest request) {
		String no = request.getParameter("board_no");
		setNo(no == null ? 1 : Integer.parseInt(no));
		setName(request.getParameter("name"));
		setEmail(request.getParameter("email"));
		setCategory(request.getParameter("category"));
		setTitle(request.getParameter("title"));
		setDetail(request.getParameter("detail"));
		setPw(request.getParameter("pw"));
		String read = request.getParameter("read");
		setRead(read == null ? 0 : Integer.parseInt(read));
		setReg(request.getParameter("reg"));
		setFilename(request.getParameter("filename"));
		String filesize = request.getParameter("filesize");
		setFilesize(filesize == null ? 0L : Long.parseLong(filesize));
		setFiletype(request.getParameter("filetype"));
		String gno = request.getParameter("gno");
		setGno(gno == null ? 0 : Integer.parseInt(gno));
		String gseq = request.getParameter("gseq");
		setGseq(gseq == null ? 0 : Integer.parseInt(gno));
		String depth = request.getParameter("depth");
		setDepth(depth == null ? 0 : Integer.parseInt(depth));
		String reply = request.getParameter("reply");
		setReply(reply == null ? 0 : Integer.parseInt(reply));
		setNotice(request.getParameter("notice"));
		setAuthck(request.getParameter("authck"));
		setReplyck(request.getParameter("replyck"));
	}

	public BoardDto(ResultSet rs) throws SQLException {
		setNo(rs.getInt("board_no"));
		setName(rs.getString("name"));
		setEmail(rs.getString("email"));
		setCategory(rs.getString("category"));
		setTitle(rs.getString("title"));
		setDetail(rs.getString("detail"));
		setPw(rs.getString("pw"));
		setRead(rs.getInt("read"));
		setReg(rs.getString("reg"));
		setFilename(rs.getString("filename"));
		setFilesize(rs.getLong("filesize"));
		setFiletype(rs.getString("filetype"));
		setGno(rs.getInt("gno"));
		setGseq(rs.getInt("gseq"));
		setDepth(rs.getInt("depth"));
		setReply(rs.getInt("reply"));
		setNotice(rs.getString("notice"));
		setAuthck(rs.getString("authck"));
		setReplyck(rs.getString("replyck"));
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}

	public String getTitle2() {
		String sub = "";
		int len = 40;
		int j = 0;
		for (int i = 0; i < title.length(); i++) {
			j += ((int) title.charAt(i) > 128) ? 2 : 1;
			if (j > len) {
				sub = title.substring(0, i) + "...";
				break;
			}
		}
		if (sub.equals("")) {
			sub = title;
		}
		return sub;
	}

	public String getDetail() {
		return detail;
	}

	public String getDetail2() {
		return this.detail.replace("\n", "<br>");
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public int getRead() {
		return read;
	}

	public void setRead(int read) {
		this.read = read;
	}

	public String getReg() {
		return reg.substring(0, 19);
	}

	public void setReg(String reg) {
		this.reg = reg;
	}

	public String getDate() {
		return reg.substring(0, 10);
	}

	public String getTime() {
		return reg.substring(11, 19);
	}

	public String getAuto() {
		String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		if (getDate().equals(today)) // 작성글이 오늘이면 년월일을 제외한 시간을 표시, 그렇지 않으면 년월일만 표시
			return getTime();
		else
			return getDate();
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public long getFilesize() {
		return filesize;
	}

	public void setFilesize(long filesize) {
		this.filesize = filesize;
	}

	public String getFiletype() {
		return filetype;
	}

	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}

	public String getNotice() {
		return notice;
	}

	public void setNotice(String notice) {
		this.notice = notice;
	}

	public boolean fileExist() {
		return filename != null && filesize > 0 && filetype != null;
	}
}
