package leasecity.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import leasecity.dto.adminwork.StandByUser;
import leasecity.dto.user.User;

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
		return "login";
	}
}
