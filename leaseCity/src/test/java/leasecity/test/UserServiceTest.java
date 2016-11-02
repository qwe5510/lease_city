package leasecity.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import leasecity.config.ApplicationConfig;
import leasecity.dto.user.HeavyEquipmentCompany;
import leasecity.dto.user.User;
import leasecity.exception.LoginFailException;
import leasecity.exception.ServiceFailException;
import leasecity.repo.user.UserRepo;
import leasecity.service.UserService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { ApplicationConfig.class })
@Transactional //자동 롤백 설정
public class UserServiceTest {


	@Autowired
	UserService service;
	
	@Autowired
	UserRepo repo;
	
	static Logger logger = LoggerFactory.getLogger(UserServiceTest.class);
	
	@Test
	public void test() throws LoginFailException, ServiceFailException {
		logger.trace("유저서비스 확인 : {}", service);
		
		//User user = service.login("ysh5586", "didtngh5");
		User user = service.login("raven92", "suhwanyun");
		
		/*if(user instanceof ConstructionCompany){
			ConstructionCompany CCUser = (ConstructionCompany)user;
			logger.trace("건설업체 유저 확인 : {}", CCUser);
			
			//List<License> list = CCUser.getLicenseList();
			
			for(License license : list){
				logger.trace("보유 자격증 : {}", license);
			}
			
		}else if(user instanceof HeavyEquipmentCompany){
			HeavyEquipmentCompany HECUser = (HeavyEquipmentCompany)user;
			
			logger.trace("중기업체 유저 확인 : {}", HECUser);
			
			//List<HeavyEquipment> list = HECUser.getHeavyEquipmentList();

			for(HeavyEquipment heavyEquipment : list){
				logger.trace("보유 중장비 : {}", heavyEquipment);
			}
		}	*/
		
		HeavyEquipmentCompany he = (HeavyEquipmentCompany) user;
		
		System.out.println(he.getHeavyEquipmentList());
		
	}

}
