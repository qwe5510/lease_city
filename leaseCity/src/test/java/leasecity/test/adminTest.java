package leasecity.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import leasecity.config.ApplicationConfig;
import leasecity.dto.adminwork.LeasecityAdmin;
import leasecity.repo.adminwork.LeasecityAdminRepo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={ApplicationConfig.class})
@Transactional
public class adminTest {
	
	@Autowired
	LeasecityAdminRepo repo;
	
	//기록
	static Logger logger = LoggerFactory.getLogger(adminTest.class);
	
	/*@Test
	public void test(){
		
		LeasecityAdmin admin = repo.getLeasecityAdmin("admin", "1234");
		logger.trace("관리자 : {}", admin);
		
		admin.setAdminId("administrator");
		admin.setAdminPass("12345");	
		int result=repo.updateLeasecityAdmin(admin);
		logger.trace("관리자 정보변경 : {}", result);
		
		admin = repo.getLeasecityAdmin(admin.getAdminId(), "12345");
		logger.trace("관리자 : {}", admin);
		
	}
*/
}
