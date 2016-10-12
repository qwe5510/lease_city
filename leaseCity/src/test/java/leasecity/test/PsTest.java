package leasecity.test;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;

import java.security.NoSuchAlgorithmException;
import java.sql.Date;
import java.util.List;

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
import leasecity.dto.user.User;
import leasecity.repo.user.UserRepo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { ApplicationConfig.class })
@Transactional //자동 롤백 설정
public class PsTest {

	static Logger logger = LoggerFactory.getLogger(PsTest.class);

	@Autowired
	SqlSessionTemplate session;

	@Autowired
	UserRepo repo;

	@Test
	public void passwordTest() throws NoSuchAlgorithmException {

		logger.trace("session : {}", session);
		
		User new_user = new User("test1","testpass",
				"테스트", "김시험",
				"032)331-2314", "010-3239-2031",
				"whgdkfk12@gmail.com", "112", "경기도 포천시",
				"ON", "www.test.def", null, 4.2, null);
		
		System.out.println(new_user);
		
		int result = repo.insertUser(new_user);
		logger.trace("User 생성 : {}", result);

		List<User> users = repo.getAllUsers();
		assertThat(users.size(), is(3));
		logger.trace("User list : {}", users);

		User user = repo.getUser("ysh5586");
		assertThat(user, is(notNullValue()));
		logger.trace("User : {}", user);

		logger.trace("원래 비밀번호 : {}", user.getPassword());
		//repo.hashingPassword(user);
		
		user = repo.getUser("ysh5586");
		logger.trace("해싱된 비밀번호 : {}", user.getPassword());

	}
	
	
	@Test
	public void commentTest(){
		
	}

}
