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
import leasecity.dto.user.HeavyEquipment;
import leasecity.dto.user.HeavyEquipmentCompany;
import leasecity.dto.user.User;
import leasecity.repo.user.HeavyEquipmentCompanyRepo;
import leasecity.repo.user.HeavyEquipmentRepo;
import leasecity.repo.user.UserRepo;
import leasecity.service.UserService;


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
	
	@Autowired
	HeavyEquipmentRepo HERepo;
	
	@Test
	public void HECTest(){
		int result;
		
		logger.trace("session : {}", session);
		List<HeavyEquipmentCompany> HECList = new ArrayList<>();
		
		User user = repo.getUser("ysh5586");
		logger.trace("유저 검색 : {}", user);
		
		HeavyEquipmentCompany HEC = 
				new HeavyEquipmentCompany(user, "ON", "ON");
	
		
		System.out.println(HEC);
		
		User new_user = new User("test1","testpass",
				"테스트", "김시험",
				"032)331-2314", "010-3239-2031",
				"whgdkfk12@gmail.com", "경기도 포천시",
				"ON", "www.test.def", null, 4.2, null);
		HeavyEquipmentCompany HEC3 =
				new HeavyEquipmentCompany(new_user, "ON", "ON");
		
		result = repo.insertUser(HEC3);
		logger.trace("회원 추가 : {}", result);
		
		List<User> list = repo.getAllUsers();
		logger.trace("회원 리스트 : {}", list);
		
		result = HECrepo.insertHeavyEquipmentCompany(HEC);		
		logger.trace("중기업체1 추가 : {}",result);
		result = HECrepo.insertHeavyEquipmentCompany(HEC3);
		logger.trace("중기업체3 추가 : {}",result);

		HECList = HECrepo.getAllHeavyEquipmentCompanys();
		logger.trace("중기업체 리스트 : {}", HECList);
		
		HeavyEquipmentCompany HEC_One = HECrepo.getHeavyEquipmentCompany("ysh5586");
		logger.trace("중기업체 : {}",HEC_One);
		
		result = repo.deleteUser(HEC_One);
		logger.trace("중기업체 삭제 : {}", result);
		
		HECList = HECrepo.getAllHeavyEquipmentCompanys();
		logger.trace("중기업체 리스트 : {}", HECList);
		
		HeavyEquipmentCompany testHEC
			= HECrepo.getHECUser("raven92");
		
		logger.trace("raven92 중기업체 검색 : {}", testHEC);
		logger.trace("raven92 유저 검색 : {}", testHEC.userInfo());
		
		logger.trace("Heavy Equipment Repository : {}", HERepo);
		
		
		result = HERepo.insertHeavyEquipment(
				new HeavyEquipment("30경기 화 2300", "raven92", "화물/대"));
		logger.trace("raven92 회원 중장비 추가 : {}", result);
		
		List<HeavyEquipment> HEList = HERepo.getAllHeavyEquipments();
		logger.trace("중장비 리스트 : {}", HEList);
		
		HEList = HERepo.getUserHeavyEquipments("raven92");
		logger.trace("중장비 리스트 : {}", HEList);
	}
	
}
