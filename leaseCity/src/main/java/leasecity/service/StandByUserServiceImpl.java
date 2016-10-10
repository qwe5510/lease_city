package leasecity.service;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.core.DuplicatesPredicate;

import leasecity.dto.adminwork.StandByUser;
import leasecity.repo.adminwork.StandByUserRepo;

public class StandByUserServiceImpl implements StandByUserService{
	
	@Autowired
	StandByUserRepo SBUrepo;
	
	@Override
	public int addStandByUser(StandByUser standByUser) {
		int result = -1;
		try{
			result = SBUrepo.insertStandByUser(standByUser);
		}catch(PersistenceException e){
			
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
