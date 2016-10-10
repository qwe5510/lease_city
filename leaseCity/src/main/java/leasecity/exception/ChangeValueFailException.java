package leasecity.exception;

public class ChangeValueFailException extends Exception{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -248895141134112996L;

	public ChangeValueFailException(String msg){
		super("ERROR-REMOVE : '" + msg + "'값 조작 실패.");
	}	
}
