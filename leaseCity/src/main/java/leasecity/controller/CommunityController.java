package leasecity.controller;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import leasecity.dto.community.Comment;
import leasecity.dto.community.Reply;
import leasecity.dto.etc.Page;
import leasecity.dto.user.User;
import leasecity.exception.ChangeValueFailException;
//github.com/qwe5510/lease_city.git
import leasecity.exception.NotFoundDataException;
import leasecity.exception.RemoveFailException;
import leasecity.exception.WriteFailException;
import leasecity.service.CommunityService;

@Controller
public class CommunityController {
	static Logger logger = LoggerFactory.getLogger(CommunityController.class);
	public static final int COMMENT_PAGE_SIZE = 20;
	public static final int REPLY_PAGE_SIZE = 10;
	
	@Autowired
	CommunityService communityService;
	
	@InitBinder
	public void setBindingFormat(WebDataBinder binder){
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		binder.registerCustomEditor(Date.class, 
				new CustomDateEditor(format, true));
	}
	
	//커뮤니티 메인 페이지
		@RequestMapping(value="/board", method=RequestMethod.GET)
		public String board(Model model, Page searchPage,
				@RequestParam(value="currentPage", required=false) 
				Integer currentPage,
				@RequestParam(value="order", required=false)
				String order){
		
			Page page = null;
			List<Comment> comments = null;
			
			
			
			//값이 없으면 1대입.
			if(currentPage == null)
				currentPage = 1;
			try {
				if(searchPage != null){
					
					String str = searchPage.getKeyword()==null?"":searchPage.getKeyword();
					
					if(!str.matches("/^[ㄱ-ㅎ가-힣0-9a-zA-Z!@#$^&*)(_=+-/*]{2,}$/")){
						logger.error("게시글이 없음");
						model.addAttribute("errorMsg", "조건이 알맞지 않습니다.\\n(%를 제외한 2글자 이상 문자.)");
					}
					
					page = communityService.getSearchCommentPage
							(currentPage, COMMENT_PAGE_SIZE, "COMMUNITY", searchPage.getSearch(),
									searchPage.getKeyword(), order);
					logger.trace("page : {}", page);
					comments = communityService.loadTermsCommunityComment(page);
				}else if(searchPage == null){
					page = communityService.getCommentPage(currentPage,"COMMUNITY", COMMENT_PAGE_SIZE);
					comments = communityService.loadPageCommunityCommentList(page);
				}			
					model.addAttribute("comments", comments);
					model.addAttribute("page", page);
			} catch (NotFoundDataException e) {
				logger.error("게시글이 없음");
				model.addAttribute("errorMsg", "게시글이 없습니다.");
			}
					
			return "community/board";
		}
	
