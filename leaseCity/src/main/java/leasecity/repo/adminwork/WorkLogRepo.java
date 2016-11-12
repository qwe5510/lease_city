package leasecity.repo.adminwork;

import java.util.List;

import leasecity.dto.adminwork.WorkLog;
import leasecity.dto.etc.Page;

public interface WorkLogRepo {
	
	/**
	 * 
	 * @return
	 */
	public Integer getCountAllWorkLog(String userId);
	
	/**
	 * 
	 * @param page
	 * @return
	 */
	public List<WorkLog> getPageWorkLog(Page page);
	
	

}
