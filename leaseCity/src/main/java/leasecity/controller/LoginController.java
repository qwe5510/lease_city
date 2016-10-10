package leasecity.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import leasecity.dto.adminwork.StandByUser;
import leasecity.dto.user.User;
import leasecity.exception.DuplicateValueException;
import leasecity.service.StandByUserService;
import leasecity.service.UserService;
import leasecity.util.SendMailUtil;



@Controller
public class LoginController {
	
	static Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	StandByUserService SBUService;
	
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String sayHello(Model model){
		User user = new User();
		StandByUser standByUser = new StandByUser();
		model.addAttribute("user",user);
		model.addAttribute("standByUser",standByUser);
		return "join/login";

	}
	
	@RequestMapping(value="/join_input",method=RequestMethod.GET)
	public String join_input(Model model){

		model.addAttribute("message", "Good Morning");

		User user = new User();
		model.addAttribute("user",user);
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");

		return "join/join_input";
	}
	
	@RequestMapping(value="/join_agree",method=RequestMethod.GET)
	public String join_agree(Model model){
		model.addAttribute("message", "Good Morning");
		return "join/join_agree";
	}
	
	@RequestMapping(value="/popup_join_request",method=RequestMethod.POST)
	public String popup_join_request(Model model, HttpServletRequest request, User user){
		
		model.addAttribute("message", user.getEmail());
		
		// 1. db에 저장
		try {
			SBUService.addStandByUser(new StandByUser());
		} catch (DuplicateValueException e) {
			return "error/serviceFail"; //추후 변경 요망@
		}
		
		// 2. 요청 완료 메시지 후, login 창으로 이동
		
		return "join/login";
	}
	
	@RequestMapping(value="/popup_join_response",method=RequestMethod.POST)
	public String popup_join_response(Model model, HttpServletRequest request, StandByUser sbu){
		
		model.addAttribute("message", sbu.getEmail());
		
		SendMailUtil mUtil = new SendMailUtil();
		
		// 1. db에 수정하기
		
		// 2. 메일 발송하기

		String src = "http://localhost:9090/leaseCity/join_input"
					+ "?permissionNo=" + sbu.getPermissionNo();
		mUtil.sendMail(sbu, src);
		
		// 3. 응답 성공 메시지 후, 관리페이지
		return "join/login";
	}
}
