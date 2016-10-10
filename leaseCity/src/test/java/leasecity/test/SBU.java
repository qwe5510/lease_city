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
import leasecity.dto.adminwork.StandByUser;
import leasecity.repo.adminwork.StandByUserRepo;
import leasecity.util.HashingUtil;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={ApplicationConfig.class})
@Transactional
public class SBU {

	static Logger logger = LoggerFactory.getLogger(SBU.class);
	
	@Autowired
	StandByUserRepo repo;
	
	@Test
	public void test() throws InterruptedException {
		StandByUser test = new StandByUser(
				"한국건설", "윤현준", "yhj@naver.com");
		
		int result = repo.insertStandByUser(test);
		logger.trace("대기유저 추가 : {}", result);
		
		StandByUser resultTest = repo.getStandByUser(
				test.getCompanyName(), 
				test.getRepresentName(), 
				test.getEmail());
		
		logger.trace("result : {}", resultTest);
		
		
		resultTest.setPermissionNo(HashingUtil.hashingString("1234"));
		result = repo.providePermissionCodeStandByUser(resultTest);
		logger.trace("result : {}", result);
		
		resultTest = repo.getStandByUser(
				test.getCompanyName(), 
				test.getRepresentName(), 
				test.getEmail());
		logger.trace("result : {}", resultTest);
		logger.trace("StandByUser List : {}", repo.getAllStandByUser());
		
		result = repo.deleteStandByUserRequest();
		logger.trace("대기유저 삭제 : {}", result);
		
		
		resultTest = repo.getStandByUser(
				test.getCompanyName(), 
				test.getRepresentName(), 
				test.getEmail());
		logger.trace("result : {}", resultTest);
		
		logger.trace("StandByUser List : {}", repo.getAllStandByUser());
		
		
	}

}
