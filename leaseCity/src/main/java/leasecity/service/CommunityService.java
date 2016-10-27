package leasecity.service;

import java.util.List;

import leasecity.dto.community.Comment;
import leasecity.dto.community.Reply;
import leasecity.dto.etc.Page;
import leasecity.exception.ChangeValueFailException;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.RemoveFailException;
import leasecity.exception.WriteFailException;

public interface CommunityService {
	
	/**
	 * 일반적인 게시글 페이지 출력
	 * @param page - pageSize, currentPage를 대입하는 페이지
	 * @return
	 * @throws NotFoundDataException
	 */
	public List<Comment> loadPageCommunityComment (Page page) throws NotFoundDataException;
	
	/**
	 * 조건이 달린 게시글 페이지 출력
	 * @param page - pageSize, currentPage, search, keyword, order 를 대입하는 페이지
	 * @return
	 * @throws NotFoundDataException
	 */
	public List<Comment> loadTermsCommunityComment(Page page) throws NotFoundDataException;
	
	/**
	 * 게시글 쓰기 기능
	 * @param comment
	 * @return 쓴 글
	 * @throws WriteFailException
	 */
	public void writeComment(Comment comment) throws WriteFailException;
	
	
	/**
	 * 게시글 읽기 기능
	 * @param commentNo
	 * @return 읽는 글 정보.
	 * @throws NotFoundDataException
	 */
	public Comment viewComment(Integer commentNo, String userId) throws NotFoundDataException;
	public Comment isCommentUser(Comment comment) throws NotFoundDataException;
	
	/**
	 * 게시글 수정 기능
	 * @param comment
	 * @return
	 * @throws ChangeValueFailException
	 */
	public void updateComment(Comment comment) throws ChangeValueFailException;
	
	
	/**
	 * 게시글 삭제 기능
	 * @param comment
	 * @throws RemoveFailException
	 */
	public void removeComment(Comment comment) throws RemoveFailException;
	
	
	//덧글 기능
	
	/**
	 * 게시글에 대한 덧글 목록 출력
	 * @param page : superNo : 게시글 번호, currentPage, pageSize 기입
	 * @return
	 * @throws NotFoundDataException
	 */
	public List<Reply> loadCommentReplys(Page page)
			throws NotFoundDataException;
	
	/**
	 * 덧글 작성
	 * @param reply
	 * @throws NotFoundDataException
	 */
	public void writeReply(Reply reply) throws WriteFailException;
	
	/**
	 * 덧글 수정
	 * @param reply
	 * @throws ChangeValueFailException
	 */
	public void updateReply(Reply reply) throws ChangeValueFailException;
	
	/**
	 * 덧글 삭제
	 * @param reply
	 * @throws RemoveFailException
	 */
	public void removeReply(Reply reply) throws RemoveFailException;
	
	

	/**
	 * 게시글 현재 페이지 정보 리턴
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public Page getCommentPage(Integer currentPage, Integer pageSize);
	
	public Page getSearchCommentPage
	(Integer currentPage, Integer pageSize, 
			String search, String keyword, String order);
	
	public Page getFirstReplyPage(Integer commentNo, Integer pageSize);
	
	public Page getReplyPage(Integer commentNo, Integer CurrentPage, Integer pageSize);

}
