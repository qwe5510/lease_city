package leasecity.controller;

import java.util.Date;
import java.util.List;
import java.util.Locale;

import java.util.Random;

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
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import leasecity.dto.adminwork.StandByUser;
import leasecity.dto.user.ConstructionCompany;
import leasecity.dto.user.HeavyEquipment;
import leasecity.dto.user.HeavyEquipmentCompany;
import leasecity.dto.user.License;
import leasecity.dto.user.User;
import leasecity.exception.DuplicateValueException;
import leasecity.exception.JoinFailException;
import leasecity.exception.LoginFailException;
import leasecity.exception.NotFoundDataException;
import leasecity.service.StandByUserService;
import leasecity.service.UserService;
import leasecity.util.DateUtil;
import leasecity.util.SendMailUtil;

@Controller
public class LoginController {

   static Logger logger = LoggerFactory.getLogger(LoginController.class);

   @Autowired
   StandByUserService SBUService;

   @Autowired
   UserService UService;


   // 메인 페이지
   @RequestMapping(value = "/index", method = RequestMethod.GET)
   public String index(Model model, Locale locale) {

      return "index";
   }

   // (회원 가입시 ) 취소 버튼
   @RequestMapping(value = "/join_cancle", method = RequestMethod.GET)
   public String join_cancle(Model model, Locale locale, 
		   SessionStatus status, HttpSession session, RedirectAttributes redir) {
      // 동의 취소시, 전달 메시지 (한번만 보여주는 휘발성 메시지)
      redir.addFlashAttribute("join_message", "회원가입이 최소되었습니다.");
      
      /*status.setComplete();
      session.invalidate();*/

      return "redirect:/index";

   }

   // 로그인 폼 ( 이동만 )
   @RequestMapping(value = "/login")
   public String login(Model model) {
      User user = new User();
      model.addAttribute("user", user);

      return "join/login";
   }
   
   @RequestMapping(value = "/popup_login")
   public String popup_login(Model model, HttpServletRequest request, RedirectAttributes redir) {
	  String userId = request.getParameter("userId");
	  String password = request.getParameter("password");
	  
	  try {
		UService.login(userId, password);
		logger.trace("로그인 시도 : {}, {}", userId, password);
		redir.addFlashAttribute("join_message", userId + "님 로그인 하셨습니다.");
	} catch (LoginFailException e) {
		redir.addFlashAttribute("join_message", "로그인에 실패하였습니다.");
		return "redirect:/login";
	}
      return "redirect:/index";
   }
   
