package recipe.model.board;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ReplyDto {
	private Logger log = LoggerFactory.getLogger(getClass());
	
	private int no;
	private String writer;
	private String detail;
	private String reg;
	private int context;
	
	private int gno;
	private int gseq;
	private int depth;
	
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
	public ReplyDto() {
		super();
	}
	public ReplyDto(ResultSet rs) throws SQLException{
		setNo(rs.getInt("no"));
		setWriter(rs.getString("writer"));
		setDetail(rs.getString("detail"));
		setReg(rs.getString("reg"));
		setContext(rs.getInt("context"));
		
		setGno(rs.getInt("gno"));
		setGseq(rs.getInt("gseq"));
		setDepth(rs.getInt("depth"));
	}
	public ReplyDto(HttpServletRequest request) {
		String no = request.getParameter("no");
		setNo(no==null?1:Integer.parseInt(no));
		setWriter(request.getParameter("writer"));
		setDetail(request.getParameter("detail"));
		setReg(request.getParameter("reg"));
		setContext(Integer.parseInt(request.getParameter("context")));
		String gno = request.getParameter("gno");
		setGno(gno==null?0:Integer.parseInt(gno));
		String gseq = request.getParameter("gseq");
		setGseq(gseq==null?0:Integer.parseInt(gno));
		String depth = request.getParameter("depth");
		setDepth(depth==null?0:Integer.parseInt(depth));
		
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getDetail() {
		return detail.replace("\n", "<br>");
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getReg() {
		return reg.substring(0, 19);
	}
	public void setReg(String reg) {
		this.reg = reg;
	}
	public int getContext() {
		return context;
	}
	public void setContext(int context) {
		this.context = context;
	}
}
