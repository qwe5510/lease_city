package leasecity.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import leasecity.dto.community.Comment;
import leasecity.dto.community.Reply;
import leasecity.dto.etc.Page;
import leasecity.exception.ChangeValueFailException;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.RemoveFailException;
import leasecity.exception.WriteFailException;
import leasecity.repo.community.CommentRepo;
import leasecity.repo.community.ReplyRepo;

@Service
public class CommunityServiceImpl implements CommunityService{

	static Logger logger = LoggerFactory.getLogger(CommunityServiceImpl.class);
	
	@Autowired
	CommentRepo commentRepo;
	
	@Autowired
	ReplyRepo replyRepo;
	
	/**
	 * 일반적인 게시글 페이지 출력
	 * @param currentPage : 현재 페이지 값
	 * @return
	 * @throws NotFoundDataException
	 */
	@Override
	public List<Comment> loadPageCommentList(Page page) throws NotFoundDataException {
		List<Comment> results = commentRepo.getPageComments(page);
		
		if(results.size() <= 0){
			throw new NotFoundDataException("조회하려는 게시글");
		}
		
		for(Comment comment : results){
			comment.setReplyCount(
					replyRepo.getCountCommentReply
					(comment.getCommentNo()));
			int rowNum = (commentRepo.getCountAllComments()-comment.getCommentRowNum())+1;
			comment.setCommentRowNum(rowNum);
		}
		
		return results;
	}

	/**
	 * 조건이 달린 게시글 페이지 출력
	 * @param page - pageSize, currentPage, search, keyword, order 를 대입하는 페이지
	 * @return
	 * @throws NotFoundDataException
	 */
	@Override
	public List<Comment> loadTermsComment(Page page) throws NotFoundDataException {
		List<Comment> results = commentRepo.getPageComments(page);
		for(Comment comment : results){
			comment.setReplyCount(
					replyRepo.getCountCommentReply
					(comment.getCommentNo()));
			int rowNum = (commentRepo.getCountAllComments()-comment.getCommentRowNum())+1;
			comment.setCommentRowNum(rowNum);
		}
		
		if(results.size() <= 0){
			throw new NotFoundDataException(page.getKeyword());
		}
		
		return results;
	}

	/**
	 * 게시글 쓰기 기능
	 * @param comment
	 * @return 쓴 글
	 * @throws WriteFailException
	 */
	@Override
	public void writeComment(Comment comment) throws WriteFailException {
		int result = commentRepo.insertComment(comment);
		if(result != 1){
			throw new WriteFailException("커뮤니티 게시글");
		}
	}

	/**
	 * 게시글 읽기 기능
	 * @param commentNo
	 * @return 읽는 글 정보.
	 * @throws NotFoundDataException
	 */
	@Override
	public Comment viewComment(Integer commentNo) throws NotFoundDataException {
		
		if(commentNo == null){
			throw new NotFoundDataException("해당 게시글");
		}
		
		Comment result = commentRepo.getComment(commentNo);
		
		if(result == null){
			throw new NotFoundDataException("해당 게시글");
		}
		else{
			int hitCount = commentRepo.hitsUpComment(result);
			result.setReplyCount(replyRepo.getCountCommentReply(commentNo));
			logger.trace("게시글 조회수 증가 : {}", hitCount);
		}
		return result;
	}

	/**
	 * 게시글 수정 기능
	 * @param comment
	 * @return
	 * @throws ChangeValueFailException
	 */
	@Override
	public void updateComment(Comment comment) throws ChangeValueFailException {
		int result = commentRepo.updateComment(comment);
		
		if(result != 1){
			throw new ChangeValueFailException("수정하려는 게시글");
		}
		
	}

	/**
	 * 게시글 삭제 기능
	 * @param comment
	 * @throws RemoveFailException
	 */
	@Override
	public void removeComment(Comment comment) throws RemoveFailException {
		int result = commentRepo.deleteCommentAndReply(comment);
		if(result != 1){
			throw new RemoveFailException(comment.getCommentTitle() + "게시글");
		}
	}
	
	

	/**
	 * 게시글에 대한 덧글 목록 출력
	 * @param page : superNo : 게시글 번호, currentPage, pageSize 기입
	 * @return
	 * @throws NotFoundDataException
	 */
	@Override
	public List<Reply> loadCommentReplys(Page page) throws NotFoundDataException {
		List<Reply> results = replyRepo.getPageReplys(page);
		if(results.size() <= 0){
			throw new NotFoundDataException("등록된 댓글");
		}
		return results;
	}

	@Override
	public void writeReply(Reply reply) throws WriteFailException {
		int result = replyRepo.insertReply(reply);
		if(result != 1){
			throw new WriteFailException("덧글");
		}
	}

	@Override
	public void updateReply(Reply reply) throws ChangeValueFailException {
		int result = replyRepo.updateReply(reply);
		if(result != 1){
			throw new ChangeValueFailException("덧글");
		}
	}

	@Override
	public void removeReply(Reply reply) throws RemoveFailException {
		int result = replyRepo.deleteReply(reply);
		if(result != 1){
			throw new RemoveFailException("덧글");
		}
	}

	
	//----------------------------------------------------------------
	//페이지 리턴
	//----------------------------------------------------------------
	@Override
	public Page getCommentPage(Integer currentPage, Integer pageSize) {
		Page page = new Page();
		page.setTotalCount(commentRepo.getCountAllComments());
		page.setCurrentPage(currentPage);
		page.setPageSize(pageSize);
		page.setTotalPage((page.getTotalCount()-1)/page.getPageSize()+1);
		page.setFromTo();
		
		System.out.println("여기서 에러뜸?");
		
		return page;
	}

	@Override
	public Page getSearchCommentPage(Integer currentPage, Integer pageSize,
			String search, String keyword, String order) {
		Page page = new Page();
		page.setTotalCount(commentRepo.getCountSearchComments(new Page(search, keyword)));
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
	public Page getReplyPage(Integer commentNo, Integer currentPage, Integer pageSize) {
		Page page = new Page();
		page.setSuperNo(commentNo);
		page.setTotalCount(replyRepo.getCountCommentReply(commentNo));
		page.setCurrentPage(currentPage);
		page.setPageSize(pageSize);
		page.setTotalPage((page.getTotalCount()-1)/page.getPageSize()+1);
		page.setFromTo();
		
		return page;
	}
}
