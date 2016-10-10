package leasecity.controller;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import leasecity.dto.adminwork.StandByUser;
import leasecity.dto.user.User;
import leasecity.util.SendMailUtil;



@Controller
public class LoginController {
	static Logger logger = LoggerFactory.getLogger(LoginController.class);
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String sayHello(Model model){
		User user = new User();
		StandByUser standByUser = new StandByUser();
		model.addAttribute("user",user);
		model.addAttribute("standByUser",standByUser);
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "join/login";
	}
	
	@RequestMapping(value="/popup_join_request",method=RequestMethod.POST)
	public String join_agree(Model model, User user){
		model.addAttribute("message", user.getEmail());
		SendMailUtil util = new SendMailUtil();
		util.sendMail(user);
		return "";
	}
	
	@RequestMapping(value="/join_input")
	public String join_input(Model model){
		User user = new User();
		model.addAttribute("user",user);
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "join/join_input";
	}
	
	@RequestMapping(value="/heavy_equipment_list")
	public @ResponseBody String heavyEquipmentList(
			@RequestParam String data, 
			HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException{
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		
		StringBuffer sb = new StringBuffer();
		sb.append(data).
		append("<input type='text' placeholder='차량 종류'>").
		append("<input type='text' placeholder='차량 크기'>").
		append("<input type='text' placeholder='차량 번호'><br>");	
		
		
		return sb.toString();
	}
}
