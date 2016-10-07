package leasecity.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CommunityController {
	static Logger logger = LoggerFactory.getLogger(CommunityController.class);
	@RequestMapping(value="/board_read",method=RequestMethod.GET)
	public String board_read(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "community/board_read";
		
	}
	
	@RequestMapping(value="/board_write",method=RequestMethod.GET)
	public String board_write(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "community/board_write";
	}
	
	@RequestMapping(value="/board",method=RequestMethod.GET)
	public String board(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "community/board";
	}
}
