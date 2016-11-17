package leasecity.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import leasecity.dto.adminwork.StandByUser;
import leasecity.dto.user.User;
import leasecity.exception.NotFoundDataException;
import leasecity.service.LeaseService;
import leasecity.service.StandByUserService;
import leasecity.util.SendMailUtil;

@Controller
public class AdminController {
	
	@Autowired
	StandByUserService standByUserService;

	@RequestMapping(value="/ctrlpage", method=RequestMethod.GET)
	public String ControlPage(Model model, RedirectAttributes redir, 
			HttpSession session){
		
		User admin = (User)session.getAttribute("admin");
		
		try {
			List<StandByUser> standByUsers = standByUserService.getAllStandByUser();
			model.addAttribute("standByUsers", standByUsers);
			
			
		} catch (NotFoundDataException e) {
			model.addAttribute("standByUserErrorMsg", "가입요청한 비회원이 없습니다.");
		}
		
		if(admin == null){
			return "error/403";
		}
		
		return "ctrlpage/admininfo";
	}
	
	
	//대기 유저 요청 수락
	@RequestMapping(value="/ctrlpage/permission", method=RequestMethod.POST)
	public String ControlPagePermission(Model model, 
			RedirectAttributes redir, HttpSession session, 
			@RequestParam String companyName,
			@RequestParam String representName,
			@RequestParam String email){
		
		// 메일 유틸
		SendMailUtil mUtil = new SendMailUtil();
		StandByUser standByUser;
		
		
		try {
			standByUser = standByUserService.getStandByUser(companyName, representName, email);
			standByUser = standByUserService.providePermissionCode(standByUser);
			
			String src = "http://localhost:9090/leaseCity/join_agree" + "?permissionNo=" + standByUser.getPermissionNo();
			mUtil.sendMail(standByUser, src);
			
			redir.addFlashAttribute("ctrl_message", "해당 대기유저의 회원가입을 수락하였습니다.");
		} catch (NotFoundDataException e) {
			redir.addFlashAttribute("ctrl_message", "존재하지 않는 대기유저입니다.");
			return "redirect:/ctrlpage";
		}
		
		return "redirect:/ctrlpage";
	}
	
	//대기 유저 요청 거절
	@RequestMapping(value="/ctrlpage/rejection", method=RequestMethod.POST)
	public String ControlPageRejection(Model model, 
			RedirectAttributes redir, HttpSession session, 
			@RequestParam String companyName,
			@RequestParam String representName,
			@RequestParam String email){
		StandByUser standByUser;
		
		try {
			standByUser = standByUserService.getStandByUser(companyName, representName, email);
			standByUserService.rejectStandByUser(standByUser);
			redir.addFlashAttribute("ctrl_message", "해당 대기유저의 회원가입을 거절하였습니다.");
		} catch (NotFoundDataException e) {
			redir.addFlashAttribute("ctrl_message", "존재하지 않는 대기유저입니다.");
			return "redirect:/ctrlpage";
		}
		
		return "redirect:/ctrlpage";
	}
	
}
