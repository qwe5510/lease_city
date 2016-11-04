package leasecity.controller;

import java.util.Random;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import leasecity.dto.user.User;
import leasecity.exception.LoginFailException;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.ServiceFailException;
import leasecity.service.StandByUserService;
import leasecity.service.UserService;
import leasecity.util.SendMailUtil;

@Controller
public class LoginController {

	static Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	StandByUserService SBUService;

	@Autowired
	UserService UService;

	// 메인 페이지 PRG
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index(Model model) {		
		return "index";	
	}
	
	// 로그인 폼 ( 이동만 )
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(Model model, HttpSession session) {
		
		//로그인 되어있는 유저 혹은 관리자가 있는 지 확인.
		User loginUser = session.getAttribute("loginUser")==null?
						(User)session.getAttribute("admin"):
						(User)session.getAttribute("loginUser");						
		if(loginUser != null){return "redirect:/index";}
		
		User user = new User();
		model.addAttribute("user", user);
		return "join/login";
	}

	@RequestMapping(value = "/tryLogin")
	public String popup_login(Model model, HttpServletRequest request, RedirectAttributes redir, HttpSession session) {
		
		User user = null;
		User admin = null;
		
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");

		
		//관리자 로그인부터 시도
		try {
			admin = UService.adminLogin(userId, password);
			session.setAttribute("admin", admin);
			redir.addFlashAttribute("join_message", "관리자님 반갑습니다.");
		} catch (LoginFailException e1) { // 관리자 로그인이 실패했을 경우
			try {
				user = UService.login(userId, password);
				logger.trace("로그인 시도 : {}, {}", userId, password);
				session.setAttribute("loginUser", user);
				redir.addFlashAttribute("join_message", userId + "님 로그인 하셨습니다.");
			} catch (LoginFailException e) {
				redir.addFlashAttribute("join_message", "로그인 실패 - 아이디 혹은 비밀번호가 올바르지 않습니다.");
				return "redirect:/login";
			}
		}
		return "redirect:/index";
	}
	
	@RequestMapping(value = "/logout", method=RequestMethod.GET)
	public String logout(Model model, HttpSession session, RedirectAttributes redir){
		session.invalidate();
		redir.addFlashAttribute("join_message", "로그아웃 되었습니다.");
		return "redirect:index";
	}

	// 아이디 찾기 컨트롤
	@RequestMapping(value = "/popupSearchId", method = RequestMethod.POST)
	public String popup_search_id(Model model, HttpServletRequest request, RedirectAttributes redir, User user) {

		// 0. 선언 ( 메일 유틸 )
		SendMailUtil mUtil = new SendMailUtil();

		// 1. 유저 받기
		/*
		 * String companyName = user.getCompanyName(); String representName =
		 * user.getRepresentName(); String email = user.getEmail();
		 */
		logger.trace("아이디 찾을 회원 정보 : {}", user);

		// 2. 서비스로 찾기 ( 이메일 아이디 )
		try {
			user = UService.searchUserId(user);
			mUtil.email_IdCertification(user.getEmail(), user.getUserId());
			redir.addFlashAttribute("join_message", "아이디 찾기 성공 - 이메일로 아이디를 발송했습니다.");
		} catch (NotFoundDataException e) {
			redir.addFlashAttribute("join_message", "아이디 찾기 실패");
			return "redirect:/login";
		}
		// 3. 결과 출력 메시지 후, login
		return "redirect:/popupSearchIdPRG";
	}
	
	@RequestMapping(value = "/popupSearchIdPRG", method = RequestMethod.GET)
	public String popupSearchIdPRG(HttpSession session) {
		return "index";
	}

	// 비밀번호 찾기 컨트롤
	@RequestMapping(value = "/popupSearchPass", method = RequestMethod.POST)
	public @ResponseBody String popup_search_pass(Model model, RedirectAttributes redir, HttpSession session, @RequestParam String userId, @RequestParam String representName, @RequestParam String companyName, @RequestParam String email ) {

		String submit = "fail_notCertification";
		
		User user = new User();
		user.setUserId(userId);
		user.setRepresentName(representName);
		user.setCompanyName(companyName);
		user.setEmail(email);
		
		// 1. 폼에 입력 값 받기
		logger.trace("아이디 찾을 회원 정보 : {}", user);
		
		// 2-1 폼에 입력된 유저가 있는지부터 검색
		try {
			user = UService.searchUserPassword(user);
			logger.trace("폼에 정보로 검색된 유저 : {}", user);
		} catch (NotFoundDataException e) {
			logger.trace("패스워드 찾기 : DB 검색 실패");
			submit = "fail_notFound";
			//redir.addFlashAttribute("join_message", "패스워드 찾기 실패 - 등록되지 않은 회원입니다.");
			return submit;
		}
		
		// 2-2 이메일로 본인 인증이 되있는지 확인
		String matchingResult = "fail";
		if ( session.getAttribute("matchingResult") != null) {
			Object obj = (Object) session.getAttribute("matchingResult");
			matchingResult = (String) obj;
		}
		logger.trace("메칭 결과 : {}", matchingResult);
		if (matchingResult.equals("success")) {
			logger.trace("이메일 인증 확인");
		} else {
			//redir.addFlashAttribute("join_message", "본인 인증 실패 - 인증되지 않은 회원입니다 .");
			logger.trace("이메일 인증 실패");
			return submit;
		}

		// 3. DB에서 검색 및 이메일 인증된 회원 ==> 비밀번호 수정 폼으로 이동

		//session.invalidate();
		session.setAttribute("user", user);
		session.setMaxInactiveInterval(60 * 3);
		submit = "success";
		logger.trace("비밀번호 찾을 유저 : {}", user);

		return submit;
	}

