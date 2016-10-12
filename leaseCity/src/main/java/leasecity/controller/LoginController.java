package leasecity.controller;

import java.io.UnsupportedEncodingException;
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
import leasecity.service.StandByUserService;
import leasecity.util.SendMailUtil;

@Controller
public class LoginController {

	static Logger logger = LoggerFactory.getLogger(LoginController.class);

	@Autowired
	StandByUserService SBUService;

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index(Model model, Locale locale) {
		
		return "index";
	}
	
	@RequestMapping(value = "/join_cancle", method = RequestMethod.GET)
	public String join_cancle(Model model, Locale locale, SessionStatus status, HttpSession session, RedirectAttributes redir) {
		// 동의 취소시, 전달 메시지 (한번만 보여주는 휘발성 메시지)
		redir.addFlashAttribute("join_message", "회원가입이 최소되었습니다.");
		
		status.setComplete();
		session.invalidate();
		
		return "redirect:/index";
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String sayHello(Model model) {
		//User user = new User();
		//StandByUser standByUser = new StandByUser();
		//model.addAttribute("user", user);
		//model.addAttribute("standByUser", standByUser);
		return "join/login";
	}

	@RequestMapping(value = "/join_input", method = RequestMethod.POST)
	public String join_input(Model model, HttpSession session) {

		User user = new User();
		model.addAttribute("user", user);
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");

		return "join/join_input";
	}

	@RequestMapping(value = "/join_agree", method = RequestMethod.GET, params = { "permissionNo" })
	public String join_agree(Model model, HttpServletRequest req, HttpSession session, RedirectAttributes redir) {

		// 대기 비회원을 저장할 객체
		StandByUser sbu = new StandByUser();

		// 코드 받기
		String permissionNoStr = req.getParameter("permissionNo");
		logger.trace("들어온 permissionNo : {}", req);

		// 코드를 DB와 비교하여 대기 비회원 검색
		try {
			sbu = SBUService.getAgreeStandByUser(permissionNoStr);
			logger.trace("permission 값이 같은 객체 : {}", sbu);
		} catch (NotFoundDataException e) {
			redir.addFlashAttribute("join_message", "가입 승낙 기간이 만료되었습니다.");
			return "redirect:/index";
		}

		// model에 객체 저장하여 보내기
		/*
		 * model.addAttribute("representName", sbu.getRepresentName());
		 * model.addAttribute("companyName", sbu.getCompanyName());
		 * model.addAttribute("email", sbu.getEmail());
		 */

		// session에 객체 저장하여 보내기
		session.setAttribute("representName", sbu.getRepresentName());
		session.setAttribute("companyName", sbu.getCompanyName());
		session.setAttribute("email", sbu.getEmail());

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
			redir.addFlashAttribute("join_message", "가입 요청 성공!"); // (한번만 보여주는 휘발성 메시지)
		} catch (DuplicateValueException e) {
			redir.addFlashAttribute("join_message", "회원가입 요청 실패 - 동일한 업체명, 이메일로 된 대기 유저가 존재합니다.");
			logger.error("DuplicateValueException 에러!", e);
			return "redirect:/login"; // 추후 변경 요망@
		}

		// 3. 관리자 수락 후 처리할 서비스 - db에 수정하기
		try {
			sbu = SBUService.providePermissionCode(sbu);
			logger.trace("관리자의 승인을 받은 임시회원 : {}", sbu);
			logger.trace("가입승인 승낙 성공");
		} catch (NotFoundDataException e) {
			redir.addFlashAttribute("join_message", "회원가입 요청 실패");
			logger.error("NotFoundDataException 에러!", e);
			return "redirect:/index"; // 추후 변경 요망@
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
}