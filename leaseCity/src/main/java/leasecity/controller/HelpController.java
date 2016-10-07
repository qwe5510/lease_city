package leasecity.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HelpController {
	static Logger logger = LoggerFactory.getLogger(HelpController.class);
	@RequestMapping(value="/FAQ",method=RequestMethod.GET)
	public String FAQ(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "help/FAQ";
		
	}
	
	@RequestMapping(value="/help_main",method=RequestMethod.GET)
	public String help_main(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "help/help_main";
	}
	
	@RequestMapping(value="/information",method=RequestMethod.GET)
	public String information(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "help/information";
	}
	
	@RequestMapping(value="/question_answer_read",method=RequestMethod.GET)
	public String question_answer_read(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "help/question_answer_read";
	}
	
	@RequestMapping(value="/question_answer_write",method=RequestMethod.GET)
	public String question_answer_write(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "help/question_answer_write";
	}
	
	@RequestMapping(value="/question_answer",method=RequestMethod.GET)
	public String question_answer(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "help/question_answer";
	}
}
