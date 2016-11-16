package leasecity.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import leasecity.dto.lease.LeaseCall;
import leasecity.dto.lease.LeaseDirectCall;
import leasecity.dto.lease.LeaseRequest;
import leasecity.dto.lease.LeaseTransfer;
import leasecity.dto.user.ConstructionCompany;
import leasecity.dto.user.HeavyEquipmentCompany;
import leasecity.dto.user.User;
import leasecity.exception.ChangeValueFailException;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.RemoveFailException;
import leasecity.exception.ServiceFailException;
import leasecity.exception.WriteFailException;
import leasecity.service.LeaseService;
import leasecity.service.MyPageService;
import leasecity.service.UserService;
import leasecity.util.DateUtil;
import leasecity.util.HashingUtil;

@Controller
public class MypageController {
	
	static Logger logger = LoggerFactory.getLogger(MypageController.class);
	
	@Autowired
	MyPageService myPageService;
	
	@Autowired
	LeaseService leaseService;
	
	@Autowired
	UserService userService;
	
	
	
	
	private final static Integer WORK_LOG_SIZE = 5;
	
	private final static Integer WORK_MANGE_SIZE = 5;
	
	
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

		password = HashingUtil.hashingString(password);
		
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
				
				callRequestPage = myPageService.getRequestAndCallLogPage(1, WORK_LOG_SIZE, loginUser.getUserId());
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
	
