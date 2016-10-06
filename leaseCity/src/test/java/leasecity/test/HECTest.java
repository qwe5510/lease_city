package leasecity.test;

import java.util.ArrayList;
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
import leasecity.dto.user.HeavyEquipmentCompany;
import leasecity.dto.user.User;
import leasecity.repo.user.HeavyEquipmentCompanyRepo;
import leasecity.repo.user.UserRepo;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={ApplicationConfig.class})
@Transactional
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
		List<HeavyEquipmentCompany> HECList = new ArrayList<>();
		
		User user = repo.getUser("ysh5586");
		logger.trace("유저 검색 : {}", user);
		
		User user2 = repo.getUser("raven92");
		logger.trace("유저2 검색 : {}", user2);
		
		HeavyEquipmentCompany HEC = 
				new HeavyEquipmentCompany(user, "ON", "ON");
		
		HeavyEquipmentCompany HEC2 = 
				new HeavyEquipmentCompany(user2, "ON", "ON");
		
		System.out.println(HEC);
		System.out.println(HEC2);
		
		int result = HECrepo.insertHeavyEquipmentCompany(HEC);		
		logger.trace("중기업체1 추가 : {}",result);
		result = HECrepo.insertHeavyEquipmentCompany(HEC2);		
		logger.trace("중기업체2 추가 : {}",result);

		HECList = HECrepo.getAllHeavyEquipmentCompanys();
		logger.trace("중기업체 리스트 : {}", HECList);
		
		HeavyEquipmentCompany HEC_One = HECrepo.getHeavyEquipmentCompany("ysh5586");
		logger.trace("중기업체 : {}",HEC_One);
		
		result = HECrepo.deleteHeavyEquipmentCompany(HEC_One);
		logger.trace("중기업체 삭제 : {}", result);
		
		HECList = HECrepo.getAllHeavyEquipmentCompanys();
		logger.trace("중기업체 리스트 : {}", HECList);
		
		
	}

}
