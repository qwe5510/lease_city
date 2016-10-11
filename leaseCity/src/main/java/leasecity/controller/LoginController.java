package leasecity.controller;

import java.io.UnsupportedEncodingException;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
		//model.addAttribute("message", "Good Morning");
		return "index";
	}
   
   @RequestMapping(value="/login",method=RequestMethod.GET)
   public String sayHello(Model model){
      User user = new User();
      StandByUser standByUser = new StandByUser();
      model.addAttribute("user",user);
      model.addAttribute("standByUser",standByUser);
      return "join/login";
   }
   
   @RequestMapping(value = "/join_input", method = RequestMethod.GET)
	public String join_input(Model model) {

		model.addAttribute("message", "Good Morning");

		User user = new User();
		model.addAttribute("user", user);
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");

		return "join/join_input";
	}

	@RequestMapping(value = "/join_agree", method = RequestMethod.GET)
	public String join_agree(Model model) {
		model.addAttribute("message", "Good Morning");
		return "join/join_agree";
	}
   
   @RequestMapping(value="/popup_join_request",method=RequestMethod.POST)
   public String popup_join_request(Model model, HttpServletRequest request){
      
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
         model.addAttribute("join_message", "회원가입 요청 성공");
      } catch (DuplicateValueException e) {
    	 model.addAttribute("join_message", "회원가입 요청 실패");
         return "join/login"; //추후 변경 요망@
      }
      
      // 3. db에 수정하기
   		try {
   			SBUService.providePermissionCode(sbu);
   			logger.trace("관리자의 승인을 받은 임시회원 : {}", sbu);
   			logger.trace("가입승인 승낙 성공");
   		} catch (NotFoundDataException e) {
   			model.addAttribute("join_message", "회원가입 요청 실패");
            return "join/login"; //추후 변경 요망@
   		}

   		// 4. 메일 발송하기

   		String src = "http://localhost:9090/leaseCity/join_input" 
   					+ "?permissionNo=" + sbu.getPermissionNo();
   		mUtil.sendMail(sbu, src);

   		// 3. 응답 성공 메시지 후, 관리페이지
      
      return "index";
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

		String src = "http://localhost:9090/leaseCity/join_input" 
					+ "?permissionNo=" + sbu.getPermissionNo();
		mUtil.sendMail(sbu, src);

		// 3. 응답 성공 메시지 후, 관리페이지
		return "login";
	}

	/*@RequestMapping(value = "/heavy_equipment_list")
	public @ResponseBody String heavyEquipmentList(@RequestParam String data) throws UnsupportedEncodingException {

		StringBuffer sb = new StringBuffer();
		sb.append(data).append("<input type='text' placeholder='차량 종류'>")
				.append("<input type='text' placeholder='차량 크기'>")
				.append("<input type='text' placeholder='차량 번호'><br>");

		return sb.toString();
	}*/
}