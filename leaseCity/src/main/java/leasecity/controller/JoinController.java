package leasecity.controller;

import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import leasecity.dto.adminwork.StandByUser;
import leasecity.dto.user.ConstructionCompany;
import leasecity.dto.user.HeavyEquipment;
import leasecity.dto.user.HeavyEquipmentCompany;
import leasecity.dto.user.License;
import leasecity.dto.user.User;
import leasecity.exception.DuplicateValueException;
import leasecity.exception.JoinFailException;
import leasecity.exception.NotFoundDataException;
import leasecity.service.StandByUserService;
import leasecity.service.UserService;
import leasecity.util.DateUtil;
import leasecity.util.SendMailUtil;

@Controller
public class JoinController {

	static Logger logger = LoggerFactory.getLogger(JoinController.class);

	@Autowired
	StandByUserService SBUService;

	@Autowired
	UserService UService;

	// (회원 가입시 ) 취소 버튼
	@RequestMapping(value = "/joinCancel", method = RequestMethod.POST)
	public String join_cancel(Model model, RedirectAttributes redir, HttpSession session) {
		// 동의 취소시, 전달 메시지 (한번만 보여주는 휘발성 메시지)
		// 세션에 저장한 회원정보 일괄삭제 
		session.invalidate();
		redir.addFlashAttribute("index_message", "회원가입이 최소되었습니다.");	
		return "redirect:/index";
	}

	// 회원가입 컨트롤러 - 회원가입 폼에 적힌 값들 저장
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(Model model, RedirectAttributes redir,
			HttpSession session, HttpServletRequest request) {
		
		//세션이 만료되었는지 확인
		Object joinOn = session.getAttribute("email");
		if(joinOn == null){
			logger.error("세션이 만료되었습니다.");
			redir.addFlashAttribute("index_message", "세션이 만료되어 회원가입을 할 수 없습니다.");
			return "redirect:/index";
		}

		// 1-1. join_input 폼에서 입력한 '기본' 회원정보 -> 갖고 오기
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		String companyName = request.getParameter("companyName");
		String representName = request.getParameter("representName");
		String representPhone = request.getParameter("representPhone");
		String handPhone = request.getParameter("handPhone");
		String email = request.getParameter("email");
		String zipNo = request.getParameter("zipNo");
		String address = request.getParameter("address");
		String url = request.getParameter("url");
		String notifyOnOff = request.getParameter("notifyOnOff");

		User user = new User(userId, password, companyName, representName, representPhone, handPhone, email, zipNo,
				address, notifyOnOff, url, null, 0.0, null);
		User joinUser = null; //회원가입 하는 유저

		logger.trace("User 컨트롤러 확인 : {}", user);

		// 1-2 company( 중기, 건설 )의 경우에 따라 값 호출
		String company = request.getParameter("company");

		// 건설업체 회원가입 시
		if (company.equals("건설업체")) {

			// 1. 건설업체에 필요한 값 가져오기
			Integer yearlySale = Integer.parseInt(request.getParameter("yearlySale"));
			Integer yearlyAoor = Integer.parseInt(request.getParameter("yearlyAoor"));
			String[] companyCategory = request.getParameterValues("companyCategory");

			// 체크박스 문자열을 이을 스트링버퍼 객체
			StringBuffer sb = new StringBuffer();
			for (String str : companyCategory) {
				sb.append(str + ",");
			}
			sb.deleteCharAt(sb.length() - 1);
			// 분야를 /로 조합한 문자열
			String mixCompanyCategory = sb.toString();

			// 2. 건설업체 객체 초기화
			ConstructionCompany CCompany = new ConstructionCompany(user, yearlySale, yearlyAoor, mixCompanyCategory);

			List<License> licenseList = CCompany.getLicenseList();

			String[] licenseNames = request.getParameterValues("licenseName");
			String[] licenseDates = request.getParameterValues("licenseDate");
			String[] licensers = request.getParameterValues("licenser");
			StringTokenizer strToken;
			
			//하나라도 있으면 추가.
			if(licenseNames != null){
				for (int n = 0; n < licenseNames.length; n++) {
					if (licenseNames[n].length() > 0 && licenseDates[n].length() > 0 && licensers[n].length() > 0) {
						strToken = new StringTokenizer(licenseDates[n], "-");
						// 년도, 월, 일 3가지 Date에 대입
						Date date = DateUtil.getStringDate(strToken.nextToken(), strToken.nextToken(),
								strToken.nextToken());

						licenseList.add(new License(userId, licenseNames[n], date, licensers[n]));
					}
				}
			}

			//가입유저 건설업체에 대입.
			joinUser = CCompany;
		}
		// 중기업체 회원가입 시
		else if (company.equals("중기업체")) {

			String helpOnOff, infoOnOff;

			// 체크박스가 걸려있으면 ON 아니면 OFF
			if (request.getParameter("helpOnOff") == null) {
				helpOnOff = "OFF";
			} else {
				helpOnOff = "ON";
			}

			if (request.getParameter("infoOnOff") == null) {
				infoOnOff = "OFF";
			} else {
				infoOnOff = "ON";
			}

			HeavyEquipmentCompany HCompany = new HeavyEquipmentCompany(user, helpOnOff, infoOnOff);
			logger.trace("중기업체 받은 정보 : {}", HCompany);

			List<HeavyEquipment> HEList = HCompany.getHeavyEquipmentList();

			String[] idNumbers = request.getParameterValues("idNumber");
			String[] equipmentTypes = request.getParameterValues("equipmentType");
			String[] equipmentSizes = request.getParameterValues("equipmentSize");

			for (int n = 0; n < idNumbers.length; n++) {
				// Type + Size
				// Ex)불도저/대
				String equipmentCategory = equipmentTypes[n] + "/" + equipmentSizes[n];
				HEList.add(new HeavyEquipment(idNumbers[n], userId, equipmentCategory, "N"));
			}
			//중기업체 회원가입유저 클래스에 대입.
			joinUser = HCompany;
		}
		
		// 가입
		try {
			// 회원가입 완료 시 대기유저 목록에서 제거. (발급코드도 지움)
			StandByUser SBU = SBUService.getStandByUser(companyName, representName, email);
			SBUService.rejectStandByUser(SBU); //대기유저 삭제
			
			UService.join(joinUser); //회원가입
			redir.addFlashAttribute("index_message", joinUser.getRepresentName() + "님 회원가입에 성공했습니다.");
			logger.trace("회원가입 완료");
		} catch (NotFoundDataException e) {
			logger.error("지울 대기 유저를 찾을 수 없음.");
			redir.addFlashAttribute("index_message", "회원가입에 실패하였습니다.\\n다시 시도 해주세요.");
			return "redirect:/login";
		} catch (JoinFailException e) {
			redir.addFlashAttribute("index_message", "회원가입에 실패하였습니다.\\n다시 시도 해주세요.");
			return "redirect:/login";
		}

		return "redirect:/login";
	}
/*
	@RequestMapping(value = "/loginFromJoin", method = RequestMethod.GET)
	public String loginFromJoin(Model model) {
		return "join/login";
	}*/