   // 회원가입 컨트롤러 - 회원가입 폼에 적힌 값들 저장
   @RequestMapping(value = "/join", method = RequestMethod.POST)
   public String join(Model model, RedirectAttributes redir, HttpServletRequest request) {

	   // 삭제할 대기유저 추가
	   StandByUser sbu = new StandByUser();
	   
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
	   
	   User user = new User(userId, password, companyName, representName, 
			   				representPhone, handPhone, email, zipNo, address, 
			   				notifyOnOff, url, null, 0.0, null);

	   logger.trace("User 컨트롤러 확인 : {}", user);
	   
	   // 1-2 company( 중기, 건설 )의 경우에 따라 값 호출
	   String company = request.getParameter("company");
	   
	   if ( company.equals("건설업체")) {
		   
		   // 1. 건설업체에 필요한 값 가져오기
		   Integer yearlySale = Integer.parseInt(request.getParameter("yearlySale"));
		   Integer yearlyAoor = Integer.parseInt(request.getParameter("yearlyAoor"));
		   String[] companyCategory = request.getParameterValues("companyCategory");
		   
		   //체크박스 문자열을 이을 스트링버퍼 객체
		   StringBuffer sb = new StringBuffer();
		   for(String str : companyCategory){
			 sb.append(str + "/");
		   }
		   sb.deleteCharAt(sb.length()-1);
		   //분야를 /로 조합한 문자열
		   String mixCompanyCategory = sb.toString();
		   
		   // 2. 건설업체 객체 초기화
		   ConstructionCompany CCompany = 
				   new ConstructionCompany(user, yearlySale, yearlyAoor, mixCompanyCategory);
		   
		   List<License> licenseList = CCompany.getLicenseList();
		   
		   String[] licenseNames = request.getParameterValues("licenseName");
		   String[] licenseDates = request.getParameterValues("licenseDate");
		   String[] licensers = request.getParameterValues("licenser");  
		   StringTokenizer strToken;
		   
		   for(int n=0; n<licenseNames.length; n++){
			   if(licenseNames[n].length() <=0 || 
					   licenseDates[n].length() <=0 || 
					   licensers[n].length() <=0){
				   strToken = new StringTokenizer(licenseDates[n], "-");
				   //년도, 월, 일 3가지 Date에 대입
				   Date date = DateUtil.getStringDate(
						   strToken.nextToken(), 
						   strToken.nextToken(), 
						   strToken.nextToken());
			
				   licenseList.add(new License(userId, licenseNames[n], date, licensers[n]));
			   }
		   }
		
		   // 3. 가입
		   try {
			UService.join(CCompany);
			redir.addFlashAttribute("join_message", CCompany.getRepresentName() + "님 회원가입에 성공했습니다.");
		} catch (JoinFailException e) {
			redir.addFlashAttribute("join_message", "회원가입 실패.");
			return "join/join_input";
		}
		  
		  
	   } else if( company.equals("중기업체") ){
		   
		   String helpOnOff, infoOnOff;
		   
		   //체크박스가 걸려있으면 ON 아니면 OFF
		   if(request.getParameter("helpOnOff")==null)
		   		{helpOnOff = "OFF";	}
		   else {helpOnOff = "ON";	}
		   
		   if(request.getParameter("infoOnOff")==null)
		   		{infoOnOff = "OFF"; }
		   else	{infoOnOff = "ON";  }
		   
		   // 1. 
		   HeavyEquipmentCompany HCompany = 
				   new HeavyEquipmentCompany(user, helpOnOff, infoOnOff);
		   logger.trace("중기업체 받은 정보 : {}", HCompany);
		   
		   List<HeavyEquipment> HEList = HCompany.getHeavyEquipmentList();
		   
		   String[] idNumbers = request.getParameterValues("idNumber");
		   String[] equipmentTypes = request.getParameterValues("equipmentType");
		   String[] equipmentSizes = request.getParameterValues("equipmentSize");
		   
		   
		   for(int n=0; n < idNumbers.length; n++){
			 //Type + Size 
			   //Ex)불도저/대
			   String equipmentCategory = equipmentTypes[n] + "/" + equipmentSizes[n];
			   HEList.add(new HeavyEquipment(idNumbers[n], userId, equipmentCategory,  "N"));
		   }
   
		   // 2. 가입
		   try {
				UService.join(HCompany);
				redir.addFlashAttribute("join_message", HCompany.getRepresentName() + "님 회원가입에 성공했습니다.");
			} catch (JoinFailException e) {
				redir.addFlashAttribute("join_message", "회원가입 실패.");
				return "join/join_input";
			}
	   }
	   logger.trace("회원가입 완료");
	   

      return "redirect:/index";
   }
   
   @RequestMapping(value = "/join_input", method = RequestMethod.POST)
   public String join_input(Model model, RedirectAttributes redir) {

      // 1. join_input 폼에서 입력한 회원정보 -> db에 저장하기

      return "join/join_input";
   }

   // 회원 가입, 동의 폼 -> 수락유저의 대표자명, 회사명, 이메일이 들어옴.
   @RequestMapping(value = "/join_agree", method = RequestMethod.GET, params = { "permissionNo" })
   public String join_agree(Model model, HttpServletRequest req, HttpSession session, RedirectAttributes redir) {

      // 대기 비회원을 저장할 객체
      StandByUser sbu = new StandByUser();

      // 코드 받기
      String permissionNoStr = req.getParameter("permissionNo");
      logger.trace("들어온 permissionNo : {}", permissionNoStr);

      // 코드를 DB와 비교하여 대기 비회원 검색
      try {
         sbu = SBUService.getAgreeStandByUser(permissionNoStr);
         logger.trace("permission 값이 같은 객체 : {}", sbu);
      } catch (NotFoundDataException e) {
         redir.addFlashAttribute("join_message", "회원가입을 할 수 없습니다. 메인 페이지로 이동합니다.");
         return "index";
      }

      // session에 객체 저장하여 보내기
      session.setAttribute("representName", sbu.getRepresentName());
      session.setAttribute("companyName", sbu.getCompanyName());
      session.setAttribute("email", sbu.getEmail());

      return "join/join_agree";

   }

