package leasecity.repo.lease;

import java.util.List;

import leasecity.dto.etc.Page;
import leasecity.dto.lease.LeaseDirectCall;

public interface LeaseDirectCallRepo {
	
	/**
	 * 중기업체 ID에 대한 리스트의 개수 리턴
	 * @param equipmentId
	 * @return
	 */
	public Integer getCountSelectHECLeaseDirectCalls(String equipmentId);
	
	/**
	 * 중기업체 ID에 대한 직접신청 목록 페이징 조회
	 * @param equipmentId
	 * @return
	 */
	public List<LeaseDirectCall> getPageSelectHECLeaseDirectCalls(Page page);
	
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
	
	/**
	 * 오늘날짜가 시작날짜를 지난 직접요청들을 삭제하는 메서드
	 * @return
	 */
	public int deleteOutBoundDirectCall();

}
