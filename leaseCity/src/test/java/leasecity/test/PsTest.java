package leasecity.test;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;

import java.security.NoSuchAlgorithmException;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import leasecity.config.ApplicationConfig;
import leasecity.dto.user.User;
import leasecity.repo.user.UserRepo;
import leasecity.util.HashingUtil;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { ApplicationConfig.class })
// @Transactional //자동 롤백 설정
public class PsTest {

	static Logger logger = LoggerFactory.getLogger(PsTest.class);

	@Autowired
	SqlSessionTemplate session;

	@Autowired
	UserRepo repo;

	@Test
	public void passwordTest() throws NoSuchAlgorithmException {

		logger.trace("session : {}", session);

		List<User> users = repo.getAllUsers();
		assertThat(users.size(), is(3));
		logger.trace("User list : {}", users);

		User user = repo.getUser("ysh5586");
		assertThat(user, is(notNullValue()));
		logger.trace("User : {}", user);

		logger.trace("원래 비밀번호 : {}", user.getPassword());
		repo.hashingPassword(user);
		
		user = repo.getUser("ysh5586");
		logger.trace("해싱된 비밀번호 : {}", user.getPassword());

	}

}
