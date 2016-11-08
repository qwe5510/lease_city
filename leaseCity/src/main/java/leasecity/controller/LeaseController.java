package leasecity.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

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

import leasecity.dto.adminwork.Notify;
import leasecity.dto.etc.Page;
import leasecity.dto.lease.LeaseCall;
import leasecity.dto.lease.LeaseDirectCall;
import leasecity.dto.lease.LeaseRequest;
import leasecity.dto.lease.LeaseTransfer;
import leasecity.dto.user.ConstructionCompany;
import leasecity.dto.user.HeavyEquipment;
import leasecity.dto.user.HeavyEquipmentCompany;
import leasecity.dto.user.User;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.ServiceFailException;
import leasecity.exception.WriteFailException;
import leasecity.service.LeaseService;
import leasecity.service.NotifyService;
import leasecity.service.UserService;
import leasecity.util.DateUtil;

@Controller
public class LeaseController {
	
	@Autowired
	LeaseService leaseService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	NotifyService notifyService;
	
	/**
	 * 임대 요청 기능 페이지 사이즈
	 */
	public static final int LEASE_CALL_PAGE_SIZE = 5;
	
	/**
	 * 중기업체 조회 페이지 사이즈
	 */
	public static final int LOOK_UP_HEC_PAGE_SIZE = 10;
	
