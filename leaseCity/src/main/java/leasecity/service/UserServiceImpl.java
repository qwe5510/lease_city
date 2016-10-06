package leasecity.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import leasecity.dto.user.User;
import leasecity.exception.JoinFailException;

public class UserServiceImpl implements UserService {

	static Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);
	
	//유저 회원가입
	public void join(User user, String kind){		
		
		try{
			if(kind.equals("Construction")){
				
			}else if(kind.equals("HeavyEquipments")){
				
			}else{
				throw new JoinFailException();
			}
		}catch (JoinFailException e){
			logger.trace("ERROR!! : {}", e.getMessage());
		}
	}
	
}
