package leasecity.exception;

public class DuplicateValueException extends Exception {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 9026540804610546000L;

	public DuplicateValueException(){
		super("요청 값이 중복되었습니다. 다시 시도해주세요.");
	}
}
