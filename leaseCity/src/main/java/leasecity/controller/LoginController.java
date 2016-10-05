package leasecity.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import leasecity.dto.user.User;

@Controller
@SessionAttributes({"user"})
public class LoginController {
	static Logger logger = LoggerFactory.getLogger(LoginController.class);
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String sayHello(Model model){
		User user = new User();
		model.addAttribute("user",user);
		logger.trace("컨트롤러!!");
		return "join/login";
	}
}
