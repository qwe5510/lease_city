package leasecity.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import leasecity.dto.etc.Page;
import leasecity.dto.lease.LeaseCall;
import leasecity.dto.lease.LeaseRequest;
import leasecity.dto.user.ConstructionCompany;
import leasecity.dto.user.HeavyEquipment;
import leasecity.dto.user.HeavyEquipmentCompany;
import leasecity.dto.user.User;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.WriteFailException;
import leasecity.service.LeaseService;
import leasecity.service.UserService;
import leasecity.util.DateUtil;

@Controller
public class LeaseController {
	
	@Autowired
	LeaseService leaseService;
	
	@Autowired
	UserService userService;
	
	public static final int LEASE_CALL_PAGE_SIZE = 5; 
	
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

				page = leaseService.getMoreViewSearchPage(
									currentPage, LEASE_CALL_PAGE_SIZE,
									searchPage.getSearch(), searchPage.getKeyword());

				logger.trace("page : {}", page);
				leaseCalls = leaseService.loadLeaseCalls(page);
				
				logger.trace("임대요청 : {}", leaseCalls);
			} 
			model.addAttribute("leaseCalls", leaseCalls);
			model.addAttribute("page", page);
		} catch (NotFoundDataException e) {
			logger.error("임대 요청글이 없음");
			model.addAttribute("errorMsg", "임대 요청글이 없습니다.");
		}

		model.addAttribute("page", searchPage);
		return "lease/lease_call";
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
		
		return "redirect:/leaseCall/read?commentNo="+leaseCall.getLeaseCallNo();
	}
	
	@RequestMapping(value="/leaseCall/read", method=RequestMethod.GET)
	public String lease_call_read(Model model, RedirectAttributes redir,
			@RequestParam(required=false) Integer leaseCallNo){
		
		LeaseCall leaseCall = null;
		User constructionCompany = null;
		
		
		try {
			if (leaseCallNo == null) {
				redir.addFlashAttribute("lease_message", "요청글이 삭제되었거나 존재하지 않습니다.");
				return "redirect:/leaseCall";
			}
			leaseCall = leaseService.viewLeaseCall(leaseCallNo);
			constructionCompany = (User) userService.loadUserInfo(leaseCall.getUserId());
		} catch (NotFoundDataException e) {
			redir.addFlashAttribute("lease_message", "요청글이 삭제되었거나 존재하지 않습니다.");
			return "redirect:/leaseCall";
		}
		
		model.addAttribute("leaseCall", leaseCall);
		model.addAttribute("constructionCompany", constructionCompany);
		return "lease/lease_call_read";
	}
	
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

				System.out.println("임대 요청글 차량 : " + leaseCall.getEquipmentCategory());
				StringTokenizer st = new StringTokenizer(leaseCall.getEquipmentCategory(), ",");
				
				while(st.hasMoreTokens()){
					String token = st.nextToken();
					System.out.println("TOKEN : " + token);
					for(HeavyEquipment HE : heavyEquipmentCompany.getHeavyEquipmentList()){
						if(HE.getUsedYesNo().equals("N") && 
							token.indexOf(HE.getEquipmentCategory()) != -1){
								idNumbers.add(HE.getInfo());
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
		
		LeaseRequest leaseRequest = new LeaseRequest();
		
		model.addAttribute("leaseCall", leaseCall);
		model.addAttribute("leaseRequest", leaseRequest);
		model.addAttribute("heavyEquipmentCompany", heavyEquipmentCompany);
		model.addAttribute("idNumbers", idNumbers);

		return "lease/lease_request";
	}
	
	@RequestMapping(value="/inquery_heavy")
	public String inquery_heavy(Model model){
		HeavyEquipmentCompany heavyEquipmentCompany = new HeavyEquipmentCompany();
		model.addAttribute("heavyEquipmentCompany", heavyEquipmentCompany);
		return "lease/inquery_heavy";
	}
	
	@RequestMapping(value="/heavy_request")
	public String heavy_request(Model model){
		HeavyEquipmentCompany heavyEquipmentCompany = new HeavyEquipmentCompany();
		model.addAttribute("heavyEquipmentCompany", heavyEquipmentCompany);
		return "lease/heavy_request";
	}
}
