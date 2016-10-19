package leasecity.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import leasecity.dto.adminwork.Answer;
import leasecity.dto.adminwork.Question;
import leasecity.dto.community.Comment;

@Controller
public class HelpController {
	static Logger logger = LoggerFactory.getLogger(HelpController.class);
	@RequestMapping(value="/FAQ")
	public String FAQ(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "help/FAQ";
		
	}
	@RequestMapping(value="/information")
	public String information(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "help/information";
	}
	
	@RequestMapping(value="/question_answer_read")
	public String question_answer_read(Model model){
		Answer answer = new Answer();
		model.addAttribute("answer", answer);
		return "help/question_answer_read";
	}
	
	@RequestMapping(value="/question_answer_write")
	public String question_answer_write(Model model){
		Question question = new Question();
		
		model.addAttribute("question", question);
		return "help/question_answer_write";
	}
	
	@RequestMapping(value="/question_answer")
	public String question_answer(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "help/question_answer";
	}
}
