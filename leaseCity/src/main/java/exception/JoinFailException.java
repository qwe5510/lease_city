package exception;

public class JoinFailException extends Exception{
	
	public JoinFailException(){
		super("회원가입에 실패하였습니다.");
	}

}
