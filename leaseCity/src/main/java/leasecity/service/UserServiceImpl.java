package leasecity.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import leasecity.dto.user.ConstructionCompany;
import leasecity.dto.user.HeavyEquipmentCompany;
import leasecity.dto.user.User;
import leasecity.exception.JoinFailException;

public class UserServiceImpl implements UserService {

	static Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);
	
	//유저 회원가입
	public void join(User user){		
		
		try{
			//건설업체일경우.
			if(user instanceof ConstructionCompany){
				ConstructionCompany CC =
						(ConstructionCompany)user;
			}else if(user instanceof HeavyEquipmentCompany){
				HeavyEquipmentCompany HEC =
						(HeavyEquipmentCompany)user;
			}else{
				throw new JoinFailException();
			}
		}catch (JoinFailException e){
			logger.trace("ERROR!! : {}", e.getMessage());
		}
	}
	
}
