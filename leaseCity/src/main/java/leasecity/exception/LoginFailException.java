package leasecity.exception;

public class LoginFailException extends Exception{
	
	/**
	 * 시리얼키 설정
	 */
	private static final long serialVersionUID = -7960256402721629889L;

	public LoginFailException() {
		super("아이디 혹은 비밀번호가 맞지 않습니다.");
	}

}
