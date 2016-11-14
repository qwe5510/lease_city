package leasecity.service;

import java.util.List;

import leasecity.dto.adminwork.WorkLog;
import leasecity.dto.etc.Page;
import leasecity.dto.lease.LeaseCall;
import leasecity.dto.lease.LeaseRequest;
import leasecity.dto.lease.LeaseTransfer;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.WriteFailException;

public interface MyPageService {
	
	/**
	 * 임대 요청에 대한 신청 작업기록 페이지에 맞추어 검색 - 건설업체
	 * @param page
	 * @return
	 * @throws NotFoundDataException
	 */
	public List<WorkLog> loadPageLeaseRequestAndCallCCWorkLog(Page page) throws NotFoundDataException;
	
	/**
	 * 임대 요청에 대한 신청 작업기록 페이지에 맞추어 검색 - 중기업체
	 * @param page
	 * @return
	 * @throws NotFoundDataException
	 */
	public List<WorkLog> loadPageLeaseRequestAndCallHECWorkLog(Page page) throws NotFoundDataException;
	
	/**
	 * 임대양도 작업기록 페이지에 맞추어 검색
	 * @param page
	 * @return
	 * @throws NotFoundDataException
	 */
	public List<WorkLog> loadPageLeaseTransferWorkLog(Page page) throws NotFoundDataException;
	
	/**
	 * 임대요청 작업기록 페이지에 맞추어 검색
	 * @param page
	 * @return
	 * @throws NotFoundDataException
	 */
	public List<WorkLog> loadPageLeaseCallWorkLog(Page page) throws NotFoundDataException;
	
	
	
	/**
	 * 임대 요청에 대한 신청 작업기록 페이지를 리턴하는 메서드 (중기업체, 건설업체 둘다 씀)
	 * @param currentPage
	 * @param PageSize
	 * @param userId
	 * @return
	 */
	public Page getRequestAndCallLogPage(Integer currentPage, Integer pageSize, String userId);
	
	/**
	 * 임대 양도 작업기록 페이지를 리턴하는 메서드
	 * @param currentPage
	 * @param pageSize
	 * @param userId
	 * @return
	 */
	public Page getTransferLogPage(Integer currentPage, Integer pageSize, String userId);
	
	/**
	 * 임대 요청 작업기록 페이지를 리턴하는 메서드
	 * @param currentPage
	 * @param pageSize
	 * @param userId
	 * @return
	 */
	public Page getCallLogPage(Integer currentPage, Integer pageSize, String userId);
	
	
	
	
	/**
	 * 임대 요청 작성 시 기록
	 * @param leaseCall
	 * @throws WriteFailException
	 */
	public void writeCallWorkLog(LeaseCall leaseCall) throws WriteFailException;
	
	/**
	 * 임대신청 기록 시 쓰기 (건설업체/중기업체용)
	 * @param leaseCall
	 * @param userId
	 */
	public void writeRequestWorkLog(LeaseRequest leaseRequest, String userId) throws WriteFailException;
	
	/**
	 * 임대양도 기록 쓰기
	 * @param leaseTransfer
	 */
	public void writeTransferWorkLog(LeaseTransfer leaseTransfer) throws WriteFailException;

	
	
	
}
