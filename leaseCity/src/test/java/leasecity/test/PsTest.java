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
import leasecity.repo.user.UsersRepo;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={ApplicationConfig.class})
public class PsTest {

	static Logger logger = LoggerFactory.getLogger(PsTest.class);
	
	@Autowired
	SqlSessionTemplate session;
	
	@Autowired
	UsersRepo repo;

	@Test
	public void passwordTest() throws NoSuchAlgorithmException {
		
		//MessageDigest md = MessageDigest.getInstance("MD5");
		logger.trace("session : {}", session);
	
		List<User> users = repo.getAllUsers();
		
		assertThat(users, is(notNullValue()));
		logger.trace("User : {}",users);
		
	}

}
