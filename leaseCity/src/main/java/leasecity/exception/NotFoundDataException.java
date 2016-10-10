package leasecity.exception;

public class NotFoundDataException extends Exception{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -4952059710779462452L;

	public NotFoundDataException(String component){
		super("요청하신 '" + component + "'에 대한 값을 찾아올 수 없습니다.");
	}

}
