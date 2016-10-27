package leasecity.test;

import java.util.Date;
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
import leasecity.dto.lease.LeaseRequest;
import leasecity.repo.lease.LeaseRequestRepo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={ApplicationConfig.class})
@Transactional
public class LeaseDirectCallTest {

	
	@Autowired
	LeaseRequestRepo repo;
	
	static Logger logger = LoggerFactory.getLogger(LeaseDirectCallTest.class);
	
	@Test
	public void test(){
		System.out.println(repo);
		
		LeaseRequest leaseRequest = new LeaseRequest(null, 9, "53구 1281", "raven92", new Date(), new Date(), null, 4000);
		int result = repo.insertLeaseRequest(leaseRequest);
		logger.trace("임대신청 추가 : {}", result);
		
		LeaseRequest LR = repo.getLeaseRequest(leaseRequest.getLeaseRequestNo(), "ysh5586");
		logger.trace("임대 신청 확인 : {}", LR);
		
		List<LeaseRequest> list = repo.getAllChoiceLeaseRequests(9);
		logger.trace("선발 중기업체 : {}", list);
		
		list = repo.getAllStandByLeaseRequests(9);
		logger.trace("대기 중기업체 : {}", list);
	}
}