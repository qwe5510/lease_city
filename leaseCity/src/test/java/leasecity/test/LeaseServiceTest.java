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
import leasecity.exception.NotFoundDataException;
import leasecity.service.LeaseService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={ApplicationConfig.class})
@Transactional
public class LeaseServiceTest {
	
	@Autowired
	LeaseService service;
	
	@Test
	public void test() throws NotFoundDataException{
		Page page = new Page();
		page.setPageSize(5);
		page.setCurrentPage(1);
		
		List<LeaseCall> list = service.loadLeaseCalls(page);
		
		System.out.println(list);
		
		
	}

}
