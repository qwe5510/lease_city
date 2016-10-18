package leasecity.controller;

import java.util.Collections;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import leasecity.dto.community.Comment;
import leasecity.dto.etc.Page;
import leasecity.exception.NotFoundDataException;
import leasecity.service.CommunityService;

@Controller
public class CommunityController {
	static Logger logger = LoggerFactory.getLogger(CommunityController.class);
	
	@Autowired
	CommunityService communityService;
	
	//게시판 글 , 댓글 확인
	@RequestMapping(value="/board_read")
	public String board_read(Model model){
		Comment comment = new Comment();
		model.addAttribute("comment", comment);
		logger.trace("컨트롤러!!");
		return "community/board_read";
		
	}
	//게시글 댓글 작성
	@RequestMapping(value="/board_write")
	public String board_write(Model model){
		Comment comment = new Comment();
		model.addAttribute("comment", comment);
		logger.trace("컨트롤러!!");
		return "community/board_write";
	}
	
	//커뮤니티 메인 페이지
	@RequestMapping(value="/board")
	public String board(Model model){
		Page page = communityService.getCommentPage(1, 20);
		try {
			List<Comment> comments = communityService.loadPageCommentList(page);
			Collections.reverse(comments);
			model.addAttribute("comments", comments);
			model.addAttribute("page", page);
		} catch (NotFoundDataException e) {
			logger.error("게시글이 없음");
		} 				
		return "community/board";
	}
	
}
