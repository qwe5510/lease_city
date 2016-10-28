package leasecity.repo.lease;

import java.util.List;

import leasecity.dto.lease.LeaseDirectCall;

public interface LeaseDirectCallRepo {
	
	/**
	 * 중기업체 ID에 대한 직접신청 목록 조회
	 * @param equipmentId
	 * @return
	 */
	public List<LeaseDirectCall> getAllLeaseDirectCalls(String equipmentId);
	
	/**
	 * 직접신청글 번호로 직접신청 정보 조회
	 * @param leaseDirectNo
	 * @return
	 */
	public LeaseDirectCall getLeaseDirectCall(Integer leaseDirectNo);
	
	/**
	 * 직접 신청 추가
	 * @param leaseDirectCall
	 * @return
	 */
	public int insertLeaseDirectCall(LeaseDirectCall leaseDirectCall);
	
	/**
	 * 직접 신청 삭제
	 * @param leaseDirectCall
	 * @return
	 */
	public int deleteLeaseDirectCall(LeaseDirectCall leaseDirectCall);
	
	
	

}
