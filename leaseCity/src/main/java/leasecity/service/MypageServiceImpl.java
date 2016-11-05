package leasecity.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import leasecity.dto.user.User;
import leasecity.exception.NotFoundDataException;
import leasecity.repo.user.MypageRepo;
import leasecity.repo.user.UserRepo;

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
