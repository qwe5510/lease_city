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
import leasecity.dto.user.ConstructionCompany;
import leasecity.dto.user.User;
import leasecity.repo.user.ConstructionCompanyRepo;
import leasecity.repo.user.UserRepo;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={ApplicationConfig.class})
@Transactional
public class CCTest {

	static Logger logger = LoggerFactory.getLogger(CCTest.class);
	
	@Autowired
	SqlSessionTemplate session;
	
	@Autowired
	UserRepo repo;
	
	@Autowired
	ConstructionCompanyRepo CCrepo;

	@Test
	public void HECTest(){
		List<ConstructionCompany> CCList = new ArrayList<>();
		logger.trace("session : {}", session);
		
		User user = repo.getUser("raven92");
		logger.trace("유저 검색 : {}", user);
		
		ConstructionCompany CC = 
				new ConstructionCompany(user, 2500.0, 240, "소", "건축/토목");
		System.out.println(CC);
		
		int result = CCrepo.insertConstructionCompany(CC);
		logger.trace("건설업체 추가 : {}", result);
		
		user = repo.getUser("ysh5586");
		logger.trace("유저2 검색 : {}", user);
		
		CC = null; //memory 해지 
		CC = new ConstructionCompany(user, 2500.0, 240, "중", "토목/해양");
		System.out.println(CC);
		
		result = CCrepo.insertConstructionCompany(CC);
		logger.trace("건설업체2 추가 : {}", result);
		
		ConstructionCompany CC_One = 
				CCrepo.getCCUser(user.getUserId());
		System.out.println(CC_One.getRepresentName());
		
		logger.trace("건설업체 검색 : {}", CC_One);
		
		CCList = CCrepo.getAllConstructionCompanys();
		logger.trace("건설업체 리스트 : {}",CCList);
		
		result = repo.deleteUser(user);
		logger.trace("건설업체2 삭제 : {}", result);
		
		/*result = CCrepo.deleteConstructionCompany(CC);
		logger.trace("건설업체2 삭제 : {}", result);*/
		
		CCList = CCrepo.getAllConstructionCompanys();
		logger.trace("건설업체 리스트 : {}",CCList);
		
	}

}