	static Logger logger = LoggerFactory.getLogger(LeaseController.class);
	
	
	//날짜값 String형태를 Date로 받아오기.
	@InitBinder
	public void dateBinder(WebDataBinder binder) throws Exception{
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat,true));
	}
	
	
	@RequestMapping(value="/leaseCall", method=RequestMethod.GET)
	public String leaseCall(Model model, Page searchPage,
			@RequestParam(required=false) Integer currentPage){
		
		Page page = null;
		List<LeaseCall> leaseCalls = null;
		
		//값이 없을 경우 1로 초기화
		if(currentPage == null){currentPage = 1;}
		
		try {
			if (searchPage != null) {
				String str = searchPage.getKeyword();

				if (str!=null && str.matches("/^[ㄱ-ㅎ가-힣0-9a-zA-Z!@#$^&*)(_=+-/*]{2,}$/")) {
					model.addAttribute("lease_message", "조건이 알맞지 않습니다.\\n(%를 제외한 2글자 이상 문자.)");
				}
			}
			
			page = leaseService.getMoreViewSearchPage(
									currentPage, LEASE_CALL_PAGE_SIZE,
									searchPage.getSearch(), searchPage.getKeyword());

			logger.trace("page : {}", page);
			leaseCalls = leaseService.loadLeaseCalls(page);
				
			logger.trace("임대요청 : {}", leaseCalls);
			
			model.addAttribute("leaseCalls", leaseCalls);
			model.addAttribute("page", page);
		} catch (NotFoundDataException e) {
			logger.error("임대 요청글이 없음");
			model.addAttribute("errorMsg", "임대 요청글이 없습니다.");
		}
		return "lease/lease_call";
	}
	
	@RequestMapping(value="/moreCallPageAjax", method=RequestMethod.GET)
	public @ResponseBody Map<String, Object> leaseCallWrite(
			@RequestParam Integer currentPage,
			@RequestParam String search,
			@RequestParam String keyword) throws NotFoundDataException{

		Page page = leaseService.getMoreViewSearchPage(
				currentPage, LEASE_CALL_PAGE_SIZE, 
				search, keyword);
		
		logger.trace("Search : {}", search);
		logger.trace("keyword : {}", keyword);
		
		List<LeaseCall> leaseCalls = leaseService.loadLeaseCalls(page);
		
		Map<String, Object> map = new HashMap<>();

		map.put("leaseCalls", leaseCalls);
		map.put("pageCount", page.getTotalCount());
		map.put("pageSize", page.getPageSize());
		
		return map;
	}
	
	@RequestMapping(value="/leaseCall/write", method=RequestMethod.GET)
	public String leaseCall_write(
			Model model, HttpSession session, RedirectAttributes redir){
		
		LeaseCall leaseCall = new LeaseCall();
		User loginUser = (User) session.getAttribute("loginUser");
		
		if(loginUser instanceof ConstructionCompany){
			model.addAttribute("constructionCompany", loginUser);
			model.addAttribute("leaseCall", leaseCall);
		}else{
			redir.addFlashAttribute("lease_message", "건설업체 회원이 아닙니다.");
			return "redirect:/leaseCall";
		}
		return "lease/lease_call_write";
	}

	
	//임대 요청 작성
	@RequestMapping(value="/leaseCallWrite", method = RequestMethod.POST)
	public String leaseCallWrite(Model model, HttpSession session,
			RedirectAttributes redir, LeaseCall leaseCall,
			@RequestParam(required=false) String strToDate,
			@RequestParam(required=false) String strFromDate){
		
		if(strToDate!=null && strFromDate != null){
			StringTokenizer toDate = new StringTokenizer(strToDate, "-");
			StringTokenizer fromDate = new StringTokenizer(strFromDate, "-");
			
			leaseCall.setToDate(
					DateUtil.getStringDate(
					toDate.nextToken(), 
					toDate.nextToken(), 
					toDate.nextToken())
					);
			
			leaseCall.setFromDate(
					DateUtil.getStringDate(
							fromDate.nextToken(), 
							fromDate.nextToken(),
							fromDate.nextToken())
					);
		}
		
		ConstructionCompany user = 
				(ConstructionCompany) session.getAttribute("loginUser");
		//건설업체 회원 정보 주입
		
		StringBuffer commentTitle = new StringBuffer();
	
		commentTitle
		.append(user.getCompanyName())
		.append("(").append(user.getRepresentName()).append(")")
		.append(" '").append(strFromDate)
		.append(" ~ ").append(strToDate)
		.append("' 사이로 중장비 구함");
		
		leaseCall.setUserId(user.getUserId());
		leaseCall.setCompanyName(user.getCompanyName());
		leaseCall.setLeaseCommentTitle(commentTitle.toString());
		logger.trace("임대 요청 확인 : {}", leaseCall);
		
		try {
			leaseService.writeLeaseCall(leaseCall);
		} catch (WriteFailException e) {
			redir.addFlashAttribute("lease_message", "임대 요청글 작성에 실패하였습니다.");
			return "redirect:/leaseCall";
		}
		
		return "redirect:/leaseCall/read?leaseCallNo="+leaseCall.getLeaseCallNo();
	}
	
	@RequestMapping(value="/leaseCall/read", method=RequestMethod.GET)
	public String lease_call_read(Model model, RedirectAttributes redir, HttpSession session,
			@RequestParam(required=false) Integer leaseCallNo){
		
		LeaseCall leaseCall = null;
		User constructionCompany = null;
		
		try {
			if (leaseCallNo == null) {
				redir.addFlashAttribute("lease_message", "요청글이 삭제되었거나 존재하지 않습니다.");
				return "redirect:/leaseCall";
			}
			
			User user = session.getAttribute("loginUser")==null?
						(User)session.getAttribute("admin"):(User)session.getAttribute("loginUser");
			
			leaseCall = leaseService.viewLeaseCall(leaseCallNo, user.getUserId());
			constructionCompany = (User) userService.loadUserInfo(leaseCall.getUserId());
		} catch (NotFoundDataException e) {
			redir.addFlashAttribute("lease_message", "요청글이 삭제되었거나 존재하지 않습니다.");
			return "redirect:/leaseCall";
		}
		
		model.addAttribute("leaseCall", leaseCall);
		model.addAttribute("constructionCompany", constructionCompany);
		return "lease/lease_call_read";
	}
	
	//
	@RequestMapping(value="/leaseCall/leaseRequest", method=RequestMethod.POST)
	public String lease_request(Model model, HttpSession session,
			RedirectAttributes redir, LeaseCall leaseCall){
		
		HeavyEquipmentCompany heavyEquipmentCompany = null;
		List<String> idNumbers = new ArrayList<>();
				
		User loginUser = (User)session.getAttribute("loginUser");
		if(loginUser instanceof HeavyEquipmentCompany){
			try {
				heavyEquipmentCompany = (HeavyEquipmentCompany) loginUser;
				heavyEquipmentCompany.setHeavyEquipmentList(
						userService.loadUserHeavyEquipment(loginUser.getUserId()));

				//임대 요청 차량 가능 여부 조사.
				StringTokenizer st = new StringTokenizer(leaseCall.getEquipmentCategory(), ",");
				
				while(st.hasMoreTokens()){
					String token = st.nextToken();
					
					for(HeavyEquipment HE : heavyEquipmentCompany.getHeavyEquipmentList()){						
						if(HE.getUsedYesNo().equals("N") && 
							token.equals(HE.getEquipmentCategory().split("/")[0])){
								idNumbers.add(HE.getInfo());
								HE.setCheckRequest("Y");
						}else if(HE.getCheckRequest() == null){
							HE.setCheckRequest("N");
						}
					}					
				}
				
				if(idNumbers.size() <= 0){
					redir.addFlashAttribute("lease_message", "신청 할 중장비가 없습니다.");
					return "redirect:/leaseCall/read?leaseCallNo="+ leaseCall.getLeaseCallNo();
				}
				
			} catch (NotFoundDataException e) {
				logger.error("중장비 불러오기 실패");
				redir.addFlashAttribute("lease_message", "중기업체의 중장비를 불러오는데에 실패하였습니다.");
				return "redirect:/leaseCall";
			}
			
		}else{
			redir.addFlashAttribute("lease_message", "중기업체 회원만이 신청할 수 있습니다.");
			return "redirect:/leaseCall";
		}
		
		LeaseRequest leaseRequest = new LeaseRequest(); //신청글 양식 불러오기
		leaseRequest.setLeaseCallNo(leaseCall.getLeaseCallNo());
		
		model.addAttribute("leaseCall", leaseCall);
		model.addAttribute("leaseRequest", leaseRequest);
		model.addAttribute("heavyEquipmentCompany", heavyEquipmentCompany);
		model.addAttribute("idNumbers", idNumbers);
		model.addAttribute("curtLineDate", leaseCall.getFromDate());

		return "lease/lease_request";
	}
	
	
	//임대 요청 작성 등록
	@RequestMapping(value="/leaseCall/RequestWrite", method=RequestMethod.POST)
	public String leaseRequestWrite(Model model, HttpSession session,
			RedirectAttributes redir, LeaseRequest leaseRequest){
		
		
		User user = (User) session.getAttribute("loginUser");
		
		if(user != null){
			leaseRequest.setUserId(user.getUserId());
			//차량번호 다시받기
			String idNumber = leaseRequest.getIdNumber();
			idNumber = idNumber.substring(idNumber.indexOf("(")+1, idNumber.indexOf(")"));
			leaseRequest.setIdNumber(idNumber);
		}
		
		// Notify 추가
		Notify notify = new Notify();
		
		try {
			// 1. 건설업체 요청 갖고 오기
			LeaseCall leaseCall = leaseService.viewLeaseCall(leaseRequest.getLeaseCallNo(), null);
			
			// 2. notify 에 정보 추가
			notify.setUserId(leaseCall.getUserId());
			notify.setLeaseCallNo(leaseCall.getLeaseCallNo());
			notify.setNotifyLink("http://localhost:9090/leaseCity/leaseCall/read?leaseCallNo=" + leaseCall.getLeaseCallNo());
			
			// 3. notify 저장
			notifyService.insertNotifyByLoginUser(notify);
			
			leaseService.doLeaseRequest(leaseRequest);
			redir.addFlashAttribute("lease_message", "임대 신청이 완료되었습니다.");
		} catch (ServiceFailException e) {
			redir.addFlashAttribute("lease_message", "임대 신청에 실패하였습니다.");
		} catch (NotFoundDataException e1) {
			redir.addFlashAttribute("lease_message", "임대 신청에 실패하였습니다.");
		} 
				
		return "redirect:/leaseCall";
	}
	
	/**
	 * 중기업체 조회 컨트롤러
	 * @param model
	 * @param redir
	 * @param session
	 * @param searchPage
	 * @param currentPage
	 * @return
	 */
	@RequestMapping(value="/lookupHeavy", method=RequestMethod.GET)
	public String inquery_heavy(Model model, RedirectAttributes redir,
			HttpSession session, Page searchPage,
			@RequestParam(required=false) Integer currentPage){
		HeavyEquipmentCompany heavyEquipmentCompany = new HeavyEquipmentCompany();
		model.addAttribute("heavyEquipmentCompany", heavyEquipmentCompany);
		
		Page page = null;
		List<HeavyEquipmentCompany> heavyEquipmentCompanies = null;
		
		
		User loginUser = session.getAttribute("loginUser")==null?
				(User)session.getAttribute("admin"):
				(User)session.getAttribute("loginUser");
		
		//값이 없을 경우 1로 초기화
		if(currentPage == null){currentPage = 1;}
		
		try {
			if (searchPage != null) {
				
				if(searchPage.getSearch() != null && searchPage.getSearch().equals("CREDIT")){
					model.addAttribute("creditCheck", "ON");
				}
				
				String str = searchPage.getKeyword();

				if (str!=null && str.matches("/^[ㄱ-ㅎ가-힣0-9a-zA-Z!@#$^&*)(_=+-/*]{2,}$/")) {
					model.addAttribute("leasex_message", "조건이 알맞지 않습니다.\\n(%를 제외한 2글자 이상 문자.)");
				}

				page = leaseService.getMoreViewSearchPage(
									currentPage, LOOK_UP_HEC_PAGE_SIZE,
									searchPage.getSearch(), searchPage.getKeyword());

				logger.trace("page : {}", page);
				heavyEquipmentCompanies = 
						leaseService.lookUpHeavyEquipmentCompanies(loginUser, page);
				
				for(HeavyEquipmentCompany company : heavyEquipmentCompanies){
					String address = company.getAddress();
					int localIdx = address.indexOf(" ", address.indexOf(" ")+1);
					address = address.substring(0, localIdx);
					company.setAddress(address);
					
					List<HeavyEquipment> HEs = company.getHeavyEquipmentList();
					String outputCategory = HEs.get(0).getEquipmentCategory();
					
					if(HEs.size() > 1){
						outputCategory = outputCategory + " 외 " + (HEs.size()-1) + "종";
					}
					company.setOutputCategory(outputCategory);
					company.setOutputWorkLog(userService.getCountWorkLog(company));
				}

			} 
			model.addAttribute("heavyEquipmentCompanies", heavyEquipmentCompanies);
			model.addAttribute("page", page);
		} catch (NotFoundDataException e) {
			logger.error("공개 중인 중기업체 정보가 없습니다.");
			model.addAttribute("errorMsg", "공개 중인 중기업체 정보가 없습니다.");
		}
		
		return "lease/lookup_heavy";
	}
	
	@RequestMapping(value="/moreHECPageAjax", method=RequestMethod.GET)
	public @ResponseBody Map<String, Object> HECPageWrite(
			@RequestParam Integer currentPage,
			@RequestParam String search,
			@RequestParam String keyword,
			HttpSession session) throws NotFoundDataException{

		User loginUser = session.getAttribute("loginUser")==null?
			(User)session.getAttribute("admin"):
			(User)session.getAttribute("loginUser");
		
		logger.trace("받은 유저 확인 : {}", loginUser);
		
		Page page = leaseService.getMoreViewSearchPage(
				currentPage, LOOK_UP_HEC_PAGE_SIZE, search, keyword);
		
		
		List<HeavyEquipmentCompany> HECs = null;
		HECs = leaseService.lookUpHeavyEquipmentCompanies(loginUser, page);
		
		for(HeavyEquipmentCompany company : HECs){
			String address = company.getAddress();
			int localIdx = address.indexOf(" ", address.indexOf(" ")+1);
			address = address.substring(0, localIdx);
			company.setAddress(address);
			
			List<HeavyEquipment> HEs = company.getHeavyEquipmentList();
			String outputCategory = HEs.get(0).getEquipmentCategory();
			
			if(HEs.size() > 1){
				outputCategory = outputCategory + " 외 " + (HEs.size()-1) + "종";
			}
			company.setOutputCategory(outputCategory);
			company.setOutputWorkLog(userService.getCountWorkLog(company));
		}

		Map<String, Object> map = new HashMap<>();

		map.put("HECs", HECs);
		map.put("pageCount", page.getTotalCount());
		map.put("pageSize", page.getPageSize());
		
		return map;
	}
	
	/**
	 * 중기업체 조회 인식 - 
	 * @param model
	 * @param redir
	 * @param session
	 * @param equipmentId
	 * @return
	 */
	@RequestMapping(value="/lookupHeavy/read", method=RequestMethod.GET)
	public String heavyRequest(Model model, RedirectAttributes redir,
			HttpSession session, @RequestParam(required=false) String equipmentId){
		
		List<String> acceptIdNumbers = new ArrayList<>();
		List<String> sendIdNumbers = new ArrayList<>();
		List<String> leaseCallTitles = new ArrayList<>();
				
		try {
			User loginUser = session.getAttribute("loginUser")==null?
					(User)session.getAttribute("admin"):
					(User)session.getAttribute("loginUser");
					
			User user = userService.loadUserInfo(equipmentId);
			HeavyEquipmentCompany HECUser= null;
			
			//중기 업체 일 때, - 양도신청 정보 담기
			if(loginUser instanceof HeavyEquipmentCompany){
				List<HeavyEquipment> HEs = userService.loadUserHeavyEquipment(loginUser.getUserId());
				for(HeavyEquipment HE : HEs){
					if(HE!= null && HE.getUsedYesNo().equals("Y"))
						sendIdNumbers.add(HE.getInfo());
				}
				model.addAttribute("isUser", "HeavyEquipment");
				model.addAttribute("sendIdNumbers", sendIdNumbers);
				
			//건설업체 일 때. - 직접요청 정보 담기.
			}else if(loginUser instanceof ConstructionCompany){
				List<LeaseCall> LCs = leaseService.loadConstructionUserLeaseCalls(loginUser.getUserId());
				
				if(LCs.size() <= 0){
					redir.addFlashAttribute("HEC_message", "요청 할 요청글이 존재하지 않습니다.");
					return "lease/lookup_heavy_read";
				}
				
				for(LeaseCall LC : LCs){
					String title = LC.getLeaseCallNo()+":"+LC.getLeaseCommentTitle();
					leaseCallTitles.add(title);
				}
				
				model.addAttribute("leaseCalls", LCs);
				model.addAttribute("leaseCallTitles", leaseCallTitles);
				model.addAttribute("isUser", "Construction");
			}
			
			if(user instanceof HeavyEquipmentCompany){
				HECUser = (HeavyEquipmentCompany)user;
				HECUser.setHeavyEquipmentList(
						userService.loadUserHeavyEquipment(equipmentId));
				
				for(HeavyEquipment HE : HECUser.getHeavyEquipmentList()){
					if(HE!= null && HE.getUsedYesNo().equals("N"))
						acceptIdNumbers.add(HE.getInfo());
				}
				
				if(acceptIdNumbers.size() <= 0){
					redir.addFlashAttribute("HEC_message", "사용 가능한 차량이 존재하지 않습니다.");
					return "redirect:/lookupHeavy";
				}
				
				model.addAttribute("acceptIdNumbers", acceptIdNumbers);
				model.addAttribute("HECUser", HECUser);
			}
			
		} catch (NotFoundDataException e) {
			logger.trace("존재하지 않는 유저입니다.");
			redir.addFlashAttribute("HEC_message", "존재하지 않는 유저입니다.");
			return "redirect:/lookupHeavy";
		}
		
		LeaseDirectCall leaseDirectCall = new LeaseDirectCall();
		LeaseTransfer leaseTransfer = new LeaseTransfer();
		
		model.addAttribute("leaseDirectCall", leaseDirectCall);
		model.addAttribute("leaseTransfer", leaseTransfer);
		
		return "lease/lookup_heavy_read";
	}
	
	@RequestMapping(value="/callInfoChange", method=RequestMethod.GET)
	public @ResponseBody LeaseCall leaseCallInfoChangeAjax(
			@RequestParam String callNoData) throws NotFoundDataException{
		
			callNoData = callNoData.substring(0, callNoData.indexOf(":"));
			int IntegerData = Integer.parseInt(callNoData);
			LeaseCall result = leaseService.loadLeaseCall(IntegerData);
			System.out.println(result);
		
		return result;
	}
	
	
	@RequestMapping(value="/leaseDirectCallWrite", method=RequestMethod.POST)
	public String directCallWrite(Model model, RedirectAttributes redir, HttpSession session){
		
		
		
		return "";
	}
	
	@RequestMapping(value="/leaseTransferWrite", method=RequestMethod.POST)
	public String transferWrite(Model model, RedirectAttributes redir, HttpSession session){
		
		
		
		return "";
	}
	
	
}
