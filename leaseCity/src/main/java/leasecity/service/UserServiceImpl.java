package leasecity.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import leasecity.dto.user.ConstructionCompany;
import leasecity.dto.user.HeavyEquipment;
import leasecity.dto.user.HeavyEquipmentCompany;
import leasecity.dto.user.User;
import leasecity.exception.JoinFailException;
import leasecity.exception.LoginFailException;
import leasecity.repo.user.ConstructionCompanyRepo;
import leasecity.repo.user.HeavyEquipmentCompanyRepo;
import leasecity.repo.user.UserRepo;
import leasecity.util.HashingUtil;

public class UserServiceImpl implements UserService {

	static Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);
	
	@Autowired
	UserRepo userRepo;
	
	@Autowired
	ConstructionCompanyRepo CCRepo;
	
	@Autowired
	HeavyEquipmentCompanyRepo HECRepo;
	
	
	//유저 회원가입
	public void join(User user) throws JoinFailException{		
		int result=-1; // 가입결과 리턴
		
		if(user!=null){
			
			// 유저의 비밀번호 암호화
			user.setPassword(HashingUtil.hashingString(user.getPassword()));
			result = userRepo.insertUser(user);
			logger.trace("회원가입 완료 : {}", result);
		}

		// 건설업체일경우.
		if (user!=null && user instanceof ConstructionCompany) {
			ConstructionCompany CC = (ConstructionCompany) user;

			result = CCRepo.insertConstructionCompany(CC);
			logger.trace("건설업체 회원 배정 완료 : {}", result);

			// 중기업체일경우
		} else if (user!=null && user instanceof HeavyEquipmentCompany) {
			HeavyEquipmentCompany HEC = (HeavyEquipmentCompany) user;

			result = HECRepo.insertHeavyEquipmentCompany(HEC);
			logger.trace("중기업체 회원 배정 완료 : {}", result);

			// 어느 속성도 아니면 가입실패예외로 이동.
		} else {
			//logger.error("ERROR!! : {}");
			throw new JoinFailException();
		}

	}
	
	@Override
	public User login(String userId, String password) throws LoginFailException{
		
		//비밀번호 해싱 후 확인
		String hashPass = HashingUtil.hashingString(password);
		User user = userRepo.getUserIdAndPassword(userId, hashPass);
		
		ConstructionCompany CC = CCRepo.getConstructionCompany(userId);
		HeavyEquipmentCompany HEC = HECRepo.getHeavyEquipmentCompany(userId);
		
		if(user==null){
			logger.error("로그인 실패 - 없는 id 혹은 패스워드");
			throw new LoginFailException();
		}else if(CC != null){
			//CC = CCRepo.getCCUser(userId);
			return CC;
		}else if(HEC != null){
			HEC = HECRepo.getHECUser(userId);
			List<HeavyEquipment> HECList = HEC.getHeavyEquipmentList();
			
			return HEC;
		}else{
			//User테이블에는 있으나 건설업체,중기업체 속성이 아닌 dto
			logger.error("로그인 실패 - 건설,중기업체에 해당하지 않는 회원");
			throw new LoginFailException();
		}
	}
	
}
