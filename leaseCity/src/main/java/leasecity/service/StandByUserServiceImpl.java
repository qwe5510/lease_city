package leasecity.service;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import leasecity.dto.adminwork.StandByUser;
import leasecity.exception.DuplicateValueException;
import leasecity.repo.adminwork.StandByUserRepo;

public class StandByUserServiceImpl implements StandByUserService{
	
	@Autowired
	StandByUserRepo SBUrepo;
	
	static Logger logger = LoggerFactory.getLogger(StandByUserServiceImpl.class);
	
	@Override
	public int addStandByUser(StandByUser standByUser) 
							throws DuplicateValueException{
		int result = -1;
		try{
			result = SBUrepo.insertStandByUser(standByUser);
		}catch(PersistenceException e){
			logger.error("ERROR!! : 요청 값이 중복됩니다");
			throw new DuplicateValueException();
		}
						
		return result;
	}

	@Override
	public List<StandByUser> getAllStandByUser() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public StandByUser getStandByUser(String companyName, String representName, String email) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int StandByUserClean() {
		// TODO Auto-generated method stub
		return 0;
	}

}
