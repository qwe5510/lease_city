package leasecity.repo.lease;

import java.util.List;

import leasecity.dto.lease.LeaseRequest;

public interface LeaseRequestRepo {

	/**
	 * 임대 신청 대기자 인원수
	 * @return
	 */
	public Integer getCountStandByLeaseRequests(Integer leaseCallNo);
	
	/**
	 * 임대 신청 선발자 인원수
	 * @return
	 */
	public Integer getCountChoiceLeaseRequests(Integer leaseCallNo);
	
	/**
	 * 임대 신청에 대하여 선발되지 않은 중기업체 리스트를 출력함 : 임대 요청글 번호로 조회 
	 * @param page
	 * @return
	 */
	public List<LeaseRequest> getAllStandByLeaseRequests(Integer leaseCallNo);
	
	/**
	 * 임대 신청에 대하여 선발된 중기업체 리스트를 출력 : 임대 요청글 번호로 조회
	 * @param page
	 * @return
	 */
	public List<LeaseRequest> getAllChoiceLeaseRequests(Integer leaseCallNo);
	
	/**
	 * 입력받은 차량번호가 현재 어느 요청글에 신청되어있는지 요청글번호 리턴
	 */
	public Integer getSearchIdNumberLeaseRequest(String idNumber);
	
	/**
	 * 임대 신청 번호와 건설업체 유저 id로 임대업체 리턴.
	 * @param leaseCallNo
	 * @param user_id
	 * @return
	 */
	public LeaseRequest getLeaseRequest(Integer leaseRequestNo, String userId);
	
	/**
	 * 신청번호가지고 임대신청 정보 받기.
	 * @param leaseRequestNo
	 * @return
	 */
	public LeaseRequest getSimpleLeaseRequest(Integer leaseRequestNo);
	
	/**
	 * 임대 신청 추가
	 * @param leaseRequstNo
	 * @return
	 */
	public int insertLeaseRequest(LeaseRequest leaseRequest);
	
	/**
	 * 임대 신청글 삭제
	 * @param leaseRequst
	 * @return
	 */
	public int deleteLeaseRequest(LeaseRequest leaseRequest);
	
	/**
	 * 임대 신청글 추가
	 * @param leaseRequst
	 * @return
	 */
	public int choiceLeaseRequest(LeaseRequest leaseRequest);
	
	
	
	
}
