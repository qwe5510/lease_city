package leasecity.repo.adminwork;

import leasecity.dto.adminwork.LeasecityAdmin;

public interface LeasecityAdminRepo {

	//관리자 아이디
	public LeasecityAdmin getLeasecityAdmin
				(String adminId, String adminPass);
	
	//관리자 수정
	public int updateLeasecityAdmin
				(LeasecityAdmin leasecityAdmin);
}