	//동의 눌렀을 때 이동하는 컨트롤러
	@RequestMapping(value = "/join_input", method = RequestMethod.POST)
	public String join_input(Model model, HttpSession session, RedirectAttributes redir) {
		String companyName = (String)session.getAttribute("companyName");
		String representName = (String)session.getAttribute("representName");
		String email = (String)session.getAttribute("email");
		
		if(companyName==null || representName==null || email==null){
			redir.addFlashAttribute("index_message", "세션이 만료되어 회원가입을 할 수 없습니다. \\n 메인 페이지로 이동합니다.");
			return "redirect:index";
		}
		
		return "redirect:/joinInput";
	}

	@RequestMapping(value = "/joinInput", method = RequestMethod.GET)
	public String joinInput(Model model, HttpSession session, RedirectAttributes redir) {
		String companyName = (String)session.getAttribute("companyName");
		String representName = (String)session.getAttribute("representName");
		String email = (String)session.getAttribute("email");
		
		if(companyName==null || representName==null || email==null){
			redir.addFlashAttribute("index_message", "세션이 만료되어 회원가입을 할 수 없습니다. \\n 메인 페이지로 이동합니다.");
			return "redirect:index";
		}
		
		return "join/join_input";
	}

	// 회원 가입, 동의 폼 -> 수락유저의 대표자명, 회사명, 이메일이 들어옴.
	@RequestMapping(value = "/join_agree", method = RequestMethod.GET)
	public String joinAgree(Model model, HttpSession session,
			RedirectAttributes redir, HttpServletRequest request) {
		// 코드 받기
		String permissionNo = 
				request.getParameter("permissionNo")!=null?
				request.getParameter("permissionNo"):"";
				//발급코드가 null이면 ""으로 받음. 아니면 값 그대로 받음.
						
		logger.trace("들어온 permissionNo : {}", permissionNo);
		
		// 대기 비회원을 저장할 객체
		StandByUser sbu = null;
		try {
			// 코드를 DB와 비교하여 대기 비회원 검색
			sbu = SBUService.getAgreeStandByUser(permissionNo);
			logger.trace("들어온 대기유저 : {}", sbu);
			session.setAttribute("permissionNo", permissionNo);
			session.setAttribute("companyName", sbu.getCompanyName());
			session.setAttribute("representName", sbu.getRepresentName());
			session.setAttribute("email", sbu.getEmail());
			
			//세션 유지시간 10분.
			session.setMaxInactiveInterval(60 * 10);
		} catch (NotFoundDataException e) {
			// dir에 객체 저장하여 보내기
			redir.addFlashAttribute("index_message", "회원가입을 할 수 없습니다. 메인 페이지로 이동합니다.");
			return "redirect:index";
		}
		return "redirect:/joinAgree";
	}
	
