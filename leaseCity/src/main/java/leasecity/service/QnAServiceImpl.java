package leasecity.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import leasecity.dto.community.Comment;
import leasecity.dto.community.Reply;
import leasecity.dto.etc.Page;
import leasecity.exception.ChangeValueFailException;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.RemoveFailException;
import leasecity.exception.WriteFailException;
import leasecity.repo.adminwork.AnswerRepo;
import leasecity.repo.adminwork.QuestionRepo;

public class QnAServiceImpl implements QnAService{

	static Logger logger = LoggerFactory.getLogger(QnAServiceImpl.class);
	
	@Autowired
	QuestionRepo questionRepo;
	
	@Autowired
	AnswerRepo answerRepo;

	/**
	 * 일반적인 질문글 페이지 출력
	 * @param page currentPage : 현재 페이지 값
	 * @return
	 * @throws NotFoundDataException
	 */
	@Override
	public List<Comment> loadPageQuestions(Page page) throws NotFoundDataException {
		List<Comment> results = questionRepo.getPageQuestions(page);
		
		if(results.size() <= 0){
			throw new NotFoundDataException("등록된 질문");
		}
		
		for(Comment comment : results){
			comment.setReplyCount(
					answerRepo.getCountQuestionAnswer
					(comment.getCommentNo()));
			int rowNum = (questionRepo.getCountAllQuestions()-comment.getCommentRowNum())+1;
			comment.setCommentRowNum(rowNum);
		}
		
		return results;
	}

	@Override
	public List<Comment> loadTermsQuestions(Page page) throws NotFoundDataException {
		List<Comment> results = questionRepo.getPageQuestions(page);
		for(Comment comment : results){
			comment.setReplyCount(
					answerRepo.getCountQuestionAnswer
					(comment.getCommentNo()));
			int rowNum = (questionRepo.getCountAllQuestions()-comment.getCommentRowNum())+1;
			comment.setCommentRowNum(rowNum);
		}
		
		if(results.size() <= 0){
			throw new NotFoundDataException(page.getKeyword());
		}
		
		return results;
	}

	@Override
	public Comment loadQuestion(Integer commentNo) throws NotFoundDataException {
		Comment comment = questionRepo.getQuestion(commentNo);
		
		if(comment == null){
			throw new NotFoundDataException(commentNo + "번 질문");
		}else{
			comment.setReplyCount(answerRepo.getCountQuestionAnswer(commentNo));
		}
		
		return comment;
	}

	@Override
	public void writeQuestion(Comment comment) throws WriteFailException {
		int result = questionRepo.insertQuestion(comment);
		if(result != 1){
			throw new WriteFailException("커뮤니티 질문");
		}
	}

	@Override
	public Comment viewQuestion(Integer commentNo, String userId) throws NotFoundDataException {
		if(commentNo == null){
			throw new NotFoundDataException("해당 질문");
		}
		
		Comment result = questionRepo.getQuestion(commentNo);
		
		if(result == null){
			throw new NotFoundDataException("해당 질문");
		}
		else{
			//내가 작성한 글인지 확인 -> 작성한글이면 조회수안오름
			Comment check = new Comment(commentNo, userId);			
			check = questionRepo.getUserQuestion(check);
			
			if(check == null){
				int hitCount = questionRepo.hitsUpQuestion(result);
				logger.trace("질문 조회수 증가 : {}", hitCount);
			}
			result.setReplyCount(answerRepo.getCountQuestionAnswer(commentNo));
		}
		return result;
	}
	
	// 작성자 본인의 글인지 확인
	@Override
	public Comment isQuestionUser(Comment comment) throws NotFoundDataException {

		Comment result = questionRepo.getUserQuestion(comment);
		if (result == null) {
			logger.error("ERROR!! : 회원님이 작성한 질문글이 아닙니다.");
			throw new NotFoundDataException("회원 본인이 작성한 질문글");
		}

		return result;
	}

