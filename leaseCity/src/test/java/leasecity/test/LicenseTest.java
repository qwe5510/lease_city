package leasecity.test;

import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import leasecity.config.ApplicationConfig;
import leasecity.dto.user.ConstructionCompany;
import leasecity.dto.user.License;
import leasecity.dto.user.User;
import leasecity.repo.user.ConstructionCompanyRepo;
import leasecity.repo.user.LicenseRepo;
import leasecity.repo.user.UserRepo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={ApplicationConfig.class})
@Transactional
public class LicenseTest {

	static Logger logger = LoggerFactory.getLogger(LicenseTest.class);

	@Autowired
	UserRepo repo;
	
	@Autowired
	ConstructionCompanyRepo CCrepo;
	
	@Autowired
	LicenseRepo Lrepo;
	
	@Test
	public void test() {
		logger.trace("자격증 Repository : {}", repo);
		
		/*User user = repo.getUser("raven92");
		logger.trace("유저 검색 : {}", user);
		
		ConstructionCompany CC = 
				new ConstructionCompany(user, 2500.0, 240, "소", "건축/토목");
		System.out.println(CC);
		
		int result = CCrepo.insertConstructionCompany(CC);
		logger.trace("건설업체 추가 : {}", result);*/
		
		License license = new License(
				"AFASDFA10239", 
				"raven92", 
				"licenseName",
				new Date(),
				"한국인력공단");
		
		Lrepo.insertLicense(license);
		
		License test = Lrepo.getLicense("AFASDFA10239");
		
		logger.trace("license : {}", test);
		
	}

}
