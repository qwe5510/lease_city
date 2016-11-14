package leasecity.repo.adminwork;

import java.util.List;

import leasecity.dto.adminwork.WorkLog;
import leasecity.dto.etc.Page;

public interface WorkLogRepo {
	
	//기록 개수 호출
	
	/**
	 * 임대 신청에 관한 작업 기록 개수 호출
	 * @return
	 */
	public Integer getCountLeaseRequestAndCallWorkLog(String userId);
	
	/**
	 * 임대 양도에 관한 작업 기록 개수 호출
	 * @param userId
	 * @return
	 */
	public Integer getCountLeaseTransferWorkLog(String userId);
	
	/**
	 * 임대 요청에 관한 작업 기록 개수 호출
	 * @param userId
	 * @return
	 */
	public Integer getCountLeaseCallWorkLog(String userId);
	
	
	//페이지 호출
	
	/**
	 * 임대 신청에 관한 작업 기록 호출 - 건설업체
	 * @param pages
	 * @return
	 */
	public List<WorkLog> getPageLeaseRequestAndCallCCWorkLog(Page page);
	
	/**
	 * 임대 신청에 관한 작업 기록 호출 - 중기업체
	 */
	
	public List<WorkLog> getPageLeaseRequestAndCallHECWorkLog(Page page);
	
	/**
	 * 임대 양도에 관한 작업 기록 호출
	 * @param page
	 * @return
	 */
	public List<WorkLog> getPageLeaseTransferWorkLog(Page page);
	
	/**
	 * 임대 요청에 관한 작업 기록 호출
	 * @param page
	 * @return
	 */
	public List<WorkLog> getPageLeaseCallWorkLog(Page page);
	
	
	// 기록 쓰기
	
	/**
	 * 작업 기록 추가
	 * @param page
	 * @return
	 */
	public Integer insertWorkLog(WorkLog workLog);
	
	
	
	// 기록 수정 : 평가 N -> Y 로 수정
	
	public Integer updateEvaluationYes(WorkLog workLog);

}
