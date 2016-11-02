package leasecity.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
@Transactional
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
	public List<Comment> loadPageCommunityComment(Page page) throws NotFoundDataException {
		List<Comment> results = commentRepo.getPageCommunityComments(page);
		
		if(results.size() <= 0){
			throw new NotFoundDataException("조회하려는 게시글");
		}
		
		for(Comment comment : results){
			comment.setReplyCount(
					replyRepo.getCountCommentReply
					(comment.getCommentNo()));
			int rowNum = (commentRepo.getCountAllCommunityComments()-comment.getCommentRowNum())+1;
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
	public List<Comment> loadTermsCommunityComment(Page page) throws NotFoundDataException {
		List<Comment> results = commentRepo.getPageCommunityComments(page);
		for(Comment comment : results){
			comment.setReplyCount(
					replyRepo.getCountCommentReply
					(comment.getCommentNo()));
			int rowNum = (commentRepo.getCountAllCommunityComments()-comment.getCommentRowNum())+1;
			comment.setCommentRowNum(rowNum);
		}
		
		if(results.size() <= 0){
			throw new NotFoundDataException(page.getKeyword());
		}
		
		return results;
	}
	
	/**
	 * 게시글 번호로 게시글 불러오기.
	 * @param commentNo
	 * @return
	 * @throws NotFoundDataException
	 */
	@Override
	public Comment loadComment(Integer commentNo) throws NotFoundDataException {
		Comment comment = commentRepo.getCommunityComment(commentNo);
		
		if(comment == null){
			throw new NotFoundDataException(commentNo + "번 게시글");
		}else{
			comment.setReplyCount(replyRepo.getCountCommentReply(commentNo));
		}
		
		return comment;
	}

	/**
	 * 게시글 쓰기 기능
	 * @param comment
	 * @return 쓴 글
	 * @throws WriteFailException
	 */
	@Override
	public void writeComment(Comment comment) throws WriteFailException {
		int result = commentRepo.insertCommunityComment(comment);
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
	public Comment viewComment(Integer commentNo, String userId) throws NotFoundDataException {
		
		if(commentNo == null){
			throw new NotFoundDataException("해당 게시글");
		}
		
		Comment result = commentRepo.getCommunityComment(commentNo);
		
		if(result == null){
			throw new NotFoundDataException("해당 게시글");
		}
		else{
			//내가 작성한 글인지 확인 -> 작성한글이면 조회수안오름
			Comment check = new Comment(commentNo, userId);			
			check = commentRepo.getCommunityUserComment(check);
			
			if(check == null){
				int hitCount = commentRepo.hitsUpCommunityComment(result);
				logger.trace("게시글 조회수 증가 : {}", hitCount);
			}
			result.setReplyCount(replyRepo.getCountCommentReply(commentNo));
		}
		return result;
	}
	
	//작성자 본인의 글인지 확인
	@Override
	public Comment isCommentUser(Comment comment) throws NotFoundDataException {

		Comment result = commentRepo.getCommunityUserComment(comment);
		if (result == null) {
			logger.error("ERROR!! : 회원님이 작성한 게시글이 아닙니다.");
			throw new NotFoundDataException("회원 본인이 작성한 게시글");
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
		int result = commentRepo.updateCommunityComment(comment);
		
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
		int result = commentRepo.deleteCommunityCommentAndReply(comment);
		if(result != 1){
			throw new RemoveFailException(comment.getCommentTitle() + "게시글");
		}
	}
	
	

	/**
	 * 게시글에 대한 댓글 목록 출력
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
			throw new WriteFailException("댓글");
		}
	}

	@Override
	public void updateReply(Reply reply) throws ChangeValueFailException {
		int result = replyRepo.updateReply(reply);
		if(result != 1){
			throw new ChangeValueFailException("댓글");
		}
	}

	@Override
	public void removeReply(Reply reply) throws RemoveFailException {
		int result = replyRepo.deleteReply(reply);
		if(result != 1){
			throw new RemoveFailException("댓글");
		}
	}
	
	

	
	//----------------------------------------------------------------
	//페이지 리턴
	//----------------------------------------------------------------
	@Override
	public Page getCommentPage(Integer currentPage, Integer pageSize) {
		Page page = new Page();
		page.setServiceKind("COMMUNITY");
		page.setTotalCount(commentRepo.getCountAllCommunityComments());		
		page.setCurrentPage(currentPage);
		page.setPageSize(pageSize);
		page.setTotalPage((page.getTotalCount()-1)/page.getPageSize()+1);
		page.setFromTo();
	
		return page;
	}

	@Override
	public Page getSearchCommentPage(Integer currentPage, Integer pageSize, 
			String search, String keyword, String order) {
		Page page = new Page();
		page.setServiceKind("COMMUNITY");
		page.setTotalCount(commentRepo.getCountSearchCommunityComments(new Page(search, keyword)));
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
		page.setTotalCount(replyRepo.getCountCommentReply(commentNo));
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
		page.setTotalCount(replyRepo.getCountCommentReply(commentNo));
		page.setPageSize(pageSize);
		page.setTotalPage((page.getTotalCount()-1)/page.getPageSize()+1);
		page.setCurrentPage(currentPage);
		page.setFromTo();
		
		return page;
	}
}
