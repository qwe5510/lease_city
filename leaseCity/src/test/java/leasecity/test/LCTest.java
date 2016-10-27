package leasecity.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import leasecity.config.ApplicationConfig;
import leasecity.dto.etc.Page;
import leasecity.dto.lease.LeaseCall;
import leasecity.repo.lease.LeaseCallRepo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { ApplicationConfig.class })
@Transactional //자동 롤백 설정
public class LCTest {
	
	@Autowired
	LeaseCallRepo repo;
	
	@Test
	public void test(){
		
		Page page = new Page();
		page.setCurrentPage(1);
		page.setPageSize(20);
		page.setFromTo();
		
		List<LeaseCall> list = repo.getPageLeaseCalls(page);
		System.out.println(list);
	}

}
