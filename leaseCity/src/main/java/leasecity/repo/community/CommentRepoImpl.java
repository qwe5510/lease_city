package leasecity.repo.community;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.community.Comment;

@Repository
public class CommentRepoImpl implements CommentRepo{

	@Autowired
	SqlSessionTemplate session;
	
	private final String COMMENT_NS = "";
	
	@Override
	public int insertComment(Comment comment) {
		String stmt = COMMENT_NS + "insertComment";
		return session.insert(stmt, comment);
	}

}
