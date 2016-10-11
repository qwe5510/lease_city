package leasecity.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import leasecity.dto.adminwork.LeasecityAdmin;
import leasecity.exception.LoginFailException;
import leasecity.exception.NotFoundDataException;
import leasecity.repo.adminwork.LeasecityAdminRepo;

@Service
public class LeasecityAdminServiceImpl implements LeasecityAdminService{

	@Autowired
	LeasecityAdminRepo adminRepo;
	
	static Logger logger = LoggerFactory.getLogger(LeasecityAdminServiceImpl.class);
	
	@Override
	public LeasecityAdmin adminLogin(String id, String password) 
				throws LoginFailException{
		LeasecityAdmin admin = 
				adminRepo.getLeasecityAdmin(id, password);
		
		if(admin == null){
			logger.error("ERROR!! - 로그인 실패 (없는 id 혹은 패스워드)");
			throw new LoginFailException();
		}else{
			logger.error("관리자 로그인 성공.");
			return admin;
		}
	}

	@Override
	public void updateInfoAdmin(LeasecityAdmin LA) 
			throws NotFoundDataException{
		int result = adminRepo.updateLeasecityAdmin(LA);
		
		if(result <= 0){
			logger.error("ERROR!! : 관리자 ID, PASSWORD 수정실패");
			throw new NotFoundDataException("수정하려는 관리자");
		}else{
			logger.trace("관리자 ID, PASSWORD 수정완료 : {}", result);
		}
		
	}

}
