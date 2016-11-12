package leasecity.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import leasecity.dto.adminwork.WorkLog;
import leasecity.dto.etc.Page;
import leasecity.exception.NotFoundDataException;
import leasecity.repo.adminwork.WorkLogRepo;

@Service
public class MyPageServiceImpl implements MyPageService {

	@Autowired
	WorkLogRepo workLogRepo;
	
	
	@Override
	public List<WorkLog> loadPageWorkLog(Page page) throws NotFoundDataException {
		List<WorkLog> result = workLogRepo.getPageWorkLog(page);
		
		if(result.size() <= 0){
			throw new NotFoundDataException("작업 기록");
		}
		
		return result;
	}

	@Override
	public Page getWorkLogPage(Integer currentPage, Integer pageSize, String userId) {
		Page page = new Page();
		page.setTotalCount(workLogRepo.getCountAllWorkLog(userId));
		page.setCurrentPage(currentPage);
		page.setPageSize(pageSize);
		page.setUserId(userId);
		page.setFromTo();
		
		return page;
	}

}
