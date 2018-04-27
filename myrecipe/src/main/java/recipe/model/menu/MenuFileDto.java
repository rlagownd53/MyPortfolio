package recipe.model.menu;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.web.multipart.MultipartHttpServletRequest;

public class MenuFileDto {
	private int fileno;
	private int menu_no;
	private String imgtype;
	private String filename;
	private int filesize;
	private String filetype;
	
	@Override
	public String toString() {
		return "MenuFileDto [fileno=" + fileno + ", menu_no=" + menu_no + ", imgtype=" + imgtype + ", filename="
				+ filename + ", filesize=" + filesize + ", filetype=" + filetype + "]";
	}

	public MenuFileDto() {
	}
	
	public MenuFileDto(ResultSet rs) throws SQLException {
		setFileno(rs.getInt("fileno"));
		setMenu_no(rs.getInt("menu_no"));
		setImgtype(rs.getString("imgtype"));
		setFilename(rs.getString("filename"));
		setFilesize(rs.getInt("filesize"));
		setFiletype(rs.getString("filetype"));
	}
	
	public MenuFileDto(int no, String imgtype, String name, int size, String mime){
		setMenu_no(no);
		setImgtype(imgtype);
		setFilename(name);
		setFilesize(size);
		setFiletype(mime);
	}


	public int getFileno() {
		return fileno;
	}

	public void setFileno(int fileno) {
		this.fileno = fileno;
	}

	public int getMenu_no() {
		return menu_no;
	}

	public void setMenu_no(int menu_no) {
		this.menu_no = menu_no;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public int getFilesize() {
		return filesize;
	}

	public void setFilesize(int filesize) {
		this.filesize = filesize;
	}

	public String getFiletype() {
		return filetype;
	}

	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}

	public String getImgtype() {
		return imgtype;
	}

	public void setImgtype(String imgtype) {
		this.imgtype = imgtype;
	}
	
}
