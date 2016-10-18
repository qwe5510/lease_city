package leasecity.test;

import java.util.Collections;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import leasecity.config.ApplicationConfig;
import leasecity.dto.community.Comment;
import leasecity.dto.community.Reply;
import leasecity.dto.etc.Page;
import leasecity.exception.NotFoundDataException;
import leasecity.repo.community.CommentRepo;
import leasecity.repo.community.ReplyRepo;
import leasecity.service.CommunityService;
import leasecity.util.DateUtil;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={ApplicationConfig.class})
@Transactional
public class PageTest {
	
	static Logger logger = LoggerFactory.getLogger(PageTest.class);
	
	@Autowired
	CommentRepo repo;
	
	@Autowired
	ReplyRepo subRepo;
	
	@Autowired
	CommunityService service;
	
	@Test
	public void test() throws NotFoundDataException{
		Page page = new Page();
		page.setTotalCount(repo.getCountAllComments());
		page.setPageSize(20);
		page.setCurrentPage(1);
		page.setFromTo();
		page.setOrder("ASC");
		page.setSuperNo(2);
		
		List<Comment> comment = repo.getPageComments(page);
		Collections.reverse(comment);
		
		int count = repo.getCountSearchComments(page);
		
		System.out.println("게시물 갯수 : " + count);
		System.out.println(comment);
		
		Reply reply = new Reply
				(null, 2, "ysh5586", "아무내용이나 달자", null);
		int result = subRepo.insertReply(reply);
		logger.trace("덧글 추가 : {}", result);
		
		List<Reply> replys = subRepo.getPageReplys(page);
		
		logger.trace("덧글 목록 : {}", replys);
		System.out.println(DateUtil.getDateString(replys.get(2).getRegDate()));
		
		replys.get(2).setReplyContent("아무내용이나 왜 달아");
		
		result = subRepo.updateReply(replys.get(2));
		logger.trace("덧글 수정 : {}", result);
		
		result = subRepo.deleteReply(replys.get(2));
		logger.trace("덧글 삭제 : {}", result);	
		
		Page testP = new Page();
		testP.setCurrentPage(1);
		testP.setPageSize(10);
		
		List<Comment> comments = service.loadPageCommentList(testP);
		
		logger.trace("출력된 게시물 : {}", comments);
		
		result = repo.deleteCommentAndReply(comments.get(0));
		logger.trace("삭제된 게시글 : {}", result);
		
		replys = subRepo.getPageReplys(page);
		logger.trace("덧글 목록 확인 : {}", replys);
		
	}
	
	

}
