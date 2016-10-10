package leasecity.service;

import java.util.List;

import leasecity.dto.adminwork.StandByUser;
import leasecity.exception.DuplicateValueException;
import leasecity.exception.NotFoundDataException;

public interface StandByUserService {
	
	//대기유저 추가
	public void addStandByUser(StandByUser standByUser) 
				throws DuplicateValueException;
	
	//대기유저 전체 리스트 조회
	public List<StandByUser> getAllStandByUser()
				throws NotFoundDataException;
	
	//대기유저 업체명, 대표자명, 이메일정보를 받아 모든정보 리턴
	public StandByUser getStandByUser(
			String companyName,
			String representName,
			String email) throws NotFoundDataException;
	
	//대기유저 수락 - 발급코드 생성
	public void providePermissionCode(StandByUser standByUser)
			throws NotFoundDataException;
	
	//수락한 유저 발급코드 확인
	public StandByUser getAgreeStandByUser(String permissionCode)
			throws NotFoundDataException;
	
	//대기유저 거절
	public void rejectStandByUser(StandByUser standByUser) 
			throws NotFoundDataException;
	
	//대기유저 정리 - 요청한지 30일넘은 유저, 발급코드 받은지 3일넘은 유저
	public void cleanStandByUser()
						throws NotFoundDataException;	

}
