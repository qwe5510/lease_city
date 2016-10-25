package leasecity.service;

import leasecity.exception.RemoveFailException;

public interface AdminService {
	
	/**
	 * 해당 id가 관리자인지 확인.
	 * @param userId
	 * @return
	 */
	public boolean isAdmin(String userId);
	
	/**
	 * 커뮤니티 게시글 삭제
	 * @param commentNo
	 */
	public void removeCommunityComment(Integer commentNo) throws RemoveFailException;
	/**
	 * 커뮤니티 댓글 삭제 
	 * @param replyNo
	 */
	public void removeCommunityReply(Integer replyNo) throws RemoveFailException;
	/**
	 * 질문과 답변 질문 삭제
	 * @param commentNo
	 */
	public void removeQuestion(Integer commentNo) throws RemoveFailException;
	/**
	 * 질문과 답변 답변 삭제
	 * @param replyNo
	 */
	public void removeAnswer(Integer replyNo) throws RemoveFailException;
	
}