	//임대 요청글에 대한 리스트 불러오기
	@RequestMapping(value = "/historyCallPageControlAjax", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> historyCallPageControlAjax(
			@RequestParam Integer currentPage, HttpSession session) throws NotFoundDataException {
		
		if(currentPage == null)
			currentPage = 1;
		
		User loginUser = (User) session.getAttribute("loginUser");
		
		Page page = myPageService.getCallLogPage(currentPage, WORK_LOG_SIZE, loginUser.getUserId());
		List<WorkLog> workLogs = myPageService.loadPageLeaseCallWorkLog(page);
		
		for(WorkLog callLog : workLogs){
			callLog.setRowNumLogNo(page.getTotalCount()-callLog.getRowNumLogNo() + 1);
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("callPage", page);
		map.put("callWorkLogs", workLogs);	

		return map;
	}
	
	//임대요청글에 대한 신청글 리스트 불러오기 - 건설업체
	@RequestMapping(value = "/historyRequestCallCCPageControlAjax", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> historyRequestCallCCPageControlAjax(
			@RequestParam Integer currentPage, HttpSession session) throws NotFoundDataException {

		if(currentPage == null)
			currentPage = 1;
		
		User loginUser = (User) session.getAttribute("loginUser");
		
		Page page = myPageService.getRequestAndCallLogPage(currentPage, WORK_LOG_SIZE, loginUser.getUserId());
		List<WorkLog> workLogs = myPageService.loadPageLeaseRequestAndCallCCWorkLog(page);
		
		for(WorkLog callLog : workLogs){
			callLog.setRowNumLogNo(page.getTotalCount()-callLog.getRowNumLogNo() + 1);
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("callRequestPage", page);
		map.put("callRequestWorkLogs", workLogs);	

		return map;
	}
	
	
	//임대 요청글에 대한 신청글 리스트 불러오기 - 중기업체
	@RequestMapping(value = "/historyRequestCallHECPageControlAjax", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> historyRequestCallHECPageControlAjax(
			@RequestParam Integer currentPage, HttpSession session) throws NotFoundDataException{

		if(currentPage == null)
			currentPage = 1;
		
		User loginUser = (User) session.getAttribute("loginUser");
		
		Page page = myPageService.getRequestAndCallLogPage(currentPage, WORK_LOG_SIZE, loginUser.getUserId());
		List<WorkLog> workLogs = myPageService.loadPageLeaseRequestAndCallHECWorkLog(page);
		
		for(WorkLog callLog : workLogs){
			callLog.setRowNumLogNo(page.getTotalCount()-callLog.getRowNumLogNo() + 1);
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("requestPage", page);
		map.put("requestWorkLogs", workLogs);	

		return map;
		
	}
	
	//임대 양도에 대한 리스트 불러오기
	@RequestMapping(value = "/historyTransferPageControlAjax", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> historyTransferPageControlAjax(
			@RequestParam Integer currentPage, HttpSession session) throws NotFoundDataException{

		if(currentPage == null)
			currentPage = 1;
		
		User loginUser = (User) session.getAttribute("loginUser");
		
		Page page = myPageService.getTransferLogPage(currentPage, WORK_LOG_SIZE, loginUser.getUserId());
		List<WorkLog> workLogs = myPageService.loadPageLeaseTransferWorkLog(page);
		
		for(WorkLog callLog : workLogs){
			callLog.setRowNumLogNo(page.getTotalCount()-callLog.getRowNumLogNo() + 1);
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("transferPage", page);
		map.put("transferWorkLogs", workLogs);	

		return map;
	}
	
	@RequestMapping(value="/ConstructionSuccess", method=RequestMethod.POST)
	public String identifyCCSuccess(Model model, RedirectAttributes redir,
			HttpSession session, ConstructionCompany constructionCompany){
		
		Boolean isPassword = false; //비밀번호 변경 여부 true면 비밀번호도 변경함.
		User loginUser = (User) session.getAttribute("loginUser");
		
		if(loginUser == null){
			redir.addFlashAttribute("index_message", "로그인 세션이 만료되었습니다.");
			return "redirect:/index";
		}
		
		if(!constructionCompany.getPassword().equals("")){
			isPassword = true;
		}else{
			constructionCompany.setPassword(loginUser.getPassword());
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
		User loginUser = (User) session.getAttribute("loginUser");
		
		if(loginUser == null){
			redir.addFlashAttribute("index_message", "로그인 세션이 만료되었습니다.");
			return "redirect:/index";
		}
		
		if(!heavyEquipmentCompany.getPassword().equals("")){
			isPassword = true;
		}else if(loginUser != null){
			heavyEquipmentCompany.setPassword(loginUser.getPassword());
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
	
	
	
	@RequestMapping(value="/workManagement",method=RequestMethod.GET)
	public String selection(Model model, RedirectAttributes redir, HttpSession session){
		User user = (User)session.getAttribute("loginUser");
		
		if(user == null){
			redir.addFlashAttribute("index_message", "로그인 세션이 만료되었거나 회원이 아닙니다.");
			return "redirect:/index";
		}else if(user instanceof HeavyEquipmentCompany){
			
			Page leaseTransferPage = null;
			List<LeaseTransfer> leaseTransfers = null;
			try {
				leaseTransferPage = leaseService.getTransferPage(1, WORK_MANGE_SIZE, user.getUserId());
				leaseTransfers = leaseService.loadAcceptLeaseTransfer(leaseTransferPage);

				model.addAttribute("leaseTransferPage", leaseTransferPage);
				model.addAttribute("leaseTransfers", leaseTransfers);
			} catch (NotFoundDataException e) {
				model.addAttribute("ErrorTransferMsg", "대기 중인 임대 양도 리스트가 없습니다.");
			}
			
			Page leaseDirectCallPage = null;
			List<LeaseDirectCall> leaseDirectCalls = null;
			
			try {
				leaseDirectCallPage = leaseService.getDirectCallPage(1, WORK_MANGE_SIZE, user.getUserId());
				leaseDirectCalls = leaseService.loadPageLeaseDirectCalls(leaseDirectCallPage);
				
				model.addAttribute("leaseDirectCallPage", leaseDirectCallPage);
				model.addAttribute("leaseDirectCalls", leaseDirectCalls);
			} catch (NotFoundDataException e) {
				model.addAttribute("ErrorDirectCallMsg", "대기 중인 직접 요청 리스트가 없습니다.");
			}
			
			model.addAttribute("compare", "HEC");
		}else if(user instanceof ConstructionCompany){
			model.addAttribute("compare", "CC");
		}
		
		
		return "mypage/work_management";
	}
	
	
	
	
	@RequestMapping(value="/workManagement/transfer",method=RequestMethod.GET)
	public String leaseTransferCheck(Model model, RedirectAttributes redir, HttpSession session,
			@RequestParam Integer leaseTransferNo){
		
		User loginUser = (User) session.getAttribute("loginUser");
		if(loginUser == null){
			model.addAttribute("ldc_message", "로그인 세션이 만료되었습니다.");
		}
		
		try {
			LeaseTransfer leaseTransfer = leaseService.viewLeaseTransfer(leaseTransferNo, loginUser.getUserId());
			model.addAttribute("leaseTransfer", leaseTransfer);
		} catch (NotFoundDataException ez) {
			model.addAttribute("transfer_message", "존재하지 않는 직접 요청 게시물입니다.");
		}
		
		return "mypage/work_management_transfer";
	}
	
	@RequestMapping(value="/workManagement/transfer/permission",method=RequestMethod.POST)
	public String leaseTransferPermission(Model model, RedirectAttributes redir, HttpSession session,
			@RequestParam Integer leaseTransferNo){
		
		User loginUser = (User) session.getAttribute("loginUser");
		if(loginUser == null){
			redir.addFlashAttribute("exitSign", "Error");
		}
		
		try {
			LeaseTransfer leaseTransfer = leaseService.viewLeaseTransfer(leaseTransferNo, loginUser.getUserId());
			
			logger.trace("임대 양도 : {}", leaseTransfer);
			
			leaseService.permissionLeaseTransfer(leaseTransfer);
			redir.addFlashAttribute("exitSign", "permission");
		} catch (NotFoundDataException e) {
			redir.addFlashAttribute("exitSign", "NotFoundDataError");
		} catch (ChangeValueFailException e) {
			redir.addFlashAttribute("exitSign", "ChangeValueFailError");
		} catch (ServiceFailException e) {
			redir.addFlashAttribute("exitSign", "ServiceError");
		}
		
		return "redirect:/workManagement/transfer";
	}
	
	@RequestMapping(value="/workManagement/transfer/rejection",method=RequestMethod.POST)
	public String leaseTransferRejection(Model model, RedirectAttributes redir, HttpSession session,
			@RequestParam Integer leaseTransferNo){
		
		User loginUser = (User) session.getAttribute("loginUser");
		if(loginUser == null){
			redir.addFlashAttribute("exitSign", "Error");
		}
		
		try {
			LeaseTransfer leaseTransfer = leaseService.viewLeaseTransfer(leaseTransferNo, loginUser.getUserId());
			leaseService.rejectionLeaseTransfer(leaseTransfer);
			redir.addFlashAttribute("exitSign", "rejection");
		} catch (NotFoundDataException e) {
			redir.addFlashAttribute("exitSign", "NotFoundDataError");
		} catch (RemoveFailException e) {
			redir.addFlashAttribute("exitSign", "RemoveError");
		} 
		
		return "redirect:/workManagement/transfer";
	}
	
	
	
	@RequestMapping(value="/workManagement/leaseDirectCall",method=RequestMethod.GET)
	public String leaseDirectCallCheck(Model model, @RequestParam(required=false) Integer leaseDirectNo){
		try {
			LeaseDirectCall leaseDirectCall = leaseService.loadLeaseDirectCall(leaseDirectNo);
			LeaseCall leaseCall = leaseService.loadLeaseCall(leaseDirectCall.getLeaseCallNo());			
			logger.trace("직접요청 : {}", leaseDirectCall);
			model.addAttribute("leaseDirectCall", leaseDirectCall);
			model.addAttribute("leaseCall", leaseCall);
			
		} catch (NotFoundDataException e) {
			model.addAttribute("ldc_message", "존재하지 않는 직접 요청 게시물입니다.");
		}
		
		return "mypage/work_management_direct_call";
	}
	
	//직접요청 수락
	@RequestMapping(value="/workManagement/leaseDirectCall/permission", method=RequestMethod.POST)
	public String leaseDirectCallPermission(Model model, RedirectAttributes redir,
			HttpSession session,
			@RequestParam String fromDate,
			@RequestParam String toDate,
			@RequestParam Integer price,
			@RequestParam Integer leaseDirectNo,
			@RequestParam Integer leaseCallNo,
			@RequestParam String callIdNumber){
				
		User loginUser = (User) session.getAttribute("loginUser");
		if(loginUser == null){redir.addFlashAttribute("exitSign", "Error");}
		
		Date fromDt = DateUtil.dateFormat(fromDate);
		Date toDt = DateUtil.dateFormat(toDate);
		
		LeaseRequest leaseRequest = null;
		LeaseDirectCall leaseDirectCall = null;
		
		try {
			leaseRequest = new LeaseRequest(null, leaseCallNo, callIdNumber, loginUser.getUserId(), fromDt, toDt, null, price);
			leaseDirectCall = leaseService.loadLeaseDirectCall(leaseDirectNo);
			
			leaseService.permissionLeaseDirectCall(leaseDirectCall, leaseRequest);
			myPageService.writeRequestWorkLog(leaseRequest, leaseDirectCall.getConstructionId());
			
			//@알림
			
			redir.addFlashAttribute("exitSign", "permission");
		} catch (NotFoundDataException e) {
			redir.addFlashAttribute("exitSign", "NotFoundDataError");
		} catch (ServiceFailException e) {
			redir.addFlashAttribute("exitSign", "ServiceError");
		} catch (RemoveFailException e) {
			redir.addFlashAttribute("exitSign", "RemoveError");
		} catch (WriteFailException e) {
			redir.addFlashAttribute("exitSign", "WriteError");
		}
		
		return "redirect:/workManagement/leaseDirectCall";
	}
	
	//직접요청 거절
	@RequestMapping(value="/workManagement/leaseDirectCall/rejection", method=RequestMethod.POST)
	public String leaseDirectCallRejection(Model model, RedirectAttributes redir,
			HttpSession session, @RequestParam Integer leaseDirectNo){
		LeaseDirectCall leaseDirectCall = null;
		
		try {
			leaseDirectCall = leaseService.loadLeaseDirectCall(leaseDirectNo);
			leaseService.rejectionLeaseDirectCall(leaseDirectCall);
			
			//@알림
			
			redir.addFlashAttribute("exitSign", "rejection");
		} catch (RemoveFailException e) {
			redir.addFlashAttribute("exitSign", "RemoveError");
		} catch (NotFoundDataException e) {
			redir.addFlashAttribute("exitSign", "NotFoundDataError");
		}
		
		return "redirect:/workManagement/leaseDirectCall";
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
	
	// 탈퇴 하기
	@RequestMapping(value="/withdrawalCheckAjax", method=RequestMethod.POST)
	public @ResponseBody Boolean withdrawalCheckAjax(@RequestParam String password, HttpSession session){
		
		User user = session.getAttribute("loginUser")==null?
					(User)session.getAttribute("admin"):
					(User)session.getAttribute("loginUser");
			
		logger.trace("패스워드 전 : {}", password);
		
		password = HashingUtil.hashingString(password);
		
		logger.trace("패스워드 후 : {}", password);
		logger.trace("세션에 저장된 비밀번호 : {}", user.getPassword());
		
		if(user.getPassword().equals(password)){
			user.setWithdrawDate(user.getWithdrawDate());
			userService.changeWithdrawUser(user);
			session.invalidate(); // 로그아웃
			return true;
		}else{
			return false;
		}	
	}
	
}
