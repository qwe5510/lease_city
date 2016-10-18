package leasecity.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
import leasecity.dto.etc.Page;
import leasecity.dto.user.User;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.WriteFailException;
import leasecity.service.CommunityService;

@Controller
public class CommunityController {
	static Logger logger = LoggerFactory.getLogger(CommunityController.class);
	public static final int PAGE_SIZE = 20;
	
	@Autowired
	CommunityService communityService;
	
	//게시판 글 , 댓글 확인
	@RequestMapping(value="/board_read", method = RequestMethod.GET)
	public String board_read(Model model, HttpServletRequest request){
		Comment comment = new Comment();
		
		// 1-1. 게시글 번호 받기
		String commentNo = 
				request.getParameter("commentNo") != null 
				? request.getParameter("commentNo") : "";
		// 1-2. 발급코드가 null이면 ""으로 받음. 아니면 값 그대로 받음.
		logger.trace("들어온 commentNo : {}", commentNo);
		
		// 2. 게시글 번호로 게시글 갖고오기
		try {
			comment = communityService.viewComment(Integer.parseInt(commentNo));
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NotFoundDataException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		model.addAttribute("comment", comment);
		
		return "community/board_read";
		
	}

	//게시글 댓글 작성 페이지 이동 ( 기능 X )
	@RequestMapping(value="/board_write")
	public String board_write(Model model){
		Comment comment = new Comment();
		model.addAttribute("comment", comment);
		logger.trace("글 작성 페이지 이동");
		return "community/board_write";
	}
	
	// 게시글 댓글 작성
	@RequestMapping(value = "/writeComment", method = RequestMethod.POST)
	public String writeComment(Model model, RedirectAttributes redir, Comment comment, HttpSession session) {
		
		// 1. 유저가 로그인 되있는지 확인
		User user = new User();
		try {
			user = isUserLogin(session.getAttribute("loginUser"));
		} catch (WriteFailException e1) {
			redir.addFlashAttribute("join_message", "로그인이 만료됬습니다.");
			return "redirect:/index";
		}

		// 2. 게시물에 필요 정보 넣기
		//comment.setUserId(user.getUserId()); // 로그인된 유저
		comment.setUserId("yhjcom7"); // 임시 아이디
		comment.setCommentCategory(comment.getLocale() + "/" + comment.getKind()); // board 페이지에서 보여줄 정보
		logger.trace("작성한 게시물 내용 : {}", comment);
		
		// 3. 게시물 작성
		try {
			communityService.writeComment(comment);
			session.setAttribute("comment", comment);
			logger.trace("글 작성 성공");
		} catch (WriteFailException e) {
			redir.addFlashAttribute("board_message", "글 작성 실패.");
			logger.trace("글 작성 실패");
			return "redirect:/board";
		}
		
		// 4. 끝
		logger.trace("글 작성 페이지 이동");
		return "redirect:/writeCommentPRG";
	}
	
	// 게시글 댓글 작성 ( PRG 처리, board_read 페이지로 이동 )
	@RequestMapping(value = "/writeCommentPRG")
	public String writeCommentPRG(Model model, HttpSession session) {
		// 작성된 게시물을 확인하기 위해, model에 넣고 board_read 페이지로 이동
		Object obj = session.getAttribute("comment");
		Comment comment = (Comment)obj;
		
		// ( 미완성 )
		model.addAttribute("comment", comment);
		model.addAttribute("userId", comment.getUserId());
		model.addAttribute("commentCategory", comment.getCommentCategory());
		model.addAttribute("regDate", comment.getRegDate());
		model.addAttribute("hits", comment.getHits());
		model.addAttribute("commentTitle", comment.getCommentTitle());
		model.addAttribute("commentContent", comment.getCommentContent());
		model.addAttribute("replyCount", comment.getReplyCount());
		
		return "community/board_read";
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
	
	// 함수 1 : 유저가 로그인 되어있는지 확인
	public User isUserLogin(Object obj) throws WriteFailException {
		
		// 전달 유저
		User user;
		
		// 유저가 로그인 되있는지 확인.
		if ( obj != null ) {
			user = (User) obj;
		} else {
			// 없으면 예외 ( 예외 따로 만들기 )
			throw new WriteFailException("유저가된 유저가 session에 없습니다.");
		}
		
		return user;
	}
	
}
