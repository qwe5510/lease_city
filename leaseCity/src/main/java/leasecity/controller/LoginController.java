package leasecity.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

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
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import leasecity.dto.adminwork.StandByUser;
import leasecity.dto.user.User;
import leasecity.exception.DuplicateValueException;
import leasecity.exception.NotFoundDataException;
import leasecity.repo.user.UserRepo;
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

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index(Model model, Locale locale) {
		// model.addAttribute("message", "Good Morning");
		return "index";
	}

	@RequestMapping(value = "/join_cancle", method = RequestMethod.GET)
	public String join_cancle(Model model, Locale locale, SessionStatus status, HttpSession session,
			RedirectAttributes redir) {
		// 동의 취소시, 전달 메시지 (한번만 보여주는 휘발성 메시지)
		redir.addFlashAttribute("join_message", "회원가입이 최소되었습니다.");

		status.setComplete();
		session.invalidate();

		return "redirect:/index";
	}

	@RequestMapping(value = "/login")
	public String login(Model model, HttpServletRequest request) {
		User user = new User();
		StandByUser standByUser = new StandByUser();
		model.addAttribute("user", user);
		model.addAttribute("standByUser", standByUser);
		String help = request.getParameter("help");
		logger.trace("체크박스 값 : {}", help);
		return "join/login";
	}

	@RequestMapping(value = "/join_input", method = RequestMethod.POST)
	public String join_input(Model model, RedirectAttributes redir) {

		// 1. join_input 폼에서 입력한 회원정보 -> db에 저장하기

		redir.addFlashAttribute("join_message", "회원가입 성공");
		return "redirect:/index";
	}

	@RequestMapping(value = "/join_agree", method = RequestMethod.GET, params = { "permissionNo" })
	public String join_agree(Model model, HttpServletRequest req, HttpSession session) {

		// 대기 비회원을 저장할 객체
		StandByUser sbu = new StandByUser();

		/*
		 * // 가입시, 아이디 중복을 위해 비교할 회원 정보 List<User> user = new ArrayList<User>();
		 */

		// 코드 받기
		String permissionNoStr = req.getParameter("permissionNo");
		logger.trace("들어온 permissionNo : {}", req);

		// 코드를 DB와 비교하여 대기 비회원 검색
		try {
			sbu = SBUService.getAgreeStandByUser(permissionNoStr);
			// user = URepo.getAllUsers();
			logger.trace("permission 값이 같은 객체 : {}", sbu);
		} catch (NotFoundDataException e) {
			model.addAttribute("join_message", "회원가입을 할 수 없습니다. 메인 페이지로 이동합니다.");
			return "index";
		}

		// model에 객체 저장하여 보내기
		/*
		 * model.addAttribute("representName", sbu.getRepresentName());
		 * model.addAttribute("companyName", sbu.getCompanyName());
		 * model.addAttribute("email", sbu.getEmail());
		 */

		// session에 객체 저장하여 보내기
		// session.setAttribute("user", user); // 아이디 중복 확인 아이디
		session.setAttribute("representName", sbu.getRepresentName());
		session.setAttribute("companyName", sbu.getCompanyName());
		session.setAttribute("email", sbu.getEmail());
		;

		return "join/join_agree";

	}

	// 회원가입 요청
	@RequestMapping(value = "/popup_join_request", method = RequestMethod.POST)
	public String popup_join_request(Model model, HttpServletRequest request, RedirectAttributes redir) {

		// 메일 유틸
		SendMailUtil mUtil = new SendMailUtil();

		// 폼에서 값 받기
		StandByUser sbu = new StandByUser();
		sbu.setCompanyName(request.getParameter("companyName"));
		sbu.setRepresentName(request.getParameter("representName"));
		sbu.setEmail(request.getParameter("email"));
		logger.trace("받은 임시 회원 : {}", sbu);

		// 1. db에 저장 후, 메시지
		try {
			SBUService.addStandByUser(sbu);
			logger.trace("저장된 임시 유저 : {}", sbu);
			redir.addFlashAttribute("join_message", "회원가입 요청 성공");
		} catch (DuplicateValueException e) {
			redir.addFlashAttribute("join_message", "회원가입 요청 실패 - 동일한 업체명, 이메일로 된 대기 유저가 존재합니다.");
			logger.error("회원가입 요청실패");
			return "redirect:/login"; // 추후 변경 요망@
		}

		// 3. 관리자 수락 후 처리할 서비스 - db에 수정하기
		try {
			sbu = SBUService.providePermissionCode(sbu);
			logger.trace("관리자의 승인을 받은 임시회원 : {}", sbu);
			logger.trace("가입승인 승낙 성공");
		} catch (NotFoundDataException e) {
			redir.addFlashAttribute("join_message", "회원가입 요청 실패");
			return "redirect:/login"; // 추후 변경 요망@
		}

		// 4. 메일 발송하기
		String src = "http://localhost:9090/leaseCity/join_agree" + "?permissionNo=" + sbu.getPermissionNo();
		mUtil.sendMail(sbu, src);

		// 3. 응답 성공 메시지 후, 관리페이지

		return "redirect:/index";
	}

	@RequestMapping(value = "/popup_join_response", method = RequestMethod.GET)
	public String popup_join_response(Model model, HttpServletRequest request, StandByUser sbu) {

		SendMailUtil mUtil = new SendMailUtil();

		// 1. db에 수정하기
		try {
			SBUService.providePermissionCode(sbu);
			logger.trace("관리자의 승인을 받은 임시회원 : {}", sbu);
		} catch (NotFoundDataException e) {
			return "error/serviceFail";
		}

		// 2. 메일 발송하기

		String src = "http://localhost:9090/leaseCity/join_input" + "?permissionNo=" + sbu.getPermissionNo();
		mUtil.sendMail(sbu, src);

		// 3. 응답 성공 메시지 후, 관리페이지
		return "login";
	}

	/*
	 * @RequestMapping(value = "/heavy_equipment_list") public @ResponseBody
	 * String heavyEquipmentList(@RequestParam String data) throws
	 * UnsupportedEncodingException {
	 * 
	 * StringBuffer sb = new StringBuffer();
	 * sb.append(data).append("<input type='text' placeholder='차량 종류'>")
	 * .append("<input type='text' placeholder='차량 크기'>")
	 * .append("<input type='text' placeholder='차량 번호'><br>");
	 * 
	 * return sb.toString(); }
	 */

	@RequestMapping(value = "/validate_id", method = RequestMethod.POST)
	public @ResponseBody boolean validate_id(Model model, @RequestParam String input_userId) {
		boolean checkId = UService.isUserId(input_userId);
		logger.trace("폼에 입력된 아이디 : {}", input_userId);
		logger.trace("아이디로 회원 존재 여부 : {}", checkId);
		return checkId;
	}

	// 아이디 찾기 컨트롤
	@RequestMapping(value = "/popup_search_id", method = RequestMethod.POST)
	public String popup_search_id(Model model, HttpServletRequest request, RedirectAttributes redir) {


		// 1. 폼에서 입력된 값 받기
		
		// 2. 입력된 값 --> db와 비교
		
		// 3. 결과 출력 메시지 후, login

		return "redirect:/login";
	}
	
	// 비밀번호 찾기 컨트롤
	@RequestMapping(value = "/popup_search_pass", method = RequestMethod.POST)
	public String popup_search_pass(Model model, HttpServletRequest request, RedirectAttributes redir) {

		// 1. 폼에 입력 값 받기
		
		// 2. 입력된 값 --> db와 비교

		// 3. 결과 출력 메시지 후, 새로운 값 입력 폼 생성
		
		// 4. 비밀번호 수정 후, 결과 출력 메시지 및 login 폼 이동

		return "redirect:/login";
	}
	
	// 비밀번호 찾기 시, 이메일 인증 컨트롤
	@RequestMapping(value = "/popup_search_pass_certification", method = RequestMethod.POST)
	public void popup_search_pass_certification(Model model, HttpServletRequest request, RedirectAttributes redir) {

		// 1. 인증번호 발급
		
		// 2. 해당 유저의 db에 인증번호 저장

		// 3. 응답 성공 메시지 후 비밀번호 찾기 폼으로 ( 입력된 값들은 유지 )

	}
}