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
import leasecity.repo.user.ConstructionCompanyRepo;
import leasecity.repo.user.LicenseRepo;
import leasecity.repo.user.UserRepo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={ApplicationConfig.class})
@Transactional
public class LicenseTest {
	
	@Autowired
	LicenseRepo licenseRepo;
	
	@Autowired
	ConstructionCompanyRepo CCRepo;
	
	@Autowired
	UserRepo userRepo;
	
	//기록
	static Logger logger = LoggerFactory.getLogger(LicenseTest.class);
	
	@Test
	public void test(){
		
		
		
		licenseRepo.getUserLicense("ysh5586");

		
	}

}
