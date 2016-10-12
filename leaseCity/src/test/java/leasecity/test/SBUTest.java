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
import leasecity.service.StandByUserService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={ApplicationConfig.class})
@Transactional
public class SBUTest {
	
	@Autowired
	StandByUserService service;
	
	static Logger logger = LoggerFactory.getLogger(SBUTest.class);
	
	@Test
	public void test(){
		logger.trace("service : {}", service);
	}
	
	
	

}
