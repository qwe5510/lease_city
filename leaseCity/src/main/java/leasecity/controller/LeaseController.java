package leasecity.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import leasecity.dto.etc.Page;
import leasecity.dto.lease.LeaseCall;
import leasecity.dto.user.ConstructionCompany;

@Controller
public class LeaseController {
	static Logger logger = LoggerFactory.getLogger(LeaseController.class);
	@RequestMapping(value="/lease_request")
	public String lease_request(Model model){
		Page page = new Page();
		model.addAttribute("page", page);
		return "lease/lease_request";
		
	}
	
	@RequestMapping(value="/lease_request_write")
	public String lease_request_write(Model model){
		ConstructionCompany constructionCompany = new ConstructionCompany();
		LeaseCall leaseCall = new LeaseCall();
		model.addAttribute("leaseCall", leaseCall);
		model.addAttribute("constructionCompany", constructionCompany);
		return "lease/lease_request_write";
	}
	
	@RequestMapping(value="/lease_request_read")
	public String lease_request_read(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "lease/lease_request_read";
	}
	
	@RequestMapping(value="/inquery_heavy")
	public String inquery_heavy(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러aa!!");
		System.out.println("컨틀롤러들어옴!");
		return "lease/inquery_heavy";
	}
}
