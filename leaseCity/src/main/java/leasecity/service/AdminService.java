package leasecity.service;

import leasecity.dto.adminwork.LeasecityAdmin;

public interface AdminService {
	
	//관리자 로그인
	public LeasecityAdmin adminLogin(String id, String password);
	
	//관리자 정보 수정
	public int updateInfoAdmin(LeasecityAdmin LA);

}