	//게시판 글 , 댓글 확인
	@RequestMapping(value="/board_read", method = RequestMethod.GET)
	public String board_read(Model model, HttpServletRequest request, 
			RedirectAttributes redir, Page searchPage, 

			@RequestParam(value="currentPage", required=false) Integer currentPage,
			@RequestParam(value="commentNo", required=false) Integer commentNo,
			@RequestParam(value="search", required=false) String search,
			@RequestParam(value="keyword", required=false) String keyword,
			@RequestParam(value="order", required=false) String order){ 
		// 게시글 전달(게시물 / 댓글) 객체
		
		Comment comment = null;
		List<Comment> comments = null;
		Page page = null;
		Page replyPage = null;
		List<Reply> replys = null;
		
		// 1-1. 게시글 번호 받기 : RequestParam로 받음
		
		// 2. 게시글 번호로 게시글 갖고 오기 및 게시글 목록 출력
		if(currentPage == null)
			currentPage = 1;
		try {
			
			if(searchPage != null){
				page = communityService.getSearchCommentPage
						(currentPage, COMMENT_PAGE_SIZE, "COMMUNITY", searchPage.getSearch(),
								searchPage.getKeyword(), order);
				logger.trace("page : {}", page);
				comments = communityService.loadTermsCommunityComment(page);
			}else if(searchPage == null){
				page = communityService.getCommentPage(currentPage, "COMMUNITY", COMMENT_PAGE_SIZE);
				comments = communityService.loadPageCommunityCommentList(page);
			}			

			// 1-2. 발급코드가 null이면 ""으로 받음. 아니면 값 그대로 받음.
			logger.trace("들어온 commentNo : {}", commentNo);
			comment = communityService.viewComment(commentNo);
			logger.trace("보는 게시글 : {}", comment);
			
			String[] commentContent = comment.getCommentContent().split("\n");
			StringBuffer sb = new StringBuffer();
			
			for(String CC : commentContent){
				
				if(CC == null){
					sb.append("<p><br></p>");
				}else{
					sb.append("<p>"+CC+"</p>");
				}
			}
			
			comment.setCommentContent(sb.toString());
			
			if(search != null && keyword != null){
				page = communityService.getSearchCommentPage(currentPage, COMMENT_PAGE_SIZE, "COMMUNITY", search, keyword, order);
			}else if(search==null || keyword==null ){
				page = communityService.getCommentPage(currentPage, "COMMUNITY", COMMENT_PAGE_SIZE);
			}
		} catch (NotFoundDataException e) {
			redir.addFlashAttribute("board_message", "비공개 또는 삭제된 게시글입니다.");
			return "redirect:/board";
		}
		
		//3.댓글 정보 입력
		try{
			replyPage = communityService.getFirstReplyPage(comment.getCommentNo(), REPLY_PAGE_SIZE);
			replys = communityService.loadCommentReplys(replyPage);
			
			for(Reply reply : replys){
				String content = reply.getReplyContent();
				content = content.replaceAll("\n", "<br>");
				reply.setReplyContent(content);
			}
			
		}catch (NotFoundDataException e) {
			model.addAttribute("errorMsg", "등록된 댓글이 없습니다.");
		}
		
		model.addAttribute("comments", comments);
		model.addAttribute("comment", comment);
		model.addAttribute("page", page);
		
		model.addAttribute("replyPage", replyPage);
		model.addAttribute("replys", replys);
		
		return "community/board_read";
		
	}
	
	@RequestMapping(value="/board_adjust", method = RequestMethod.POST)
	public String boardAdjust(Model model, Comment comment, 
			@RequestParam Integer currentPage){
		
		logger.trace("수정할 게시글 : {}",comment);
		
		String content = comment.getCommentContent();
		
		content = content.replaceAll("<p>", "").replaceAll("</p>", "");
		comment.setCommentContent(content);
		
		model.addAttribute("comment", comment);
		model.addAttribute("currentPage", currentPage);
		
		return "community/board_adjust";
	}
	
	
	
	@RequestMapping(value="/boardReadReplyAjax", method=RequestMethod.GET)
	public @ResponseBody Map<String, Object> boardReadReplyAjax(
			@RequestParam Integer commentNo,
			@RequestParam Integer currentPage){
		
		Map<String, Object> map = new HashMap<>();
		
		List<Reply> replys = null;
		Page page = communityService.
				getReplyPage(commentNo, currentPage, REPLY_PAGE_SIZE);
		
		try {
			replys = communityService.loadCommentReplys(page);
			
			for(Reply reply : replys){
				String content = reply.getReplyContent();
				content = content.replaceAll("\n", "<br>");
				reply.setReplyContent(content);
			}
			
			map.put("replys", replys);
			map.put("page", page);
			
		} catch (NotFoundDataException e) {
			e.printStackTrace();
		}		
		
		return map;
	}
	
	@RequestMapping(value="/replyRegistryAjax", method=RequestMethod.GET)
	public @ResponseBody Page ReplyRegistryAjax(
			@RequestParam Integer commentNo,
			@RequestParam String userId,
			@RequestParam String replyContent){
		Page page = null;
		Reply reply = new Reply(null, commentNo, userId, null, replyContent, null);
		
		try {
			communityService.writeReply(reply);
			page = communityService.getFirstReplyPage(commentNo, REPLY_PAGE_SIZE);
		} catch (WriteFailException e) {
			logger.trace("댓글 작성 실패");
			return null;
		}
		
		return page;
	}
	
