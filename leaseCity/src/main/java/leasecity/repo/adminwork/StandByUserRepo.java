package leasecity.repo.adminwork;

import java.util.List;

import leasecity.dto.adminwork.StandByUser;

public interface StandByUserRepo {
	// 모든 대기유저 검색
	public List<StandByUser> getAllStandByUser();

	// 대기유저 검색
	public StandByUser getStandByUser(
			String companyName, 
			String representName, 
			String email);
	
	// 발급코드가 존재하는 대기유저 검색
	public StandByUser getAgreeStandByUser(String permissionNo);
	
	// 대기유저 추가
	public int insertStandByUser(StandByUser standByUser);
	
	// 대기유저 수정 - 발급코드 부여
	public int updateStandByUser(StandByUser standByUser);
	
	// 대기유저 삭제 - 요청한지 30일 경과된 유저대상
	public int deleteStandByUserRequest();
	
	// 대기유저 삭제 - 발급코드 받은지 3일 경과된 유저대상
	public int deleteStandByUserRegistry();
}
