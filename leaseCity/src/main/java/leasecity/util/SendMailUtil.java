package leasecity.util;

import javax.mail.PasswordAuthentication;
import javax.mail.internet.MimeUtility;
import java.util.Date;
import java.util.Random;
import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import leasecity.dto.user.User;
import leasecity.util.*;
import javax.mail.Transport;
import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.Address;
import javax.mail.internet.MimeMessage;
import javax.mail.Session;
import javax.mail.Authenticator;
import java.util.Properties;

public class SendMailUtil extends javax.mail.Authenticator {
	
	
	public void sendMail(User user) {
		
		
		Random randomGenerator = new Random();
		int num = randomGenerator.nextInt(10000) + 1000;
		if (num > 10000) {
			num -= 1000;
		}
		
		// 해쉬 클래스 선언
		HashingUtil hs = new HashingUtil();
		
		String host = "smtp.naver.com";
		String subject = "네이버를 이용한 메일발송";
		String from = "djsdir159@naver.com"; //보내는 메일
		String fromName = "Test";
		String to = "" + user.getEmail();
		StringBuffer sb = new StringBuffer();
		
		String numStr = hs.hashingString(""+num);
		String src = "\"<%=request.getContextPath() %>/view/join/join_agree.jsp>\"";
		
		sb.append("<a href=" + src + ">회원가입 페이지로 이동</a> <br/>")
		.append("테스트 해쉬코드 : /" + numStr + "<br/>")
		.append("본 메일은 LeaseCity 에 회원가입을 요청하시려는 고객님께 본인 확인을 위해 자동으로 발송됩니다.<br/><br/>")
		.append("■ 본 메일이 고객님의 정보가 아닐 경우<br/>")
		.append("본 메일은 LeaseCity 에 회원가입을 요청하시려는 분께 발송되는 확인 메일입니다.<br/>")
		.append("이메일 주소를 잘못 입력하여 다른 분께 메일이 발송되는 경우가 있습니다.<br/>")
		.append("그런 경우 본 메일을 삭제해 주시기 바랍니다.<br/>");

		try {
			//프로퍼티 값 인스턴스 생성과 기본세션(SMTP 서버 호스트 지정)
			Properties props = new Properties();
			//네이버 SMTP 사용시
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.transport.protocol", "smtp");
			props.put("mail.smtp.host", host);

			props.put("mail.smtp.port", "465"); // 보내는 메일 포트 설정
			props.put("mail.smtp.user", from);
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.debug", "true");
			props.put("mail.smtp.socketFactory.port", "465");
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.socketFactory.fallback", "false");

			Authenticator auth = new AuthenticatorUtil();
			Session mailSession = Session.getDefaultInstance(props, auth);

			Message msg = new MimeMessage(mailSession);
			msg.setFrom(new InternetAddress(from, MimeUtility.encodeText(fromName, "UTF-8", "B"))); //보내는 사람 설정
			InternetAddress[] address = { new InternetAddress(to) };

			msg.setRecipients(Message.RecipientType.TO, address); //받는 사람설정

			msg.setSubject(subject); //제목설정
			msg.setSentDate(new java.util.Date()); //보내는 날짜 설정
			msg.setContent(sb.toString(), "text/html; charset=EUC-KR"); //내용 설정(MIME 지정-HTML 형식)

			Transport.send(msg); //메일 보내기

			System.out.println("메일 발송을 완료하였습니다.");
		} catch (MessagingException ex) {
			System.out.println("mail send error : " + ex.getMessage());
			ex.printStackTrace();
		} catch (Exception e) {
			System.out.println("error : " + e.getMessage());
			e.printStackTrace();
		}
		
	}
	
	
}