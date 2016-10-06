package leasecity.exception;

public class JoinFailException extends Exception{
	
	/**
	 * SerialVersionID 설정
	 */
	private static final long serialVersionUID = -5838285554130277635L;

	public JoinFailException(){
		super("회원가입에 실패하였습니다.");
	}

}
