package leasecity.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import leasecity.dto.user.ConstructionCompany;
import leasecity.dto.user.HeavyEquipment;
import leasecity.dto.user.HeavyEquipmentCompany;
import leasecity.dto.user.License;
import leasecity.dto.user.User;
import leasecity.exception.JoinFailException;
import leasecity.exception.LoginFailException;
import leasecity.exception.ServiceFailException;
import leasecity.repo.user.ConstructionCompanyRepo;
import leasecity.repo.user.HeavyEquipmentCompanyRepo;
import leasecity.repo.user.HeavyEquipmentRepo;
import leasecity.repo.user.LicenseRepo;
import leasecity.repo.user.UserRepo;
import leasecity.util.HashingUtil;

@Service
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
			// 중장비 있을 시 DB에 추가
			for (HeavyEquipment heavyEquipment : list) {
				heavyEquipmentRepo.insertHeavyEquipment(heavyEquipment);
			}

		} else {// 어느 속성도 아니면 가입실패예외로 이동.
			logger.error("ERROR!! : 회원가입 실패");
			throw new JoinFailException();
		}

	}

	// 이미 존재하는 아이디인지 중복여부 확인. -> 중복 시 true, 아니면 false
	@Override
	public boolean isUserId(String userId) {
		User user = userRepo.getUser(userId);
		if (user != null) {
			return true;
		} else {
			return false;
		}
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
			// userId회원이 가지는 자격증 리스트 넣기
			CC.setLicenseList(licenseRepo.getUserLicense(userId));

			return CC;
		} else if (HEC != null) {
			HEC = null; // 데이터 초기화
			HEC = heavyEquipmentCompanyRepo.getHECUser(userId);
			// 중기업체에 중장비 리스트 넣기
			HEC.setHeavyEquipmentList(heavyEquipmentRepo.getUserHeavyEquipments(userId));

			return HEC;
		} else {
			// User테이블에는 있으나 건설업체,중기업체 속성이 아닌 dto
			logger.error("ERROR!! - 로그인 실패 (유효하지 않는 회원)");
			throw new LoginFailException();
		}
	}

	@Override
	public void changeInfo(String keyword, User user) throws ServiceFailException {
		int result = -1;

		if (keyword.equals("password")) {
			// 비밀번호 수정

			// 비밀번호 해싱
			String hashPassword = HashingUtil.hashingString(user.getPassword());
			user.setPassword(hashPassword);

			result = userRepo.updatePasswordUser(user);
			logger.trace("유저 비밀번호 수정 완료 : {}", result);
		} else if (keyword.equals("info")) {
			// 정보 수정
			result = userRepo.updateUser(user);
			logger.trace("유저 정보 수정 완료 : {}", result);
		} else {
			logger.error("ERROR!! - 요청 서비스가 올바르지 않음");
			throw new ServiceFailException();
		}
	}

}
