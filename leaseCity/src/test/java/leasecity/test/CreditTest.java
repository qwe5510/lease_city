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
import leasecity.repo.user.CreditRepo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={ApplicationConfig.class})
@Transactional
public class CreditTest {
	
	@Autowired
	CreditRepo repo;
	
	//기록
	static Logger logger = LoggerFactory.getLogger(CreditTest.class);
	
	@Test
	public void test(){
		repo.getSelectAcceptCredits("yy");
	}

}
