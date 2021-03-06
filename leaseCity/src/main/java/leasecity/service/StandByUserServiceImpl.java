package leasecity.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import leasecity.dto.adminwork.StandByUser;
import leasecity.exception.DuplicateValueException;
import leasecity.exception.NotFoundDataException;
import leasecity.repo.adminwork.StandByUserRepo;
import leasecity.util.HashingUtil;

@Service
@Transactional
public class StandByUserServiceImpl implements StandByUserService{
	

	@Autowired
	StandByUserRepo SBUrepo;

	//logger
	static Logger logger = LoggerFactory.getLogger(StandByUserServiceImpl.class);

	@Override
	public void addStandByUser(StandByUser standByUser) throws DuplicateValueException {
		try {
			int result = SBUrepo.insertStandByUser(standByUser);
			logger.trace("대기 유저 추가 : {}", result);
		} catch (DuplicateKeyException e) {
			logger.error("ERROR!! : 요청 값이 중복됩니다");
			throw new DuplicateValueException();
		}
	}

	@Override
	public List<StandByUser> getAllStandByUser() 
				throws NotFoundDataException{
		List<StandByUser> list = SBUrepo.getAllStandByUser();
		
		if(list.size() == 0){
			logger.error("ERROR!! : 요청 대기중인 유저가 없습니다.");
			throw new NotFoundDataException("요청 대기중인 유저");
		}
		
		return list;
	}
	

	@Override
	public StandByUser getStandByUser(String companyName, String representName, String email)
			throws NotFoundDataException {

		StandByUser standByUser = SBUrepo.getStandByUser
				(companyName, representName, email);
		
		if(standByUser == null){
			logger.error("ERROR!! : 대기유저 " + companyName + ":" + representName + "님이 존재하지 않습니다.");
			throw new NotFoundDataException
			("대기 유저 - " + companyName + " : " + representName);
		}else{
			logger.trace("대기 유저 검색 : {}", standByUser);
		}

		return standByUser;
	}
	
	//대기유저 수락 - 발급코드 생성
	@Override
	public StandByUser providePermissionCode(StandByUser standByUser) 
				throws NotFoundDataException {
		
		String companyName = standByUser.getCompanyName();
		String representName = standByUser.getRepresentName();
		String email = standByUser.getEmail();
		
		StandByUser SBU = SBUrepo.getStandByUser(companyName, representName, email);
		
		if(SBU == null){
			logger.error("ERROR!! : 수락한 대기유저가 검색되지 않습니다");
			throw new NotFoundDataException("수락한 대기유저");
		}else{
			String code = HashingUtil.permissionCodeProvide();
			SBU.setPermissionNo(code);
			int result = SBUrepo.updateStandByUser(SBU);
			logger.trace("대기 유저 발급코드 지급 : {}", result);
			return SBU;
		}
	}
	
	//수락한 유저 발급코드 확인
	@Override
	public StandByUser getAgreeStandByUser(String permissionCode) 
				throws NotFoundDataException {
		StandByUser SBU = null;
		
		//코드가 null이 아닐때만
		if(permissionCode != null)
			SBU = SBUrepo.getAgreeStandByUser(permissionCode);
		
		if(SBU == null){
			logger.error("ERROR!! : 수락한 대기유저가 검색되지 않습니다");
			throw new NotFoundDataException("수락한 대기유저");
		}else{
			logger.trace("대기 유저 확인 : {}", SBU);
			return SBU;
		}
	}
	
	
	//대기 유저 거절
	@Override
	public void rejectStandByUser(StandByUser standByUser) 
			throws NotFoundDataException{
		int result = SBUrepo.deleteStandByUser(standByUser);
		if(result<=0){
			logger.error("ERROR!! : 거절한 대기유저가 검색되지 않습니다.");
			throw new NotFoundDataException("거절한 대기유저");
		}else{
			logger.trace("대기 유저 요청 거절 : {}", result);
		}	
	}
	
	@Override
	public void cleanStandByUser(){
		// 대기유저 발급코드 발급된지 3일이상, 요청한지 30일이상 유저 일괄제거
		int registryResult = SBUrepo.deleteStandByUserRegistry();
		int requestResult = SBUrepo.deleteStandByUserRequest();
		logger.trace("삭제 : 요청 30일 경과 대기유저  : {}", requestResult);
		logger.trace("삭제 : 인증코드 발급 3일 경과 대기유저  : {}", registryResult);
		
		//시간 확인용 출력문
		System.out.println("Time : " + System.currentTimeMillis());
	}

}