   // 회원가입 요청
   @RequestMapping(value = "/popup_join_request", method = RequestMethod.POST)
   public String popup_join_request(Model model, HttpServletRequest request, RedirectAttributes redir) {

      // 메일 유틸
      SendMailUtil mUtil = new SendMailUtil();

      // 폼에서 값 받기
      StandByUser sbu = new StandByUser();
      sbu.setCompanyName(request.getParameter("companyName"));
      sbu.setRepresentName(request.getParameter("representName"));
      sbu.setEmail(request.getParameter("email"));
      logger.trace("받은 임시 회원 : {}", sbu);

      // 1. db에 저장 후, 메시지
      try {
         SBUService.addStandByUser(sbu);
         logger.trace("저장된 임시 유저 : {}", sbu);
         redir.addFlashAttribute("join_message", "회원가입 요청 성공");
      } catch (DuplicateValueException e) {
         redir.addFlashAttribute("join_message", "회원가입 요청 실패 - 동일한 업체명, 이메일로 된 대기 유저가 존재합니다.");
         logger.error("회원가입 요청실패");
         return "redirect:/login"; // 추후 변경 요망@

      }

      // 3. 관리자 수락 후 처리할 서비스 - db에 수정하기
      try {
         sbu = SBUService.providePermissionCode(sbu);
         logger.trace("관리자의 승인을 받은 임시회원 : {}", sbu);
         logger.trace("가입승인 승낙 성공");
      } catch (NotFoundDataException e) {
         redir.addFlashAttribute("join_message", "회원가입 요청 실패");
         return "redirect:/login"; // 추후 변경 요망@
      }

      // 4. 메일 발송하기
      String src = "http://localhost:9090/leaseCity/join_agree" + "?permissionNo=" + sbu.getPermissionNo();
      mUtil.sendMail(sbu, src);

      // 3. 응답 메시지 후, 관리페이지
      return "redirect:/index";
   }

   // 관리자의 회원가입 승인 컨트롤 ( 아직 사용 X)
   @RequestMapping(value = "/popup_join_response", method = RequestMethod.GET)
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

   @RequestMapping(value = "/validate_id", method = RequestMethod.POST)
   public @ResponseBody boolean validateId(Model model, @RequestParam String inputUserId) {
      boolean checkId = UService.isUserId(inputUserId);
      return checkId;
   }
   
   @RequestMapping(value = "/validate_company_name", method = RequestMethod.POST)
   public @ResponseBody boolean validateCompanyName(Model model, @RequestParam String inputCompanyName) {
      boolean checkCompanyName = UService.isUserId(inputCompanyName);
      return checkCompanyName;
   }
   
   @RequestMapping(value = "/validate_email", method = RequestMethod.POST)
   public @ResponseBody boolean validate_id(Model model, @RequestParam String inputEmail) {
      boolean checkEmail = UService.isUserId(inputEmail);
      return checkEmail;
   }
   

   // 아이디 찾기 컨트롤
   @RequestMapping(value = "/popup_search_id", method = RequestMethod.POST)
   public String popup_search_id(Model model, HttpServletRequest request, RedirectAttributes redir, User user) {

		// 0. 선언 ( 메일 유틸 )
		SendMailUtil mUtil = new SendMailUtil();

		// 1. 유저 받기
		/*
		 * String companyName = user.getCompanyName(); String representName =
		 * user.getRepresentName(); String email = user.getEmail();
		 */
		logger.trace("아이디 찾을 회원 정보 : {}", user);

		// 2. 서비스로 찾기 ( 이메일 아이디 )
		try {
			user = UService.searchUserId(user);
			mUtil.email_IdCertification(user.getEmail(), user.getUserId());
			redir.addFlashAttribute("join_message", "아이디 찾기 성공 - 이메일로 아이디를 발송했습니다.");
		} catch (NotFoundDataException e) {
			redir.addFlashAttribute("join_message", "아이디 찾기 실패");
			return "redirect:/login";
		}
		// 3. 결과 출력 메시지 후, login
		return "redirect:/login";
   }