	// 비밀번호 찾기 시, 이메일 인증 컨트롤
	@RequestMapping(value = "/popupSearchPassIssue", method = RequestMethod.POST)
	public @ResponseBody String popupSearchPassIssue(HttpSession session, @RequestParam String email, @RequestParam String userId, @RequestParam String representName, @RequestParam String companyName) {

		// ( User 저장, 전달 객체 )
		User user = new User();
		user.setUserId(userId.replaceAll(" ", ""));
		user.setRepresentName(representName.replaceAll(" ", ""));
		user.setEmail(email.replaceAll(" ", ""));
		user.setCompanyName(companyName.replaceAll(" ", ""));
		// Ajax에서 판단할 String 값 ( success, fail )
		String submit = "fail";
		// 메일 유틸, 보낼 email 주소
		SendMailUtil mUtil = new SendMailUtil();
		
		// 1. 인증번호 발급
		Random randomGenerator = new Random();
		int randomNum = randomGenerator.nextInt(10000) + 1000;
		if (randomNum > 10000) {
			randomNum -= 1000;
		}
		
		// 2. 입력 정보가 등록 회원이 있는지 확인
		// 3. 이메일 전송
		try {
			user = UService.searchUserId(user);
			if(companyName.replaceAll(" ", "").equals(user.getCompanyName()) && 
					representName.replaceAll(" ", "").equals(user.getRepresentName()) && 
					email.replaceAll(" ", "").equals(user.getEmail())) {
				session.setAttribute("randomNum", randomNum);
				session.setMaxInactiveInterval(60 * 3);
				mUtil.email_PasswordCertification(email, randomNum);
				submit = "success";
				logger.trace("이메일 발송 성공");
			} else {
				logger.trace("이메일 발송 실패");
				throw new NotFoundDataException("");
			}
		} catch (NotFoundDataException e) {
			logger.trace("입력된 id를 가진 아이디가 존재 X");
		}

		return submit;
	}

	// 비밀번호 찾기 : 인증번호 입력 및 인증 클릭 시
	@RequestMapping(value = "/popupSearchPassConfirm", method = RequestMethod.POST)
	public @ResponseBody String popupSearchPassConfirm(HttpSession session, @RequestParam String confirmNum) {

		// Ajax에서 판단할 String 값 ( success, fail )
		String submit = "";
		Object obj = (Object) session.getAttribute("randomNum");
		String randomNum = obj.toString();
		logger.trace("세션 저장 값 : {}", randomNum);
		logger.trace("넘어온 값 : {}", confirmNum);

		// 1. 인증번호 매칭
		if (randomNum.equals(confirmNum)) {
			logger.trace("랜덤넘과 매칭 성공");
			submit = "success";
		} else {
			logger.trace("랜덤넘과 매칭 실패");
			submit = "fail";
		}

		session.setAttribute("matchingResult", submit);
		session.setMaxInactiveInterval(60 * 3);

		return submit;
	}
	
	// 비밀번호 찾기 : 인증번호 입력 및 인증 클릭 시
	@RequestMapping(value = "/popupSearchPassChangeInfo", method = RequestMethod.POST)
	public String popupSearchPassChangeInfo(HttpSession session, RedirectAttributes redir, HttpServletRequest request) {
		
		// 1. 비밀번호 불러오기 (request)
		String password = request.getParameter("password");
		// 2. 유저 불러오기 (session)
		Object obj = session.getAttribute("user");
		User user = (User)obj;
		// 3. 유저에 변경할 비밀번호 삽입
		user.setPassword(password);
		
		// 4-1. DB에서 비밀번호 변경
		try {
			UService.changeInfo("password", user);
		} catch (ServiceFailException e) {
			// 4-2 비밀번호 변경 실패
			redir.addFlashAttribute("join_message", "비밀번호 변경 실패.");
			return "redirect:/login";
		}
		
		// (비밀번호 변경 성공 메시지)
		redir.addFlashAttribute("join_message", user.getUserId() + "님! 비밀번호 변경를 변경하셨습니다.");
		
		return "redirect:/popupSearchPassPRG";
	}
	
	@RequestMapping(value = "/popupSearchPassPRG", method = RequestMethod.GET)
	public String popupSearchPassPRG(HttpSession session, RedirectAttributes redir) {
		session.invalidate();
		return "index";
	}


}