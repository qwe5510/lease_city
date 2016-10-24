package leasecity.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import leasecity.dto.community.Comment;
import leasecity.dto.community.Reply;
import leasecity.dto.etc.Page;
import leasecity.dto.user.User;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.ServiceFailException;
import leasecity.service.QnAService;

@Controller
public class HelpController {
	
	static Logger logger = LoggerFactory.getLogger(HelpController.class);
	public static final int COMMENT_PAGE_SIZE = 12;
	public static final int REPLY_PAGE_SIZE = 10;
	
	@Autowired
	QnAService qnaService;
	
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
	public String question_answer_read(Model model, HttpSession session, 
			RedirectAttributes redir, Page searchPage, 
			@RequestParam(value="currentPage", required=false) Integer currentPage,
			@RequestParam(value="commentNo", required=false) Integer commentNo,
			@RequestParam(value="search", required=false) String search,
			@RequestParam(value="keyword", required=false) String keyword,
			@RequestParam(value="order", required=false) String order){
		
		Comment comment = null;
		List<Comment> comments = null;
		Page page = null;
		Page replyPage = null;
		List<Reply> replys = null;
		
		// 1-1. 게시글 번호 받기 : RequestParam로 받음

		// 2. 게시글 번호로 게시글 갖고 오기 및 게시글 목록 출력
		if (currentPage == null)
			currentPage = 1;
		try {

			if (searchPage != null) {
				page = qnaService.getSearchCommentPage(currentPage, COMMENT_PAGE_SIZE, searchPage.getSearch(),
						searchPage.getKeyword(), order);
				logger.trace("page : {}", page);
				comments = qnaService.loadPageQuestions(page);
			} else if (searchPage == null) {
				page = qnaService.getCommentPage(currentPage, COMMENT_PAGE_SIZE);
				comments = qnaService.loadPageQuestions(page);
			}

			// 1-2. 발급코드가 null이면 ""으로 받음. 아니면 값 그대로 받음.

			// 로그인 중인 유저 탐색
			User loginUser = (User) session.getAttribute("loginUser");

			try {
				loginUser = isUserLogin(loginUser);
			} catch (ServiceFailException e) {
				redir.addFlashAttribute("join_message", "로그인 세션이 만료되었습니다.");
				return "redirect:/index";
			}

			logger.trace("들어온 commentNo : {}", commentNo);
			comment = qnaService.viewQuestion(commentNo, loginUser.getUserId());
			logger.trace("보는 게시글 : {}", comment);

			String commentContent = comment.getCommentContent().replaceAll("\n", "<br>");
			comment.setCommentContent(commentContent);

			if (search != null && keyword != null) {
				page = qnaService.getSearchCommentPage(currentPage, COMMENT_PAGE_SIZE, search, keyword, order);
			} else if (search == null || keyword == null) {
				page = qnaService.getCommentPage(currentPage, COMMENT_PAGE_SIZE);
			}
		} catch (NotFoundDataException e) {
			redir.addFlashAttribute("board_message", "비공개 또는 삭제된 게시글입니다.");
			return "redirect:/question_answer";
		}

		// 3.댓글 정보 입력
		try {
			replyPage = qnaService.getFirstReplyPage(comment.getCommentNo(), REPLY_PAGE_SIZE);
			replys = qnaService.loadQuestionAnswers(replyPage);

			for (Reply reply : replys) {
				String content = reply.getReplyContent();
				content = content.replaceAll("\n", "<br>");
				reply.setReplyContent(content);
			}

		} catch (NotFoundDataException e) {
			model.addAttribute("errorMsg", "등록된 댓글이 없습니다.");
		}

		model.addAttribute("comments", comments);
		model.addAttribute("comment", comment);
		model.addAttribute("page", page);

		model.addAttribute("replyPage", replyPage);
		model.addAttribute("replys", replys);

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
		
		// 값이 없으면 1대입.
		if (currentPage == null)
			currentPage = 1;
		
		try {
			if(searchPage != null){
				page = qnaService.getSearchCommentPage
						(currentPage, COMMENT_PAGE_SIZE, searchPage.getSearch(),
								searchPage.getKeyword(), order);
				logger.trace("page : {}", page);
				comments = qnaService.loadTermsQuestions(page);
			}else if(searchPage == null){
				page = qnaService.getCommentPage(currentPage, COMMENT_PAGE_SIZE);
				comments = qnaService.loadPageQuestions(page);
			}			
				//model.addAttribute("comments", comments);
				model.addAttribute("Q_AND_A", comments);
				model.addAttribute("page", page);
		} catch (NotFoundDataException e) {
			logger.error("게시글이 없음");
			model.addAttribute("errorMsg", "게시글이 없습니다.");
		}
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "help/question_answer";
	}
	
	// 함수 1 : 유저가 로그인 되어있는지 확인
	public User isUserLogin(Object obj) throws ServiceFailException {

		// 전달 유저
		User user;

		// 유저가 로그인 되있는지 확인.
		if (obj != null && obj instanceof User) {
			user = (User) obj;
		} else {
			// 없으면 예외 ( 예외 따로 만들기 )
			throw new ServiceFailException();
		}

		return user;
	}
}
