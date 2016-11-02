package leasecity.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import leasecity.dto.community.Comment;
import leasecity.dto.community.Reply;
import leasecity.dto.etc.Page;
import leasecity.dto.user.User;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.ServiceFailException;
import leasecity.exception.WriteFailException;
import leasecity.service.AdminService;
import leasecity.service.QnAService;

@Controller
public class HelpController {
	
	static Logger logger = LoggerFactory.getLogger(HelpController.class);
	public static final int COMMENT_PAGE_SIZE = 12;
	public static final int REPLY_PAGE_SIZE = 10;
	
	@Autowired
	QnAService qnaService;
	
	@Autowired
	AdminService adminService;
	
	@RequestMapping(value="/help/FAQ")
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
	
	@RequestMapping(value="/help/qna/read")
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
				page = qnaService.getSearchQuestionPage(currentPage, COMMENT_PAGE_SIZE, searchPage.getSearch(),
						searchPage.getKeyword(), order);
				logger.trace("page : {}", page);
				comments = qnaService.loadPageQuestions(page);
			} else if (searchPage == null) {
				page = qnaService.getQuestionPage(currentPage, COMMENT_PAGE_SIZE);
				comments = qnaService.loadPageQuestions(page);
			}

			// 1-2. 발급코드가 null이면 ""으로 받음. 아니면 값 그대로 받음.

			// 로그인 중인 유저 탐색 - 로그인유저 값이 null이면 admin값을 불러온다.
			Object userObj = session.getAttribute("loginUser")==null?
					session.getAttribute("admin"):session.getAttribute("loginUser");
			User loginUser = null;
					
			try {
				loginUser = isUserLogin(userObj);
			} catch (ServiceFailException e) {
				redir.addFlashAttribute("join_message", "로그인 세션이 만료되었습니다.");
				return "redirect:/index";
			}

			comment = qnaService.viewQuestion(commentNo, loginUser.getUserId());
			logger.trace("보는 게시글 : {}", comment);

			String commentContent = comment.getCommentContent().replaceAll("\n", "<br>");
			comment.setCommentContent(commentContent);

			if (search != null && keyword != null) {
				page = qnaService.getSearchQuestionPage(currentPage, COMMENT_PAGE_SIZE, search, keyword, order);
			} else if (search == null || keyword == null) {
				page = qnaService.getQuestionPage(currentPage, COMMENT_PAGE_SIZE);
			}
		} catch (NotFoundDataException e) {
			redir.addFlashAttribute("board_message", "비공개 또는 삭제된 게시글입니다.");
			return "redirect:/help/qna";
		}

		// 3.댓글 정보 입력
		try {
			replyPage = qnaService.getFirstAnswerPage(comment.getCommentNo(), REPLY_PAGE_SIZE);
			replys = qnaService.loadQuestionAnswers(replyPage);

			for (Reply reply : replys) {
				String content = reply.getReplyContent();
				content = content.replaceAll("\n", "<br>");
				reply.setReplyContent(content);
			}

		} catch (NotFoundDataException e) {
			model.addAttribute("errorMsg", "등록된 댓글이 없습니다.");
		}

		model.addAttribute("Q_AND_A", comments);
		model.addAttribute("question", comment);
		model.addAttribute("page", page);

		model.addAttribute("answerPage", replyPage);
		model.addAttribute("answers", replys);

		return "help/question_answer_read";
	}
	
	@RequestMapping(value="/help/qna/write")
	public String question_answer_write(Model model){
		Comment question = new Comment();
		model.addAttribute("question", question);
		logger.trace("질문글 작성 페이지 이동");
		return "help/question_answer_write";
	}
	
	// 게시글 작성
		@RequestMapping(value = "/writeQuestion", method = RequestMethod.POST)
		public String writeComment(Model model, HttpSession session,
				RedirectAttributes redir, Comment comment) {
			
			// 1. 유저가 로그인 되있는지 확인
			User user = null;
			// 1-2. 유저가 없을 시 관리자 대입
			Object userObj = session.getAttribute("loginUser")==null?
								session.getAttribute("admin"):session.getAttribute("loginUser");
			try {
				user = isUserLogin(userObj);
			} catch (ServiceFailException e) {
				redir.addFlashAttribute("join_message", "로그인 세션이 만료 되었습니다.");
				return "redirect:/index";
			}			

			// 2. 게시물에 필요 정보 넣기
			comment.setUserId(user.getUserId()); // 로그인된 유저
			logger.trace("작성한 게시물 내용 : {}", comment);
			
			// 3. 게시물 작성
			try {
				qnaService.writeQuestion(comment);
				logger.trace("글 작성 성공");
			} catch (WriteFailException e) {
				redir.addFlashAttribute("board_message", "글 작성 실패.");
				logger.trace("글 작성 실패");
				return "redirect:/help/qna";
			} 
			// 4. 끝
			logger.trace("글 작성 페이지 이동");
			return "redirect:/help/qna/read?commentNo="+comment.getCommentNo();
		}
	
	@RequestMapping(value="/help/qna")
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
				page = qnaService.getSearchQuestionPage
						(currentPage, COMMENT_PAGE_SIZE, searchPage.getSearch(),
								searchPage.getKeyword(), order);
				logger.trace("page : {}", page);
				comments = qnaService.loadTermsQuestions(page);
			}else if(searchPage == null){
				page = qnaService.getQuestionPage(currentPage, COMMENT_PAGE_SIZE);
				comments = qnaService.loadPageQuestions(page);
			}			
				//model.addAttribute("comments", comments);
				model.addAttribute("Q_AND_A", comments);
				model.addAttribute("page", page);
		} catch (NotFoundDataException e) {
			logger.error("게시글이 없음");
			model.addAttribute("errorMsg", "게시글이 없습니다.");
		}
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
