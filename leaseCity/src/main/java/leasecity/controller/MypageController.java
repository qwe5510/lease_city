package leasecity.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import leasecity.dto.user.User;
import leasecity.exception.NotFoundDataException;
import leasecity.service.MypageService;

@Controller
public class MypageController {
	
	static Logger logger = LoggerFactory.getLogger(MypageController.class);
	
	@Autowired
	MypageService mypageService;
	
	@RequestMapping(value="/history",method=RequestMethod.GET)
	public String history(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "mypage/history";
	}
	
	@RequestMapping(value="/myinfo",method=RequestMethod.GET)
	public String myinfo(Model model, RedirectAttributes redir,HttpSession session){
		
		User user = (User)session.getAttribute("loginUser");
		if( session.getAttribute("loginUser") != null ) {
			try {
				user = mypageService.searchUser(user.getUserId());
				model.addAttribute("user", user);
			} catch (NotFoundDataException e) {
				redir.addFlashAttribute("join_message", "로그인이 만료되었습니다.");
				return "redirect:/index";
			}
		}
		return "mypage/myinfo";
	}
	
	@RequestMapping(value="/mypage_identify",method=RequestMethod.GET)
	public String mypage_identify(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "mypage/mypage_identify";
	}
	
	@RequestMapping(value="/mypage",method=RequestMethod.GET)
	public String mypage(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "mypage/mypage";
	}
	
	@RequestMapping(value="/security_identify",method=RequestMethod.GET)
	public String security_identify(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "mypage/security_identify";
	}
	
	@RequestMapping(value="/security",method=RequestMethod.GET)
	public String security(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "mypage/security";
	}
	
	@RequestMapping(value="/selection",method=RequestMethod.GET)
	public String selection(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "mypage/selection";
	}
	
	@RequestMapping(value="/withdrawal_agree_01",method=RequestMethod.GET)
	public String withdrawal_agree_01(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "mypage/withdrawal_agree_01";
	}
	
	@RequestMapping(value="/withdrawal_agree_02",method=RequestMethod.GET)
	public String withdrawal_agree_02(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "mypage/withdrawal_agree_02";
	}
	
	
}
