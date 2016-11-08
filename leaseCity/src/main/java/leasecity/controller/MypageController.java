package leasecity.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import leasecity.dto.user.ConstructionCompany;
import leasecity.dto.user.HeavyEquipmentCompany;
import leasecity.dto.user.License;
import leasecity.dto.user.User;
import leasecity.exception.NotFoundDataException;
import leasecity.service.MypageService;

@Controller
public class MypageController {
	
	static Logger logger = LoggerFactory.getLogger(MypageController.class);
	
	@Autowired
	MypageService mypageService;
	
	@RequestMapping(value="/history",method=RequestMethod.GET)
	public String history(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "mypage/history";
	}
	
	@RequestMapping(value="/myinfo")
	public String myinfo(Model model, RedirectAttributes redir,HttpSession session){
		
		User user = (User)session.getAttribute("loginUser");
		if( session.getAttribute("loginUser") != null ) {
			try {
				user = mypageService.searchUser(user.getUserId());
				model.addAttribute("user", user);
			} catch (NotFoundDataException e) {
				redir.addFlashAttribute("join_message", "로그인이 만료되었습니다.");
				return "redirect:/index";
			}
		}
		return "mypage/myinfo";
	}
	
	//마이페이지 개인정보 수정
	@RequestMapping(value="/mypage/identify")
	public String mypage_identify(Model model, RedirectAttributes redir,
			HttpSession session){
		
		User loginUser = (User) session.getAttribute("loginUser");
		logger.trace("회원 정보 : {}", loginUser.userInfo());
		
		loginUser.setPassword("");
		
		if(loginUser instanceof HeavyEquipmentCompany){
			HeavyEquipmentCompany heavyEquipmentCompany = (HeavyEquipmentCompany)loginUser;
			model.addAttribute("heavyEquipmentCompany", heavyEquipmentCompany);
			model.addAttribute("compare", "HEC");
		}else if(loginUser instanceof ConstructionCompany){
			ConstructionCompany constructionCompany = (ConstructionCompany)loginUser;
			
			List<License> licenseList = constructionCompany.getLicenseList();
			
			model.addAttribute("licenseList", licenseList);
			model.addAttribute("compare", "CC");
			model.addAttribute("constructionCompany", constructionCompany);
			
			
			
		}else{
			redir.addFlashAttribute("index_message", "건설업체 또는 중기업체 회원이 아닙니다.");
			return "redirect:/index";
		}
		return "mypage/mypage_identify";
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
