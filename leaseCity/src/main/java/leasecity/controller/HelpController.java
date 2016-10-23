package leasecity.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import leasecity.dto.community.Comment;
import leasecity.dto.etc.Page;
import leasecity.exception.NotFoundDataException;
import leasecity.service.CommunityService;

@Controller
public class HelpController {
	
	static Logger logger = LoggerFactory.getLogger(HelpController.class);
	public static final int COMMENT_PAGE_SIZE = 20;
	
	@Autowired
	CommunityService communityService;
	
	@RequestMapping(value="/FAQ")
	public String FAQ(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "help/FAQ";
		
	}
	@RequestMapping(value="/information")
	public String information(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "help/information";
	}
	
	@RequestMapping(value="/question_answer_read")
	public String question_answer_read(Model model){
		return "help/question_answer_read";
	}
	
	@RequestMapping(value="/question_answer_write")
	public String question_answer_write(Model model){
		return "help/question_answer_write";
	}
	
	@RequestMapping(value="/question_answer")
	public String question_answer(Model model, Page searchPage,
			@RequestParam(value="currentPage", required=false) 
			Integer currentPage,
			@RequestParam(value="order", required=false)
			String order){
		
		Page page = null;
		List<Comment> comments = null;
		List<Comment> questions = null;
		
		// 값이 없으면 1대입.
		if (currentPage == null)
			currentPage = 1;
		
		try {
			if(searchPage != null){
				page = communityService.getSearchCommentPage
						(currentPage, COMMENT_PAGE_SIZE, searchPage.getSearch(),
								searchPage.getKeyword(), order);
				logger.trace("page : {}", page);
				comments = communityService.loadTermsCommunityComment(page);
			}else if(searchPage == null){
				page = communityService.getCommentPage(currentPage, COMMENT_PAGE_SIZE);
				comments = communityService.loadPageCommunityCommentList(page);
			}			
				model.addAttribute("comments", comments);
				model.addAttribute("QNA", comments);
				model.addAttribute("page", page);
		} catch (NotFoundDataException e) {
			logger.error("게시글이 없음");
			model.addAttribute("errorMsg", "게시글이 없습니다.");
		}
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "help/question_answer";
	}
}
