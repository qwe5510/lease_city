package leasecity.exception;

public class ChangeValueFailException extends Exception{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -248895141134112996L;

	public ChangeValueFailException(String msg){
		super("'" + msg + "'에 대한 수정/조작을 할 수 없습니다.");
	}	
}
