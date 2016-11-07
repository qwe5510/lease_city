package leasecity.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import leasecity.dto.lease.LeaseCall;
import leasecity.exception.NotFoundDataException;
import leasecity.service.LeaseService;
import leasecity.service.UserService;

@Controller
public class IntroduceController {
	
	@Autowired
	LeaseService leaseService;
	
	@Autowired
	UserService userService;
	
	static Logger logger = LoggerFactory.getLogger(IntroduceController.class);
	
	@RequestMapping(value="/introduction",method=RequestMethod.GET)
	public String introduction(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "introduce/introduction";
	}
	
	@RequestMapping(value="/autoSelectLeaseCalls",method=RequestMethod.GET)
	public @ResponseBody List<LeaseCall> autoSelectLeaseCalls(Model model/*, @RequestParam Integer leaseCallNo*/){
		
		List<LeaseCall> leaseCallList = new ArrayList<LeaseCall>();

		try {
			leaseCallList = leaseService.loadAllLeaseCalls();
			
		} catch (NotFoundDataException e) {
			logger.trace("순위 갖고오기 실패");
			return leaseCallList;
		}
		
		return leaseCallList;
	}
	
}
