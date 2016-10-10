package leasecity.exception;

public class DuplicateValueException extends Exception {
	
	public DuplicateValueException(){
		super("요청 값이 중복되었습니다. 다시 시도해주세요.");
	}
}
