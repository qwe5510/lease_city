package leasecity.repo.community;

import java.util.List;

import leasecity.dto.community.Comment;
import leasecity.dto.etc.Page;

public interface CommentRepo {
	
	//모든 게시글 갯수 정수로 리턴
	public Integer getCountAllComments();
	
	//모든 게시글 페이지 별로 리턴
	public List<Comment> getPageComments(Page page);
	
	//게시글 추가
	public int insertComment(Comment comment);
	
	//게시글 삭제 (댓글도 같이 삭제)
	public int deleteCommentAndReply(Comment comment);
	
	//게시글 수정
	public int updateComment(Comment comment);

	
	
}
