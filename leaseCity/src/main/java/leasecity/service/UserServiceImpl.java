package leasecity.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import leasecity.dto.user.ConstructionCompany;
import leasecity.dto.user.Credit;
import leasecity.dto.user.HeavyEquipment;
import leasecity.dto.user.HeavyEquipmentCompany;
import leasecity.dto.user.License;
import leasecity.dto.user.User;
import leasecity.exception.JoinFailException;
import leasecity.exception.LoginFailException;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.ServiceFailException;
import leasecity.repo.user.ConstructionCompanyRepo;
import leasecity.repo.user.CreditRepo;
import leasecity.repo.user.HeavyEquipmentCompanyRepo;
import leasecity.repo.user.HeavyEquipmentRepo;
import leasecity.repo.user.LicenseRepo;
import leasecity.repo.user.UserRepo;
import leasecity.util.HashingUtil;

@Service
@Transactional
public class UserServiceImpl implements UserService {

	static Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);

	@Autowired
	UserRepo userRepo;

	@Autowired
	ConstructionCompanyRepo constructionCompanyRepo;

	@Autowired
	HeavyEquipmentCompanyRepo heavyEquipmentCompanyRepo;

	@Autowired
	HeavyEquipmentRepo heavyEquipmentRepo;

	@Autowired
	LicenseRepo licenseRepo;
	
	@Autowired
	CreditRepo creditRepo;

	// 유저 회원가입
	public void join(User user) throws JoinFailException {
		int result = -1; // 가입결과 리턴

		if (user != null) {
			// 유저의 비밀번호 암호화
			user.setPassword(HashingUtil.hashingString(user.getPassword()));
			result = userRepo.insertUser(user);
			logger.trace("회원가입 완료 : {}", result);
		}

		// 건설업체일경우.
		if (user != null && user instanceof ConstructionCompany) {
			ConstructionCompany CC = (ConstructionCompany) user;
			result = constructionCompanyRepo.insertConstructionCompany(CC);
			logger.trace("건설업체 회원 테이블 추가 : {}", result);
			List<License> list = CC.getLicenseList();
			// 자격증 있을 시 DB에 추가.
			for (License license : list) {
				licenseRepo.insertLicense(license);
			}

			// 중기업체일경우
		} else if (user != null && user instanceof HeavyEquipmentCompany) {
			HeavyEquipmentCompany HEC = (HeavyEquipmentCompany) user;
			result = heavyEquipmentCompanyRepo.insertHeavyEquipmentCompany(HEC);
			logger.trace("중기업체 회원 테이블 추가 : {}", result);
			List<HeavyEquipment> list = HEC.getHeavyEquipmentList();
			//중장비 있을 시 DB에 추가
			for(HeavyEquipment heavyEquipment : list){
				heavyEquipmentRepo.insertHeavyEquipment(heavyEquipment);
			}
		} else {// 어느 속성도 아니면 가입실패예외로 이동.
			logger.error("ERROR!! : 회원가입 실패");
			throw new JoinFailException();
		}

	}
	
	//관리자 로그인
	@Override
	public User adminLogin(String userId, String password) throws LoginFailException {
		String hashPass = HashingUtil.hashingString(password);
		User admin = userRepo.getUserIdAndPassword(userId, hashPass);
		ConstructionCompany CC = constructionCompanyRepo.getConstructionCompany(userId);
		HeavyEquipmentCompany HEC = heavyEquipmentCompanyRepo.getHeavyEquipmentCompany(userId);
		
		
		if(admin!=null && CC == null && HEC == null){
			logger.trace("관리자 로그인 성공");
		}else{
			logger.error("관리자 로그인에 실패하였습니다. 유저 로그인을 시도합니다.");
			throw new LoginFailException();
		}
		return admin;
	}


	@Override
	public User login(String userId, String password) throws LoginFailException {

		// 비밀번호 해싱 후 확인
		String hashPass = HashingUtil.hashingString(password);
		User user = userRepo.getUserIdAndPassword(userId, hashPass);

		ConstructionCompany CC = constructionCompanyRepo.getConstructionCompany(userId);
		HeavyEquipmentCompany HEC = heavyEquipmentCompanyRepo.getHeavyEquipmentCompany(userId);
		
		if (user == null) {
			logger.error("ERROR!! - 로그인 실패 (없는 id 혹은 패스워드)");
			throw new LoginFailException();
		} else if (CC != null) {
			CC = null; // 데이터 초기화
			CC = constructionCompanyRepo.getCCUser(userId);
			//userId회원이 가지는 자격증 리스트 넣기
			CC.setLicenseList(licenseRepo.getUserLicense(userId));

			return CC;
		} else if (HEC != null) {
			HEC = null; // 데이터 초기화
			HEC = heavyEquipmentCompanyRepo.getHECUser(userId);
			//중기업체에 중장비 리스트 넣기
			HEC.setHeavyEquipmentList(
					heavyEquipmentRepo.getUserHeavyEquipments(userId));
			return HEC;
		}else{
			//User테이블에는 있으나 건설업체,중기업체 속성이 아닌 dto
			logger.error("ERROR!! - 로그인 실패 (유효하지 않는 회원)");
			throw new LoginFailException();
		}
	}

	//이미 존재하는 아이디인지 중복여부 확인. -> 중복 시 true, 아니면 false
	@Override
	public boolean isUserId(String userId) {
		User user = userRepo.getUserCheckId(userId);
		if(user != null){return true;}
		else{return false;}
	}
	@Override
	public boolean isUserCompanyName(String companyName) {
		User user = userRepo.getUserCheckCompanyName(companyName);
		if(user != null){return true;}
		else{return false;}
	}
	@Override
	public boolean isUserEmail(String email) {
		User user = userRepo.getUserCheckEmail(email);
		if(user != null){return true;}
		else{return false;}
	}
	
	//아이디 찾기 - 뒷자리가 *처리된 id와 이메일, 업체명, 대표자명 정보가 담긴 유저 리턴
	@Override
	public User searchUserId(User user) throws NotFoundDataException {
		User result = userRepo.searchUserId(user);
		if(result == null){
			logger.error("ERROR!! - 아이디 찾기를 하고자하는 대상 유저가 없음");
			throw new NotFoundDataException("아이디 찾기 대상 유저");
		}else{
			logger.trace("유저 아이디 찾기 완료 : {}", result.getUserId());
			return result;
		}
	}
	
	//비밀번호 찾기 : 아이디, 업체명, 대표자명, 이메일정보로 검색하여 유저가있는지 확인.
	@Override
	public User searchUserPassword(User user) throws NotFoundDataException {
		User result = userRepo.searchUserPassword(user);
		if(result == null){
			logger.error("ERROR!! - 비밀번호 찾기를 하고자하는 대상 유저가 없음");
			throw new NotFoundDataException("비밀번호 찾기 대상 유저");
		}else{
			logger.trace("유저 아이디 찾기 완료 : {}", result.getUserId());
			return result;
		}
	}
	
	
	@Override
	public void changeInfo(Boolean isPassword, User user) 
								throws ServiceFailException {
		int result = -1;
		// 비밀번호 수정
		if (isPassword) {
			// 비밀번호 해싱
			String hashPassword = HashingUtil.hashingString(user.getPassword());
			user.setPassword(hashPassword);

			result =userRepo.updatePasswordUser(user); 
			if(result != 1){
				logger.error("ERROR!! - 요청 서비스가 올바르지 않음");
				throw new ServiceFailException();
			}else{
				logger.trace("유저 비밀번호 수정 완료 : {}", result);
			}
		} 
		// 정보 수정
		result = userRepo.updateUser(user); 
		if(result != 1){
			logger.error("ERROR!! - 요청 서비스가 올바르지 않음");
			throw new ServiceFailException();
		}else{
			logger.trace("유저 정보 수정 완료 : {}", result);
		}
		
		
		if(user instanceof HeavyEquipmentCompany){
			HeavyEquipmentCompany HEC = (HeavyEquipmentCompany)user;
			result = heavyEquipmentCompanyRepo.updateHeavyEquipmentCompany(HEC);
			if(result != 1){
				//건설업체 정보가 제대로 반영되지 않음.
				throw new ServiceFailException();
			}
			
			heavyEquipmentRepo.deleteUserHeavyEquipment(HEC.getUserId());
			List<HeavyEquipment> HEs = HEC.getHeavyEquipmentList();
			
			for(HeavyEquipment HE : HEs){
				heavyEquipmentRepo.insertHeavyEquipment(HE);
			}
			
		}else if(user instanceof ConstructionCompany){
			ConstructionCompany CC = (ConstructionCompany)user;
			result = constructionCompanyRepo.updateConstructionCompany(CC);
			if(result != 1){
				//건설업체 정보가 제대로 반영되지 않음.
				throw new ServiceFailException();
			}
			
			licenseRepo.deleteUserLicense(CC.getUserId());
			List<License> licenses = CC.getLicenseList();
			
			for(License license : licenses){
				licenseRepo.insertLicense(license);
			}
		}
		
		logger.trace("유저 정보 : {}", user);
	}

	
	@Override
	public User loadUserInfo(String userId) throws NotFoundDataException {
		
		User result = constructionCompanyRepo.getConstructionCompany(userId);
	
		if(result==null){
			HeavyEquipmentCompany hResult = heavyEquipmentCompanyRepo.getHECUser(userId);
			
			List<HeavyEquipment> HE = heavyEquipmentRepo.getUserHeavyEquipments(userId);
			hResult.setHeavyEquipmentList(HE);
			
			return hResult;
		}else{
			ConstructionCompany cResult = constructionCompanyRepo.getCCUser(userId);
			List<License> license = licenseRepo.getUserLicense(userId);
			cResult.setLicenseList(license);

			return cResult;
		}
	}
	
	@Override
	public List<HeavyEquipment> loadUserHeavyEquipment(String userId) throws NotFoundDataException {
		
		if(userId == null){
			throw new NotFoundDataException(userId + "회원의 중장비 리스트");
		}
		
		List<HeavyEquipment> results = heavyEquipmentRepo.getUserHeavyEquipments(userId);
		
		if(results.size() <= 0){
			throw new NotFoundDataException(userId + "회원의 중장비 리스트");
		}
		
		return results;
	}
	
	
	@Override
	public List<License> loadUserLicense(String userId) throws NotFoundDataException {
		if(userId == null){
			throw new NotFoundDataException(userId + "회원의 자격증 리스트");
		}
		
		List<License> results = licenseRepo.getUserLicense(userId);
		
		if(results.size() <= 0){
			throw new NotFoundDataException(userId + "회원의 자격증 리스트");
		}
		
		return results;
	}
	
	@Override
	public void calcCreditGrade(User user) {
		List<Credit> credits = 
				creditRepo.getSelectAcceptCredits(user.getUserId());
		
		double creditSum = 0;
		double creditAvg = 0;
		int count = credits.size();
		
		for(Credit credit : credits){
			creditSum += credit.getEvaluation();
		}
		
		if(count==0){
			user.setCreditGrade(0.0);
		}else{
			creditAvg = creditSum / count;
			double creditGrade = (creditAvg + count) / (5.0 + count);
			user.setCreditGrade(creditGrade);
		}
	}
	
	@Override
	public Integer getCountWorkLog(User user) {
		int result = 0;
		if(user != null){
			result = creditRepo.getCountSendCredits(user.getUserId());
		}
		return result;
	}
	
	@Override
	public Boolean checkHEC(String idNumber) {
		if(idNumber==null){
			return false;
		}		
		HeavyEquipment HEC = heavyEquipmentRepo.getHeavyEquipment(idNumber);
		if(HEC == null){
			return true;
		}else{
			return false;
		}
	}

	@Override
	public Integer changeWithdrawUser(User user) {
		int result = 0;
		if(user != null){
			result = userRepo.withdrawUser(user);
		}
		return result;
	}

	@Override
	public void cleanWithdrawUser() {
		int result = userRepo.deletewithdrawUser();
		logger.trace("삭제 : 탈퇴 한지 14일 경과된 유저 : {}", result);
	}
}
