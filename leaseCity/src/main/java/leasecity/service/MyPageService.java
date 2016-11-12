package leasecity.service;

import java.util.List;

import leasecity.dto.adminwork.WorkLog;
import leasecity.dto.etc.Page;
import leasecity.exception.NotFoundDataException;

public interface MyPageService {
	
	/**
	 * 작업기록 페이지에 맞추어 검색
	 * @param page
	 * @return
	 */
	public List<WorkLog> loadPageWorkLog(Page page) throws NotFoundDataException;
	
	/**
	 * 작업기록 페이지를 리턴하는 메서드
	 * @param currentPage
	 * @param PageSize
	 * @param userId
	 * @return
	 */
	public Page getWorkLogPage(Integer currentPage, Integer pageSize, String userId);
	

}