	//PRG
	@RequestMapping(value = "/joinAgree", method = RequestMethod.GET)
	public String joinAgreePRG(Model model, HttpSession session, 
			RedirectAttributes redir, HttpServletRequest request) {	
		String permissionNo = (String)session.getAttribute("permissionNo");
		if(permissionNo== null){
			// dir에 객체 저장하여 보내기
			redir.addFlashAttribute("index_message", "회원가입을 할 수 없습니다. 메인 페이지로 이동합니다.");
			return "redirect:index";
		}

		return "join/join_agree";
	}

	// 회원가입 요청
	@RequestMapping(value = "/popupJoinRequest", method = RequestMethod.POST)
	public String popupJoinRequest(Model model, HttpServletRequest request, RedirectAttributes redir) {

		String companyName = request.getParameter("companyName");
		String representName = request.getParameter("representName");
		String email = request.getParameter("email");

		// 메일 유틸
		SendMailUtil mUtil = new SendMailUtil();

		// 폼에서 값 받기
		StandByUser sbu = new StandByUser();
		sbu.setCompanyName(companyName);
		sbu.setRepresentName(representName);
		sbu.setEmail(email);
		logger.trace("받은 임시 회원 : {}", sbu);

		// 1. db에 저장 후, 메시지
		// 2. 관리자 수락 후 처리할 서비스 - db에 수정하기
		try {
			// 업체명이 겹치거나 이메일이 겹치는게 유저에 있을 경우.
			if (UService.isUserCompanyName(companyName) || UService.isUserEmail(email)) {
				throw new DuplicateValueException();
			}
			SBUService.addStandByUser(sbu);
			logger.trace("저장된 임시 유저 : {}", sbu);
			redir.addFlashAttribute("index_message", "회원가입 요청 성공");

			sbu = SBUService.providePermissionCode(sbu);
			logger.trace("관리자의 승인을 받은 임시회원 : {}", sbu);
			logger.trace("가입승인 승낙 성공");

			// 3. 응답 메시지 후, 관리페이지

			// 4. 메일 발송하기
			String src = "http://localhost:9090/leaseCity/join_agree" + "?permissionNo=" + sbu.getPermissionNo();
			mUtil.sendMail(sbu, src);

			return "redirect:/index";
		} catch (DuplicateValueException e) {
			redir.addFlashAttribute("index_message", "회원가입 요청 실패\\n동일한 업체명, 이메일로 된 유저 혹은 대기유저가 존재합니다.");
			logger.error("회원가입 요청실패");
			return "redirect:/login";
		} catch (NotFoundDataException e) {
			redir.addFlashAttribute("index_message", "회원가입 요청 실패");
			return "redirect:/login";
		}

	}

	// 관리자의 회원가입 승인 컨트롤 ( 아직 사용 X)
	@RequestMapping(value = "/popupJoinResponse", method = RequestMethod.GET)
	public String popup_join_response(Model model, HttpServletRequest request, StandByUser sbu) {

		SendMailUtil mUtil = new SendMailUtil();

		// 1. db에 수정하기
		try {
			SBUService.providePermissionCode(sbu);
			logger.trace("관리자의 승인을 받은 임시회원 : {}", sbu);
		} catch (NotFoundDataException e) {
			return "error/serviceFail";
		}

		// 2. 메일 발송하기

		String src = "http://localhost:9090/leaseCity/join_input" + "?permissionNo=" + sbu.getPermissionNo();
		mUtil.sendMail(sbu, src);

		// 3. 응답 성공 메시지 후, 관리페이지
		return "login";
	}

	@RequestMapping(value = "/validateId", method = RequestMethod.POST)
	public @ResponseBody boolean validateId(Model model, @RequestParam String inputUserId) {
		boolean checkId = UService.isUserId(inputUserId);
		return checkId;
	}

	@RequestMapping(value = "/validateCompanyName", method = RequestMethod.POST)
	public @ResponseBody boolean validateCompanyName(Model model, @RequestParam String inputCompanyName) {
		boolean checkCompanyName = UService.isUserCompanyName(inputCompanyName);
		return checkCompanyName;
	}

	@RequestMapping(value = "/validateEmail", method = RequestMethod.POST)
	public @ResponseBody boolean validateEmail(Model model, @RequestParam String inputEmail) {
		boolean checkEmail = UService.isUserEmail(inputEmail);
		return checkEmail;
	}

	// 주소 찾기 컨트롤
	@RequestMapping(value = "/jusoPopup")
	public String address_input(Model model) {
		logger.trace("jusoPopup check");

		return "join/jusoPopup";
	}

}