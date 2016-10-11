package leasecity.exception;

public class ServiceFailException extends Exception{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5181512882942771864L;

	public ServiceFailException(){
		super("요청 작업에 실패하였습니다.");
	}
}
