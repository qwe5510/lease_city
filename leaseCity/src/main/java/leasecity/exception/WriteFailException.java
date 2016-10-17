package leasecity.exception;

public class WriteFailException extends Exception {
	/**
	 * 
	 */
	private static final long serialVersionUID = 5256730116542478438L;

	public WriteFailException(String msg){
		super("'" + msg + "' 작성에 실패하였습니다.");
	}

}
