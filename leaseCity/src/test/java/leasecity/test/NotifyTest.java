package leasecity.test;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import leasecity.config.ApplicationConfig;
import leasecity.dto.adminwork.LeasecityAdmin;
import leasecity.dto.adminwork.Notify;
import leasecity.repo.adminwork.LeasecityAdminRepo;
import leasecity.repo.adminwork.NotifyRepo;
import leasecity.repo.user.UserRepo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={ApplicationConfig.class})

public class NotifyTest {
	
	static Logger logger = LoggerFactory.getLogger(NotifyTest.class);
	
	@Autowired
	SqlSessionTemplate session;

	@Autowired
	NotifyRepo repo;

	@Test
	public void passwordTest() {

		logger.trace("session : {}", session);
		
		Notify notify = new Notify(null, "yhjcom78", null, null, null, null, null, null, null, null);
		
		
		System.out.println(notify);
		
		int result = repo.insertNotify(notify);
		/*logger.trace("notify 생성 : {}", result);
		logger.trace("userId : {}", notify.getUserId());*/
		
		/*
		List<Notify> notifyList = repo.getAllNotify();
		logger.trace("notify List : {}", notifyList);
		
		notifyList = repo.getNotify(notify.getUserId());
		logger.trace("yhjcom78의 정보 : {}", notifyList);*/
		
		/*result = repo.deleteNotify(notify.getUserId());
		logger.trace("notify 삭제 : {}", result);*/
		
		/*notify = repo.getNotify(notify.getUserId());
		logger.trace("yhjcom78 조회 : {}", notify);
		
		List<Notify> notify2 = repo.getAllNotify();
		logger.trace("notify list : {}", notify2);*/
		/*List<User> users = repo.getAllUsers();
		assertThat(users.size(), is(3));
		logger.trace("User list : {}", users);

		User user = repo.getUserCheckId("ysh5586");
		assertThat(user, is(notNullValue()));
		logger.trace("User : {}", user);

		logger.trace("원래 비밀번호 : {}", user.getPassword());
		//repo.hashingPassword(user);
		user = repo.getUserCheckId("ysh5586");
		logger.trace("해싱된 비밀번호 : {}", user.getPassword());*/

	}
}