   // 비밀번호 찾기 컨트롤
   @RequestMapping(value = "/popupSearchPass", method = RequestMethod.POST)
   public String popup_search_pass(Model model, RedirectAttributes redir, User user, HttpSession session) {

		// 1. 폼에 입력 값 받기
		logger.trace("아이디 찾을 회원 정보 : {}", user);
		// 2-1 폼에 입력된 유저가 있는지부터 검색
		try {
			user = UService.searchUserPassword(user);
			logger.trace("폼에 정보로 검색된 유저 : {}", user);
		} catch (NotFoundDataException e) {
			logger.trace("패스워드 찾기 : DB 검색 실패");
			redir.addFlashAttribute("join_message", "패스워드 찾기 실패 - 해당 아이디가 업습니다.");
			return "redirect:/login";
		}

		// 2-2 이메일로 본인 인증이 되있는지 확인
		Object obj = (Object) session.getAttribute("matchingResult");
		String matchingResult = (String) obj;
		logger.trace("메칭 결과 : {}", matchingResult);
		if (matchingResult.equals("success")) {
			logger.trace("이메일 인증 확인");
		} else {
			redir.addFlashAttribute("join_message", "본인 인증 실패 - 인증되지 않은 회원입니다 .");
			logger.trace("이메일 인증 실패");
			return "redirect:/login";
		}

		// 3. DB에서 검색 및 이메일 인증된 회원 ==> 비밀번호 수정 폼으로 이동
		redir.addFlashAttribute("user", user);

		return "redirect:/login";
   }

   // 비밀번호 찾기 시, 이메일 인증 컨트롤
   @RequestMapping(value = "/popupSearchPassIssue", method = RequestMethod.POST)
   public @ResponseBody String popupSearchPassIssue(HttpSession session, @RequestParam String email) {

		// Ajax에서 판단할 String 값 ( success, fail )
		String submit = "";
		// 메일 유틸, 보낼 email 주소
		SendMailUtil mUtil = new SendMailUtil();
		// 1. 인증번호 발급
		Random randomGenerator = new Random();
		int randomNum = randomGenerator.nextInt(10000) + 1000;
		if (randomNum > 10000) {
			randomNum -= 1000;
		}
		// 2. 메일로 인증번호 전달
		if (email != null && email != "") {
			session.setAttribute("randomNum", randomNum);
			mUtil.email_PasswordCertification(email, randomNum);
			submit = "success";
			logger.trace("이메일 발송 성공");
		} else {
			logger.trace("이메일 발송 실패");
			submit = "fail";
		}

		return submit;
   }
   
// 비밀번호 찾기 : 인증번호 입력 및 인증 클릭 시
   @RequestMapping(value = "/popupSearchPassConfirm", method = RequestMethod.POST)
   public @ResponseBody String popupSearchPassConfirm(HttpSession session, @RequestParam String confirmNum) {
	   
		// Ajax에서 판단할 String 값 ( success, fail )
		String submit = "";
		Object obj = (Object) session.getAttribute("randomNum");
		String randomNum = obj.toString();
		logger.trace("세션 저장 값 : {}", randomNum);
		logger.trace("넘어온 값 : {}", confirmNum);

		// 1. 인증번호 매칭
		if (randomNum.equals(confirmNum)) {
			logger.trace("랜덤넘과 매칭 성공");
			submit = "success";
		} else {
			logger.trace("랜덤넘과 매칭 실패");
			submit = "fail";
		}

		session.setAttribute("matchingResult", submit);

		return submit;
   }

   // 주소 찾기 컨트롤
   @RequestMapping(value = "/jusoPopup")
   public String address_input(Model model) {
      logger.trace("jusoPopup check");

      return "join/jusoPopup";
   }

}