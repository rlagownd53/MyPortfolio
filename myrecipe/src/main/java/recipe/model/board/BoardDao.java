package recipe.model.board;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface BoardDao {
	int write(BoardDto bdto);
	BoardDto info(int no);
	
	/* 문의유형별 검색 소스 추가 후 */
	List<BoardDto> list(int start, int end, String cg);
	List<BoardDto> list(String type, String key, String cg, int start, int end);
	List<BoardDto> oneSearch(String type, String key, String cg, int start, int end);
	int count(String type, String key, String cg);
	
	int edit(BoardDto bdto);
	void read(int no);
	int listCount(String cg);
	int oneSearchCount(String type, String key, String cg);
	void delete(int no);
	void plusReply(int no);
	void minusReply(int no);
	
	/* 관리자 페이지 문의목록 관련 메소드*/
	int noReply();
	int okReply();
	List<BoardDto> adminboardlist(int start, int end);
	List<BoardDto> completeReply(int start, int end);
	
	/* 내 문의 목록 관련 메소드*/
	List<BoardDto> myQnA(int start, int end, String name);
	int mylistCnt(String email);
	
	/* 공지사항 메소드 */
	List<BoardDto> notice(int start, int end);
	int noticeCnt();
}