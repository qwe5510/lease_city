package leasecity.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import leasecity.config.ApplicationConfig;
import leasecity.repo.user.ConstructionCompanyRepo;
import leasecity.repo.user.UserRepo;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={ApplicationConfig.class})
@Transactional
public class CCTest {

	static Logger logger = LoggerFactory.getLogger(CCTest.class);
	
	@Autowired
	SqlSessionTemplate session;
	
	@Autowired
	UserRepo repo;
	
	@Autowired
	ConstructionCompanyRepo CCrepo;

	@Test
	public void HECTest(){
		logger.trace("session : {}", session);
		
	}

}
