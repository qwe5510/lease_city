package leasecity.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import leasecity.config.ApplicationConfig;
import leasecity.dto.adminwork.LeasecityAdmin;
import leasecity.repo.adminwork.LeasecityAdminRepo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={ApplicationConfig.class})
@Transactional
public class adminTest {
	
	@Autowired
	LeasecityAdminRepo repo;
	
	@Test
	public void test(){
		
	}

}
