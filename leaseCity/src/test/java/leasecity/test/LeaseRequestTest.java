package leasecity.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import leasecity.config.ApplicationConfig;
import leasecity.dto.lease.LeaseDirectCall;
import leasecity.repo.lease.LeaseDirectCallRepo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={ApplicationConfig.class})
@Transactional
public class LeaseRequestTest {

	
	@Autowired
	LeaseDirectCallRepo repo;
	
	static Logger logger = LoggerFactory.getLogger(LeaseRequestTest.class);
	
	@Test
	public void test(){
		System.out.println(repo);

		LeaseDirectCall leaseDirectCall = new LeaseDirectCall(null, "ysh5586", "raven92", 9, "직접요청입니다.", 500, 1000);
		
		int result = repo.insertLeaseDirectCall(leaseDirectCall);
		logger.trace("임대 직접요청 추가 : {}", result);
		logger.trace("번호 확인 : {}", leaseDirectCall);
		
		List<LeaseDirectCall> ldc = repo.getAllLeaseDirectCalls("raven92");
		System.out.println(ldc);
		
		LeaseDirectCall test = repo.getLeaseDirectCall(leaseDirectCall.getLeaseDirectNo());
		
		logger.trace("직접요청 글 DB검색 : {}", test);
		
		result = repo.deleteLeaseDirectCall(leaseDirectCall);
		logger.trace("직접요청 삭제 : {}", result);
		
		ldc = repo.getAllLeaseDirectCalls("raven92");
		System.out.println(ldc);
		
		
	}
}