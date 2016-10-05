package leasecity.test;

import java.security.NoSuchAlgorithmException;

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
import leasecity.dto.user.HeavyEquipmentCompany;
import leasecity.dto.user.User;
import leasecity.repo.user.HeavyEquipmentCompanyRepo;
import leasecity.repo.user.UserRepo;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={ApplicationConfig.class})

public class HECTest {

	static Logger logger = LoggerFactory.getLogger(HECTest.class);
	
	@Autowired
	SqlSessionTemplate session;
	
	@Autowired
	UserRepo repo;
	
	@Autowired
	HeavyEquipmentCompanyRepo HECrepo;

	@Test
	public void HECTest(){
		
		logger.trace("session : {}", session);
		
		User user = repo.getUser("ysh5586");
		logger.trace("유저 검색 : {}", user);
		
		HeavyEquipmentCompany HEC = 
				new HeavyEquipmentCompany(user, "ON", "ON");
		
		System.out.println(HEC);
		
		int result = HECrepo.insertHeavyEquipmentCompany(HEC);		
		logger.trace("중기업체 추가 : {}",result);
	
	}

}
