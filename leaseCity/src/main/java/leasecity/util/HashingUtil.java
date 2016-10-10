package leasecity.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

//문자열 해싱 유틸 (비밀번호 해싱화에 사용)
public class HashingUtil {
	static Logger logger = LoggerFactory.getLogger(HashingUtil.class);
	
	//입력한 String값을 해싱시켜서 리턴
	public static String hashingString(String str){
		String result = "";
		byte byteData[]; //암호화에 사용할 바이트 배열
		StringBuffer sb; //스트링 버퍼

		try {
			//MD5로 해싱
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(str.getBytes());
			byteData = md.digest();
			sb = new StringBuffer();

			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
			}
			
			//SHA-256로 해싱
			MessageDigest sh = MessageDigest.getInstance("SHA-256");
			sh.update(sb.toString().getBytes());
			byteData = sh.digest();
		
			sb.setLength(0); // StringBuffer 초기화
			
			for(int i=0; i< byteData.length; i++){
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
			}
			
			result = sb.toString();

		} catch (NoSuchAlgorithmException e) {
			logger.trace("비밀번호 해싱 실패, ", e);
			result = null;
		} 
		return result;
	}
	
	
	public static String permissionCodeProvide(){
		
		Random random = new Random();
		StringBuffer sb = new StringBuffer();
		
		for(int i=0; i<20; i++){
			sb.append(random.nextInt(10));
		}

		String code = hashingString(sb.toString());
		
		return code;
	}
	
}