	@Override
	public void updateQuestion(Comment comment) throws ChangeValueFailException {
		int result = questionRepo.updateQuestion(comment);
		
		if(result != 1){
			throw new ChangeValueFailException("수정하려는 질문");
		}
	}

	@Override
	public void removeQuestion(Comment comment) throws RemoveFailException {
		int result = answerRepo.getCountQuestionAnswer(comment.getCommentNo());
		if(result >= 1){
			logger.trace("게시글 삭제 실패 : 질문글에 대해 답변이 달려있음.");
			throw new RemoveFailException(comment.getCommentTitle() + "게시글");
		}
		
		result = questionRepo.deleteQuestionAndAnswer(comment);
		if(result != 1){
			logger.trace("게시글 삭제 실패 : 대상 게시글 번호가 없음");
			throw new RemoveFailException(comment.getCommentTitle() + "게시글");
		}
	}

	@Override
	public List<Reply> loadQuestionAnswers(Page page) throws NotFoundDataException {
		List<Reply> results = answerRepo.getPageAnswers(page);
		if(results.size() <= 0){
			throw new NotFoundDataException("등록된 댓글");
		}
		return results;
	}

	@Override
	public void writeAnswer(Reply answer) throws WriteFailException {
		int result = answerRepo.insertAnswer(answer);
		if(result != 1){
			throw new WriteFailException("답변글");
		}
	}

	@Override
	public void updateAnswer(Reply answer) throws ChangeValueFailException {
		int result = answerRepo.updateAnswer(answer);
		if(result != 1){
			throw new ChangeValueFailException("답변글");
		}
	}

	@Override
	public void removeAnswer(Reply answer) throws RemoveFailException {
		int result = answerRepo.deleteAnswer(answer);
		if(result != 1){
			throw new RemoveFailException("답변글");
		}
	}

	
	//----------------------------------------------------------------
	//페이지 리턴
	//----------------------------------------------------------------
	@Override
	public Page getCommentPage(Integer currentPage, Integer pageSize) {
		Page page = new Page();
		page.setServiceKind("Q_AND_A");
		page.setTotalCount(questionRepo.getCountAllQuestions());		
		page.setCurrentPage(currentPage);
		page.setPageSize(pageSize);
		page.setTotalPage((page.getTotalCount()-1)/page.getPageSize()+1);
		page.setFromTo();
	
		return page;
	}

	@Override
	public Page getSearchCommentPage(Integer currentPage, Integer pageSize, String search, String keyword,
			String order) {
		Page page = new Page();
		page.setServiceKind("Q_AND_A");
		page.setTotalCount(questionRepo.getCountSearchQuestions(new Page(search, keyword)));
		page.setCurrentPage(currentPage);
		page.setPageSize(pageSize);
		page.setTotalPage((page.getTotalCount()-1)/page.getPageSize()+1);
		page.setSearch(search);
		page.setKeyword(keyword);
		page.setOrder(order);
		page.setFromTo();
		
		return page;
	}

	@Override
	public Page getFirstReplyPage(Integer commentNo, Integer pageSize) {
		Page page = new Page();
		page.setSuperNo(commentNo);
		page.setTotalCount(answerRepo.getCountQuestionAnswer(commentNo));
		page.setPageSize(pageSize);
		page.setTotalPage((page.getTotalCount()-1)/page.getPageSize()+1);
		page.setCurrentPage(page.getTotalPage());
		page.setFromTo();
		
		return page;
	}

	@Override
	public Page getReplyPage(Integer commentNo, Integer currentPage, Integer pageSize) {
		Page page = new Page();
		page.setSuperNo(commentNo);
		page.setTotalCount(answerRepo.getCountQuestionAnswer(commentNo));
		page.setPageSize(pageSize);
		page.setTotalPage((page.getTotalCount()-1)/page.getPageSize()+1);
		page.setCurrentPage(currentPage);
		page.setFromTo();
		
		return page;
	}
	
}
