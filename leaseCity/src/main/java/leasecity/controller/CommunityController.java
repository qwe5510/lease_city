package leasecity.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import leasecity.dto.community.Comment;
import leasecity.dto.etc.Page;

@Controller
public class CommunityController {
	static Logger logger = LoggerFactory.getLogger(CommunityController.class);
	
	//게시판 글 , 댓글 확인
	@RequestMapping(value="/board_read",method=RequestMethod.GET)
	public String board_read(Model model){
		model.addAttribute("message", "Good Morning");
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
		Comment comment = new Comment();
		Page page = new Page();
		model.addAttribute("comment", comment);
		model.addAttribute("page", page);
		logger.trace("컨트롤러!!");
		return "community/board";
	}
}
