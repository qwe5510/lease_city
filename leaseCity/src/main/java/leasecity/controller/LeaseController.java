package leasecity.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LeaseController {
	static Logger logger = LoggerFactory.getLogger(LeaseController.class);
	@RequestMapping(value="/lease_request",method=RequestMethod.GET)
	public String lease_request(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "lease/lease_request";
		
	}
	
	@RequestMapping(value="/lease_request_write",method=RequestMethod.GET)
	public String lease_request_write(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "lease/lease_request_write";
	}
	
	@RequestMapping(value="/lease_request_read",method=RequestMethod.GET)
	public String lease_request_read(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "lease/lease_request_read";
	}
	
	@RequestMapping(value="/inquery_heavy",method=RequestMethod.GET)
	public String inquery_heavy(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러aa!!");
		System.out.println("컨틀롤러들어옴!");
		return "lease/inquery_heavy";
	}
}
