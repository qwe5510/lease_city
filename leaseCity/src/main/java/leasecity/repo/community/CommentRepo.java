package leasecity.repo.community;

import leasecity.dto.community.Comment;

public interface CommentRepo {
	public int insertComment(Comment comment);
}
