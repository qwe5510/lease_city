package leasecity.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import leasecity.config.ApplicationConfig;
import leasecity.dto.adminwork.Notify;
import leasecity.dto.user.User;
import leasecity.repo.adminwork.NotifyRepo;
import leasecity.repo.user.MypageRepo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={ApplicationConfig.class})

public class MypageTest {
	
	static Logger logger = LoggerFactory.getLogger(MypageTest.class);
	
	@Autowired
	SqlSessionTemplate session;

	@Autowired
	MypageRepo repo;

	@Test
	public void mypageTest() {

		User user = repo.getUser("yhjcom7");
		logger.trace("마이페이지 유저 : {}", user);
	}
}
