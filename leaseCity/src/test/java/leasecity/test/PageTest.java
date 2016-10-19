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
		Page replPage = service.getFirstReplyPage(241, 10);
		List<Reply> list = service.loadCommentReplys(replPage);
		
		System.out.println(list);
		
		
	}
	
	

}
