package recipe.model.board;

import java.util.List;
import org.springframework.stereotype.Repository;

@Repository
public interface ReplyDao {
	void insert(ReplyDto rdto, String auth);
	List<ReplyDto> list(int context);
	int delete(int no, String email);
}
