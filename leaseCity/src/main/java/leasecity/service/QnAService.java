package leasecity.service;

import java.util.List;

import leasecity.dto.community.Comment;
import leasecity.dto.community.Reply;
import leasecity.dto.etc.Page;
import leasecity.exception.ChangeValueFailException;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.RemoveFailException;
import leasecity.exception.WriteFailException;

public interface QnAService {

	/**
	 * 일반적인 질문글 페이지 출력
	 * @param page - pageSize, currentPage를 대입하는 페이지
	 * @return
	 * @throws NotFoundDataException
	 */
	public List<Comment> loadPageQuestions (Page page) throws NotFoundDataException;
	
	/**
	 * 조건이 달린 게시글 페이지 출력
	 * @param page - pageSize, currentPage, search, keyword, order 를 대입하는 페이지
	 * @return
	 * @throws NotFoundDataException
	 */
	public List<Comment> loadTermsQuestions(Page page) throws NotFoundDataException;
	
	/**
	 * 게시글 번호로 게시글 불러오기.
	 * @param commentNo
	 * @return
	 * @throws NotFoundDataException
	 */
	public Comment loadQuestion(Integer commentNo) throws NotFoundDataException;
	
	/**
	 * 게시글 쓰기 기능
	 * @param comment
	 * @return 쓴 글
	 * @throws WriteFailException
	 */
	public void writeQuestion(Comment comment) throws WriteFailException;
	
	
	/**
	 * 게시글 읽기 기능
	 * @param commentNo
	 * @return 읽는 글 정보.
	 * @throws NotFoundDataException
	 */
	public Comment viewQuestion(Integer commentNo, String userId) throws NotFoundDataException;
	public Comment isQuestionUser(Comment comment) throws NotFoundDataException;
	
	/**
	 * 게시글 수정 기능
	 * @param comment
	 * @return
	 * @throws ChangeValueFailException
	 */
	public void updateQuestion(Comment comment) throws ChangeValueFailException;
	
	
	/**
	 * 게시글 삭제 기능
	 * @param comment
	 * @throws RemoveFailException
	 */
	public void removeQuestion(Comment comment) throws RemoveFailException;
	
	
	//덧글 기능
	
	/**
	 * 게시글에 대한 덧글 목록 출력
	 * @param page : superNo : 게시글 번호, currentPage, pageSize 기입
	 * @return
	 * @throws NotFoundDataException
	 */
	public List<Reply> loadQuestionAnswers(Page page)
			throws NotFoundDataException;
	
	/**
	 * 덧글 작성
	 * @param reply
	 * @throws NotFoundDataException
	 */
	public void writeAnswer(Reply reply) throws WriteFailException;
	
	/**
	 * 덧글 수정
	 * @param reply
	 * @throws ChangeValueFailException
	 */
	public void updateAnswer(Reply reply) throws ChangeValueFailException;
	
	/**
	 * 덧글 삭제
	 * @param reply
	 * @throws RemoveFailException
	 */
	public void removeAnswer(Reply reply) throws RemoveFailException;
	
	

	/**
	 * 질문글 현재 페이지 정보 리턴
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public Page getQuestionPage(Integer currentPage, Integer pageSize);
	
	/**
	 * 검색한 질문글 페이지 정보 리턴
	 * @param currentPage 현재페이지
	 * @param pageSize 페이지크기
	 * @param search 검색목적(제목, 내용, 작성자 등등)
	 * @param keyword 검색어
	 * @param order 정렬
	 * @return
	 */
	public Page getSearchQuestionPage
	(Integer currentPage, Integer pageSize, 
			String search, String keyword, String order);
	
	/**
	 * 게시물 클릭 시 처음 보이는 댓글 페이지
	 * @param commentNo
	 * @param pageSize
	 * @return
	 */
	public Page getFirstAnswerPage(Integer commentNo, Integer pageSize);
	
	/**
	 * 덧글 클릭시 보이는 페이지
	 * @param commentNo
	 * @param CurrentPage
	 * @param pageSize
	 * @return
	 */
	public Page getAnswerPage(Integer commentNo, Integer currentPage, Integer pageSize);

	
}
