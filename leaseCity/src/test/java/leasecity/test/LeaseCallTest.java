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
import leasecity.dto.etc.Page;
import leasecity.dto.lease.LeaseCall;
import leasecity.repo.lease.LeaseCallRepo;
import leasecity.util.DateUtil;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={ApplicationConfig.class})
@Transactional
public class LeaseCallTest {
	
	@Autowired
	LeaseCallRepo repo;
	//로거
	static Logger logger = LoggerFactory.getLogger(LeaseCallTest.class);
	
	@Test
	public void test(){
		System.out.println(repo);
		
		Date fromDate = DateUtil.dateFormat("2016-02-01"); 
		Date toDate =  DateUtil.dateFormat("2016-10-27");
		
		LeaseCall leaseCall = 
				new LeaseCall(null, "ysh5586", "현진건설", "토목", "포크레인", 
						"경기도 평택시 엘지로 55 (한일아파트) 102동 203호",
						"임대요청 제목", "임대요청 내용", 0, fromDate, toDate, null, 500, 1000);
		
		int result = repo.insertLeaseCall(leaseCall);
		logger.trace("임대 요청 삽입 : {}", result);
		
		result = repo.deleteLeaseCall(leaseCall);
		logger.trace("임대 요청 삭제 : {}", result);
		
		/*result = repo.getCountAllLeaseCalls();
		logger.trace("임대 요청글 개수 : {}", result);
		
		Page page = new Page();
		page.setCurrentPage(1);
		page.setPageSize(20);
		page.setFromTo();
		
		List<LeaseCall> list = repo.getPageLeaseCalls(page);
		System.out.println(list);
		
		LeaseCall leaseCall2 = repo.getLeaseCall(leaseCall.getLeaseCallNo());
		
		logger.trace("임대 요청 확인 : {}", leaseCall2);
		
		result = repo.deleteLeaseCall(leaseCall2);
		logger.trace("임대 요청 삭제 : {}", result);
		
		list = repo.getPageLeaseCalls(page);
		System.out.println(list);
		
		*/
	}
	

}
