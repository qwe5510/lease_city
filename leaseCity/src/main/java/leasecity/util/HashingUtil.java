package leasecity.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class HashingUtil {
	static Logger logger = LoggerFactory.getLogger(HashingUtil.class);

	//입력한 String값을 해싱시켜서 리턴
	public static String hashingString(String str){
		String md5Str = "";

		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(str.getBytes());
			byte byteData[] = md.digest();
			StringBuffer sb = new StringBuffer();

			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}
			md5Str = sb.toString();

		} catch (NoSuchAlgorithmException e) {
			logger.trace("비밀번호 해싱 실패, ", e);
			md5Str = null;
		} 
		return md5Str;
	}

}
