package leasecity.exception;

public class RemoveFailException extends Exception{
	/**
	 * 
	 */
	private static final long serialVersionUID = 8477401450986389117L;

	public RemoveFailException(String msg){
		super("'" + msg + "' 글 삭제에 실패하였습니다.");
	}

}
