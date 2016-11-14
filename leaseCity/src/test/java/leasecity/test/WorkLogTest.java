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
import leasecity.dto.adminwork.WorkLog;
import leasecity.exception.NotFoundDataException;
import leasecity.repo.adminwork.WorkLogRepo;
import leasecity.service.MyPageService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={ApplicationConfig.class})
@Transactional
public class WorkLogTest {

	@Autowired
	MyPageService myPageService;
	
	@Autowired
	WorkLogRepo workLogRepo;
	
	static Logger logger = LoggerFactory.getLogger(WorkLogTest.class);

	@Test
	public void test() throws NotFoundDataException {
		logger.trace("Service :{}", myPageService);
		
	}

}
