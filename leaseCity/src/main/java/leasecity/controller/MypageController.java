package leasecity.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import leasecity.dto.user.ConstructionCompany;
import leasecity.dto.user.HeavyEquipmentCompany;
import leasecity.dto.user.User;
import leasecity.exception.ServiceFailException;
import leasecity.service.UserService;

@Controller
public class MypageController {
	
	static Logger logger = LoggerFactory.getLogger(MypageController.class);
	
	@Autowired
	UserService userService; 
	
	
	@InitBinder
	public void dateBinder(WebDataBinder binder) throws Exception{
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat,true));
	}
	
	@RequestMapping(value="/history",method=RequestMethod.GET)
	public String history(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "mypage/history";
	}
	
	@RequestMapping(value="/myinfoCheckAjax", method=RequestMethod.GET)
	public @ResponseBody Boolean myinfoAjax(@RequestParam String password, HttpSession session){
		
		
		return false;
	}
	
	@RequestMapping(value="/myinfo", method=RequestMethod.GET)
	public String myinfo(Model model, RedirectAttributes redir,HttpSession session){
		
		User user = (User)session.getAttribute("loginUser");
		if( session.getAttribute("loginUser") != null ) {
			model.addAttribute("user", user);
		}else if(user == null){
			redir.addFlashAttribute("index_message", "로그인 정보가 만료되었습니다.");
			return "redirect:/index";
		}
		return "mypage/myinfo";
	}
	
	//마이페이지 개인정보 수정
	@RequestMapping(value="/mypage/identify")
	public String mypageIdentify(Model model, RedirectAttributes redir,
			HttpSession session){
		
		User loginUser = (User) session.getAttribute("loginUser");
		if(loginUser == null){
			redir.addFlashAttribute("index_message", "로그인 정보가 만료되었습니다.");
			return "redirect:/index";
		}
		
		loginUser.setPassword("");
		if(loginUser instanceof HeavyEquipmentCompany){
			HeavyEquipmentCompany heavyEquipmentCompany = (HeavyEquipmentCompany)loginUser;
			model.addAttribute("heavyEquipmentCompany", heavyEquipmentCompany);
			model.addAttribute("compare", "HEC");
		}else if(loginUser instanceof ConstructionCompany){
			ConstructionCompany constructionCompany = (ConstructionCompany)loginUser;			
			model.addAttribute("compare", "CC");
			model.addAttribute("constructionCompany", constructionCompany);
		}else{
			redir.addFlashAttribute("index_message", "건설업체 또는 중기업체 회원이 아닙니다.");
			return "redirect:/index";
		}
		return "mypage/mypage_identify";
	}
	
	@RequestMapping(value="/ConstructionSuccess", method=RequestMethod.POST)
	public String identifyCCSuccess(Model model, RedirectAttributes redir,
			HttpSession session, ConstructionCompany constructionCompany){
		
		Boolean isPassword = false; //비밀번호 변경 여부 true면 비밀번호도 변경함.
		if(!constructionCompany.getPassword().equals("")){
			isPassword = true;
		}
		
		try {
			userService.changeInfo(isPassword, constructionCompany);
			redir.addFlashAttribute("myinfo_message", "성공적으로 개인정보 수정이 이루어졌습니다!");
			session.setAttribute("loginUser", constructionCompany);
			
		} catch (ServiceFailException e) {
			logger.error("ERROR! - 개인정보 수정 실패 (건설업체)");
			redir.addFlashAttribute("myinfo_message", "개인정보 수정에 실패하였습니다.");
		}
		
		return "redirect:/myinfo";
	}
	
	
	@RequestMapping(value="/HeavyEquipmentCheckAjax", method=RequestMethod.GET)
	public @ResponseBody Boolean identifyHECCheck(@RequestParam String idNumber){
		return userService.checkHEC(idNumber);
	}
	
	@RequestMapping(value="/HeavyEquipmentSuccess", method=RequestMethod.POST)
	public String identifyHECSuccess(Model model, RedirectAttributes redir,
			HttpSession session, HeavyEquipmentCompany heavyEquipmentCompany){
		
		Boolean isPassword = false; //비밀번호 변경 여부 true면 비밀번호도 변경함.
		if(!heavyEquipmentCompany.getPassword().equals("")){
			isPassword = true;
		}
		
		if(heavyEquipmentCompany.getHelpOnOff() == null){
			heavyEquipmentCompany.setHelpOnOff("OFF");
		}
		
		if(heavyEquipmentCompany.getInfoOnOff() == null){
			heavyEquipmentCompany.setInfoOnOff("OFF");
		}
		
		try {
			userService.changeInfo(isPassword, heavyEquipmentCompany);
			redir.addFlashAttribute("myinfo_message", "성공적으로 개인정보 수정이 이루어졌습니다!");
			session.setAttribute("loginUser", heavyEquipmentCompany);
		} catch (ServiceFailException e) {
			logger.error("ERROR! - 개인정보 수정 실패 (중기업체)");
			redir.addFlashAttribute("myinfo_message", "개인정보 수정에 실패하였습니다.");
		}
		
		return "redirect:/myinfo";
	}
	
	@RequestMapping(value="/mypage",method=RequestMethod.GET)
	public String mypage(Model model){
		User user = new User();
		model.addAttribute("user",user);
		return "mypage/mypage";
	}
	
	@RequestMapping(value="/security_identify",method=RequestMethod.GET)
	public String security_identify(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "mypage/security_identify";
	}
	
	
	
	@RequestMapping(value="/selection",method=RequestMethod.GET)
	public String selection(Model model){
		String compare="중기"; //업체를 확인하기위해 임시로 사용한 변수
		model.addAttribute("compare", compare);
		return "mypage/selection";
	}
	
	@RequestMapping(value="/selection_2",method=RequestMethod.GET)
	public String selection_2(Model model){
		String compare="중기"; //업체를 확인하기위해 임시로 사용한 변수
		model.addAttribute("compare", compare);
		return "mypage/selection_2";
	}
	
	@RequestMapping(value="/selection_3",method=RequestMethod.GET)
	public String selection_3(Model model){
		String compare="중기"; //업체를 확인하기위해 임시로 사용한 변수
		model.addAttribute("compare", compare);
		return "mypage/selection_3";
	}
	
	@RequestMapping(value="/withdrawal_agree_01",method=RequestMethod.GET)
	public String withdrawal_agree_01(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "mypage/withdrawal_agree_01";
	}
	
	@RequestMapping(value="/withdrawal_agree_02",method=RequestMethod.GET)
	public String withdrawal_agree_02(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "mypage/withdrawal_agree_02";
	}
	
	
}
