package leasecity.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import leasecity.dto.etc.Page;
import leasecity.dto.lease.LeaseCall;
import leasecity.dto.lease.LeaseRequest;
import leasecity.dto.user.ConstructionCompany;
import leasecity.dto.user.HeavyEquipmentCompany;

@Controller
public class LeaseController {
	static Logger logger = LoggerFactory.getLogger(LeaseController.class);
	@RequestMapping(value="/lease_call")
	public String lease_call(Model model){
		Page page = new Page();
		model.addAttribute("page", page);
		return "lease/lease_call";
		
	}
	
	@RequestMapping(value="/lease_call_write")
	public String lease_call_write(Model model){
		ConstructionCompany constructionCompany = new ConstructionCompany();
		LeaseCall leaseCall = new LeaseCall();
		model.addAttribute("leaseCall", leaseCall);
		model.addAttribute("constructionCompany", constructionCompany);
		return "lease/lease_call_write";
	}
	
	@RequestMapping(value="/lease_call_read")
	public String lease_call_read(Model model){
		ConstructionCompany constructionCompany = new ConstructionCompany();
		LeaseCall leaseCall = new LeaseCall();
		model.addAttribute("leaseCall", leaseCall);
		model.addAttribute("constructionCompany", constructionCompany);
		return "lease/lease_call_read";
	}
	
	@RequestMapping(value="/lease_request")
	public String lease_request(Model model){
		HeavyEquipmentCompany heavyEquipmentCompany = new HeavyEquipmentCompany();
		LeaseRequest leaseRequest = new LeaseRequest();
		model.addAttribute("leaseRequest", leaseRequest);
		model.addAttribute("heavyEquipmentCompany", heavyEquipmentCompany);
		return "lease/lease_request";
	}
	
	@RequestMapping(value="/inquery_heavy")
	public String inquery_heavy(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러aa!!");
		System.out.println("컨틀롤러들어옴!");
		return "lease/inquery_heavy";
	}
}
