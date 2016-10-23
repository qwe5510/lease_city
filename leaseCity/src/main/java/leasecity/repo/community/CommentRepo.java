package leasecity.repo.community;

import java.util.List;

import leasecity.dto.community.Comment;
import leasecity.dto.etc.Page;

public interface CommentRepo {
	
	//모든 게시글 갯수 정수로 리턴
	public Integer getCountAllCommunityComments();
	
	//검색 했을 때 게시물 갯수 리턴
	public Integer getCountSearchCommunityComments(Page page);
	
	//모든 게시글 페이지 별로 리턴
	public List<Comment> getPageCommunityComments(Page page);
	
	//게시글 조회
	public Comment getCommunityComment(Integer commentNo);
	
	//게시글 조회 (번호, 아이디)
	public Comment getCommunityUserComment(Comment comment);
	
	//게시글 추가
	public int insertCommunityComment(Comment comment);
	
	//게시글 삭제 (댓글도 같이 삭제)
	public int deleteCommunityCommentAndReply(Comment comment);
	
	//게시글 수정
	public int updateCommunityComment(Comment comment);
	
	//조회수 증가
	public int hitsUpCommunityComment(Comment comment);
}

