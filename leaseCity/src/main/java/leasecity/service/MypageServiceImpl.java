package leasecity.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import leasecity.dto.user.ConstructionCompany;
import leasecity.dto.user.HeavyEquipment;
import leasecity.dto.user.HeavyEquipmentCompany;
import leasecity.dto.user.License;
import leasecity.dto.user.User;
import leasecity.exception.JoinFailException;
import leasecity.exception.LoginFailException;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.ServiceFailException;
import leasecity.repo.user.ConstructionCompanyRepo;
import leasecity.repo.user.HeavyEquipmentCompanyRepo;
import leasecity.repo.user.HeavyEquipmentRepo;
import leasecity.repo.user.LicenseRepo;
import leasecity.repo.user.MypageRepo;
import leasecity.repo.user.UserRepo;
import leasecity.util.HashingUtil;

@Service
@Transactional
public class MypageServiceImpl implements MypageService {

	static Logger logger = LoggerFactory.getLogger(MypageServiceImpl.class);

	@Autowired
	UserRepo userRepo;

	@Autowired
	MypageRepo mypageRepo;

	// 로그인 유저 갖고오기
	@Override
	public User searchUser(String userId) throws NotFoundDataException {
		User user = mypageRepo.getUser(userId);
		if( user != null) {return user;}
		else{ throw new NotFoundDataException("아이디 못찾음"); }
	}

}
