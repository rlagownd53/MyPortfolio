package recipe.model.member;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository(value="memberDao") 
public interface MemberDao { 
	void sign(MemberDto dto);
	boolean login(String email, String password);
	boolean edit(MemberDto dto);
	List<MemberDto> info(String email);
	boolean signcheck(String email);
	List<MemberDto> list();
}