	@RequestMapping(value="/replyAdjustAjax", method=RequestMethod.GET)
	public @ResponseBody Page ReplyAdjustAjax(
			@RequestParam Integer commentNo,
			@RequestParam String userId,
			@RequestParam Integer replyNo,
			@RequestParam String replyContent){
		Page page = null;
		Reply reply = new Reply(replyNo, commentNo, userId, null, replyContent, null);
		
		try {
			communityService.updateReply(reply);
			page = communityService.getFirstReplyPage(commentNo, REPLY_PAGE_SIZE);
		} catch (ChangeValueFailException e) {
			logger.trace("댓글 수정 실패", e);
			return null;
		}
		
		return page;
	}
	
	@RequestMapping(value="/replyRemoveAjax", method=RequestMethod.GET)
	public @ResponseBody Page ReplyRemoveAjax(
			@RequestParam Integer commentNo,
			@RequestParam String userId,
			@RequestParam Integer replyNo){
		Page page = null;
		Reply reply = new Reply(replyNo, commentNo, userId, null, null, null);
		
		try {
			communityService.removeReply(reply);
			page = communityService.getFirstReplyPage(commentNo, REPLY_PAGE_SIZE);
		} catch (RemoveFailException e) {
			logger.trace("댓글 삭제 실패", e);
			return null;
		}
		return page;
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
	public String writeComment(Model model, RedirectAttributes redir, Comment comment) {
		
		/*// 1. 유저가 로그인 되있는지 확인
		User user = new User();
		try {
			user = isUserLogin(session.getAttribute("loginUser"));
		} catch (WriteFailException e1) {
			redir.addFlashAttribute("join_message", "로그인이 만료됬습니다.");
			return "redirect:/index";
		}*/

		// 2. 게시물에 필요 정보 넣기
		//comment.setUserId(user.getUserId()); // 로그인된 유저
		comment.setUserId("ysh5586"); // 임시 아이디
		comment.setCommentCategory(comment.getLocale() + "/" + comment.getKind()); // board 페이지에서 보여줄 정보
		logger.trace("작성한 게시물 내용 : {}", comment);
		
		// 3. 게시물 작성
		try {
			communityService.writeComment(comment);
			logger.trace("글 작성 성공");
		} catch (WriteFailException e) {
			redir.addFlashAttribute("board_message", "글 작성 실패.");
			logger.trace("글 작성 실패");
			return "redirect:/board";
		} 
		// 4. 끝
		logger.trace("글 작성 페이지 이동");
		return "redirect:/board_read?commentNo="+comment.getCommentNo();
	}
	
	//게시글 수정
	@RequestMapping(value = "/adjustComment", method = RequestMethod.POST)
	public String adjustComment(Model model, Comment comment, RedirectAttributes redir,
			@RequestParam Integer currentPage) {
		try {
			comment.setCommentCategory(comment.getLocale() + "/" + comment.getKind());
			communityService.updateComment(comment);
		} catch (ChangeValueFailException e) {
			redir.addFlashAttribute("board_message", "글 수정에 실패하였습니다.");
			logger.trace("글 수정 실패");
			return "redirect:/board";
		}
		
		return "redirect:/board_read?currentPage="+ currentPage +"&commentNo="+comment.getCommentNo();
	}
	
	//게시글 삭제
	@RequestMapping(value="/boardRemove", method = RequestMethod.POST)
	public String boardRemove(Model model, Comment comment, RedirectAttributes redir,
			@RequestParam Integer currentPage){
		try {
			communityService.removeComment(comment);
		} catch (RemoveFailException e) {
			redir.addFlashAttribute("board_message", "'"+ comment.getCommentTitle() + "'글 삭제에 실패하였습니다.");
			logger.trace("글 삭제 실패");
			return "redirect:/board";
		}
		
		return "redirect:/board";
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
