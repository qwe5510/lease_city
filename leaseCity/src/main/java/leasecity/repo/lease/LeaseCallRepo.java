package leasecity.repo.lease;

import java.util.List;

import leasecity.dto.etc.Page;
import leasecity.dto.lease.LeaseCall;

/**
 * 임대 요청 Repository
 * @author 1-718-8
 *
 */
public interface LeaseCallRepo {
	
	/**
	 * 모든 임대 요청에 대한 개수 리턴
	 * @return
	 */
	public Integer getCountAllLeaseCalls();
	
	/**
	 * 검색 정보가 담긴 페이지를 통한 검색 조건 게시물 갯수 리턴
	 * @param page
	 * @return
	 */
	public Integer getCountSearchLeaseCalls(Page page);
	
	
	/**
	 * 임대 요청에 대하여 특정 페이지에 포함되는 요청 리스트를 반환함 
	 * @param page
	 * @return
	 */
	public List<LeaseCall> getPageLeaseCalls(Page page);
	
	/**
	 * 임대 요청 번호에 의한 임대요청 조회.
	 * @param leaseCallNo
	 * @return
	 */
	public LeaseCall getLeaseCall(Integer leaseCallNo);
	
	/**
	 * 임대 요청 조회 (번호, 유저 ID)
	 * @param leaseCall
	 * @return
	 */
	public LeaseCall getUserLeaseCall(LeaseCall leaseCall);
	
	/**
	 * 임대 요청글 추가
	 * @param leaseCall
	 * @return
	 */
	public int insertLeaseCall(LeaseCall leaseCall);
	
	/**
	 * 임대 요청글 삭제
	 * @param leaseCall
	 * @return
	 */
	public int deleteLeaseCall(LeaseCall leaseCall);
	
	/**
	 * 임대 요청글 수정
	 * @param leaseCall
	 * @return
	 */
	public int updateLeaseCall(LeaseCall leaseCall);
	
	/**
	 * 임대 요청글 조회수 증가
	 * @param leaseCall
	 * @return
	 */
	public int hitsUpLeaseCall(LeaseCall leaseCall);
	

}

