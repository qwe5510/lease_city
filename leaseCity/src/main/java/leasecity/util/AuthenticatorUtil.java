package leasecity.util;

import javax.mail.PasswordAuthentication;

import org.springframework.beans.factory.annotation.Autowired;

import leasecity.service.UserService;

//이메일을 전송하는 관리자 계정 등록
public class AuthenticatorUtil extends javax.mail.Authenticator {
	
	@Autowired
	UserService userService;
	
	public PasswordAuthentication getPasswordAuthentication() {
		
		/*
		 * 
		 *   네이버에서 메일 환경설정에서 POP3/SMTP 사용함으로 설정해야 된다.

		 * 
		 * 
		 */
		
		System.out.println("PasswordAuthentication");
		// 네이버나 Gmail 사용자 계정 설정.
		// Gmail의 경우 @gmail.com을 제외한 아이디만 입력한다.
		// 컨트롤러(윤현준) 이메일로 일단 대체합니다.
		return new PasswordAuthentication("djsdir159", "1351243");
	}
}