package leasecity.repo.community;

import org.springframework.stereotype.Repository;

import leasecity.dto.community.Comment;

@Repository
public class CommentRepoImpl implements CommentRepo{

	private final String COMMENT_NS = "";
	
	@Override
	public int insertComment(Comment comment) {
		String stmt = COMMENT_NS + "";
		return 0;
	}

}
