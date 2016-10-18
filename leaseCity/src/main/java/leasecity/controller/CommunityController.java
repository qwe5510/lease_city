package leasecity.controller;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import leasecity.dto.community.Comment;
import leasecity.dto.etc.Page;
import leasecity.exception.NotFoundDataException;
import leasecity.service.CommunityService;

@Controller
public class CommunityController {
	static Logger logger = LoggerFactory.getLogger(CommunityController.class);
	public static final int PAGE_SIZE = 20;
	
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
	@RequestMapping(value="/board", method=RequestMethod.GET)
	public String board(Model model,
			@RequestParam(value="currentPage", required=false) 
			Integer currentPage){
	
		//값이 없으면 1대입.
		if(currentPage == null)
			currentPage = 1;
		Page page = communityService.getCommentPage(currentPage, 20);

		try {
			List<Comment> comments = communityService.loadPageCommentList(page);
			model.addAttribute("comments", comments);
			model.addAttribute("page", page);
			//communityService.getSearchCommentPage(currentPage, pageSize, search, keyword, order)
		} catch (NotFoundDataException e) {
			logger.error("게시글이 없음");
		} 				
		return "community/board";
	}
	
}
