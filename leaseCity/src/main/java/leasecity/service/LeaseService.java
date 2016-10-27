package leasecity.service;

import java.util.List;

import leasecity.dto.etc.Page;
import leasecity.dto.lease.LeaseCall;
import leasecity.dto.lease.LeaseRequest;
import leasecity.exception.ChangeValueFailException;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.RemoveFailException;
import leasecity.exception.WriteFailException;

public interface LeaseService {
	
	/**
	 * 특정 페이지에 대하여 임대 요청 목록 Load
	 * @return
	 */
	public List<LeaseCall> loadLeaseCalls(Page page) throws NotFoundDataException;
	
	/**
	 * 
	 * @param lease
	 * @return
	 */
	public LeaseCall viewLeaseCall(Integer leaseCallNo) throws NotFoundDataException;
	
	/**
	 * 
	 * @param leaseCall
	 */
	public void writeLeaseCall(LeaseCall leaseCall) throws WriteFailException;
	
	/**
	 * 
	 * @param leaseCall
	 * @throws ChangeValueFailException
	 */
	public void updateLeaseCall(LeaseCall leaseCall) throws ChangeValueFailException;
	
	/**
	 * 
	 * @param leaseCall
	 * @throws RemoveFailException
	 */
	public void removeLeaseCall(LeaseCall leaseCall) throws RemoveFailException;
	
	
	
	// // // // // // // // // // // // // // // // // // // // // // // // // // // // //
	
	/**
	 * 임대요청글에 대한 임대신청 대기자 조회.
	 * @param leaseCallNo
	 * @return
	 */
	public List<LeaseRequest> loadStandByLeaseRequests(Integer leaseCallNo) 
													throws NotFoundDataException;
	
	
	/**
	 * 임대요청글에 대한 임대신청 선발자 조회
	 * @param leaseCallNo
	 * @return
	 */
	public List<LeaseRequest> loadChoiceLeaseRequests(Integer leaseCallNo)
													throws NotFoundDataException;
	
	
	
	
	
	// // // // // // // // // // // // // // // // // // // // // // // // // // // // //
	
	/**
	 * 현재 페이지를 리턴하는 메서드
	 * @param currentPage
	 * @param pageSize
	 * @param search
	 * @param keyword
	 * @return
	 */
	public Page getSearchCommentPage
		(Integer currentPage, Integer pageSize,	String search, String keyword);
}
