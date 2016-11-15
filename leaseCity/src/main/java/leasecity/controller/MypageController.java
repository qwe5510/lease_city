package leasecity.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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

import leasecity.dto.adminwork.WorkLog;
import leasecity.dto.etc.Page;
import leasecity.dto.user.ConstructionCompany;
import leasecity.dto.user.HeavyEquipmentCompany;
import leasecity.dto.user.User;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.ServiceFailException;
import leasecity.service.MyPageService;
import leasecity.service.UserService;
import leasecity.util.HashingUtil;

@Controller
public class MypageController {
	
	static Logger logger = LoggerFactory.getLogger(MypageController.class);
	
	@Autowired
	MyPageService myPageService;
	
	@Autowired
	UserService userService;
	
	
	private final static Integer WORK_LOG_SIZE = 5;
	
	
	@InitBinder
	public void dateBinder(WebDataBinder binder) throws Exception{
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat,true));
	}
	
	@RequestMapping(value="/mypage",method=RequestMethod.GET)
	public String mypage(Model model, HttpSession session){
		session.removeAttribute("myInfoCheck");
		
		User user = new User();
		model.addAttribute("user",user);
		return "mypage/mypage";
	}
	
	@RequestMapping(value="/myinfoCheckAjax", method=RequestMethod.GET)
	public @ResponseBody Boolean myinfoAjax(@RequestParam String password, HttpSession session){
		
		User user = session.getAttribute("loginUser")==null?
					(User)session.getAttribute("admin"):
					(User)session.getAttribute("loginUser");
			
		logger.trace("패스워드 전 : {}", password);
		
		password = HashingUtil.hashingString(password);
		
		logger.trace("패스워드 후 : {}", password);
		logger.trace("세션에 저장된 비밀번호 : {}", user.getPassword());
		
		if(user.getPassword().equals(password)){
			session.setAttribute("myInfoCheck", true);
			return true;
		}else{
			return false;
		}	
	}
	
	//마이페이지 메인화면
	@RequestMapping(value="/myinfo")
	public String myinfo(Model model, RedirectAttributes redir,HttpSession session){
		
		User user = (User)session.getAttribute("loginUser");
		if(user != null ) {
			model.addAttribute("user", user);
		}else if(user == null){
			redir.addFlashAttribute("index_message", "유저가 아니거나 세션이 만료 되었습니다.");
			return "redirect:/index";
		}
		
		if(session.getAttribute("myInfoCheck") != null){
			return "mypage/myinfo";
		}else{
			return "error/405";
		}
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
		
		if(session.getAttribute("myInfoCheck") != null){
			return "mypage/mypage_identify";
		}else{
			return "error/405";
		}
		
	}
	
	//작업 기록
	@RequestMapping(value = "/history", method = RequestMethod.GET)
	public String history(Model model, RedirectAttributes redir, HttpSession session) {

		User loginUser = (User) session.getAttribute("loginUser");
		
		if (loginUser == null) {
			redir.addFlashAttribute("index_message", "로그인 세션이 만료되었습니다.");
		}
		else if(loginUser instanceof HeavyEquipmentCompany){
			List<WorkLog> requestLogs = null;
			List<WorkLog> transferLogs = null;
			Page requestPage = null;
			Page transferPage = null;
			
			try {
				requestPage = myPageService.getRequestAndCallLogPage(1, WORK_LOG_SIZE, loginUser.getUserId());
				requestLogs = myPageService.loadPageLeaseRequestAndCallHECWorkLog(requestPage);
				
				logger.trace("임대 신청 기록 : {}", requestLogs);
				
				for(WorkLog requestLog : requestLogs){
					requestLog.setRowNumLogNo(requestPage.getTotalCount()-requestLog.getRowNumLogNo() + 1);
				}		
				
				model.addAttribute("requestPage", requestPage);
				model.addAttribute("requestLogs", requestLogs);
			} catch (NotFoundDataException e) {
				model.addAttribute("ErrorRequestMsg", e.getMessage());
			}
			
			try{
				transferPage = myPageService.getTransferLogPage(1, WORK_LOG_SIZE, loginUser.getUserId());
				transferLogs = myPageService.loadPageLeaseTransferWorkLog(transferPage);
				
				logger.trace("임대 양도 기록 : {}", transferLogs);
				
				for(WorkLog transferLog : transferLogs){
					transferLog.setRowNumLogNo(transferPage.getTotalCount()-transferLog.getRowNumLogNo() + 1);
				}
				
				model.addAttribute("transferPage", transferPage);
				model.addAttribute("transferLogs", transferLogs);
			}catch (NotFoundDataException e) {
				model.addAttribute("ErrorTransferMsg", e.getMessage());
			}
			
			model.addAttribute("isLogin", "HEC");
		}else if(loginUser instanceof ConstructionCompany){
			
			Page callPage = null;
			Page callRequestPage = null;
			List<WorkLog> callLogs = null;
			List<WorkLog> callRequestLogs = null;
			
			//임대 요청 작성 기록
			try {
				callPage = myPageService.getCallLogPage(1, WORK_LOG_SIZE, loginUser.getUserId());
				callLogs = myPageService.loadPageLeaseCallWorkLog(callPage);
				
				for(WorkLog callLog : callLogs){
					callLog.setRowNumLogNo(callPage.getTotalCount()-callLog.getRowNumLogNo() + 1);
				}
				
				model.addAttribute("callPage", callPage);
				model.addAttribute("callLogs", callLogs);
				
			} catch (NotFoundDataException e) {
				model.addAttribute("ErrorCallMsg", e.getMessage());
			}
			
			//임대 요청에 대한 신청 기록
			try {
				
				callRequestPage = myPageService.getCallLogPage(1, WORK_LOG_SIZE, loginUser.getUserId());
				callRequestLogs = myPageService.loadPageLeaseRequestAndCallCCWorkLog(callRequestPage);
				
				for(WorkLog callRequestLog : callRequestLogs){
					callRequestLog.setRowNumLogNo(callRequestPage.getTotalCount()-callRequestLog.getRowNumLogNo() + 1);
				}
				
				model.addAttribute("callRequestPage", callRequestPage);
				model.addAttribute("callRequestLogs", callRequestLogs);
				
			} catch (NotFoundDataException e) {
				model.addAttribute("ErrorCallRequestMsg", e.getMessage());
			}
			
			model.addAttribute("isLogin", "CC");
		}
		if(session.getAttribute("myInfoCheck") != null){
			return "mypage/history";
		}else{
			return "error/405";
		}
	}

	@RequestMapping(value = "/historyRequestPageControlAjax", method = RequestMethod.GET)
	public @ResponseBody String historyRequestPageControlAjax(Model model) {

		return "";
	}
	
	@RequestMapping(value = "/historyTransferPageControlAjax", method = RequestMethod.GET)
	public @ResponseBody String historyTransferPageControlAjax(Model model) {

		return "";
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
	
	
	
	@RequestMapping(value="/security_identify",method=RequestMethod.GET)
	public String security_identify(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "mypage/security_identify";
	}
	
	
	
	@RequestMapping(value="/selection",method=RequestMethod.GET)
	public String selection(Model model, RedirectAttributes redir, HttpSession session){
		User user = (User)session.getAttribute("loginUser");
		
		if(user == null){
			redir.addFlashAttribute("d", "");
		}else if(user instanceof HeavyEquipmentCompany){
			
		}else if(user instanceof ConstructionCompany){
			
		}
		
		
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
