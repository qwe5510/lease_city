package leasecity.service;

import leasecity.dto.adminwork.LeasecityAdmin;
import leasecity.exception.LoginFailException;
import leasecity.exception.NotFoundDataException;

public interface LeasecityAdminService {
	
	//관리자 로그인
	public LeasecityAdmin adminLogin(String id, String password)
			throws LoginFailException;
	
	//관리자 정보 수정
	public void updateInfoAdmin(LeasecityAdmin LA)
			throws NotFoundDataException;

}
