package leasecity.repo.lease;

import java.util.List;

import leasecity.dto.etc.Page;
import leasecity.dto.lease.LeaseTransfer;

public interface LeaseTransferRepo {
	
	/**
	 * 양도 받은 유저의 양도 작업 개수 출력
	 * @param acceptUserId
	 * @return
	 */
	public Integer getCountSelectAllAcceptLeaseTransfers(String acceptUserId);
	
	/**
	 * 양도 받은 유저의 양도 작업 리스트 페이지로 출력
	 * @param page
	 * @return
	 */
	public List<LeaseTransfer> getSelectPageAcceptLeaseTransfers(Page page);
	
	/**
	 * 임대 양도 번호와 임대받을 유저 아이디로 임대 양도 검색
	 * @param leawseTransferNo
	 * @param acceptUserId
	 * @return
	 */
	public LeaseTransfer getSelectAcceptLeaseTransfer(Integer leaseTransferNo, String acceptUserId);
	
	/**
	 * 양도 보낸 유저의 양도 작업 개수 출력
	 * @param sendUserId
	 * @return
	 */
	public Integer getCountSelectAllSendLeaseTransfers(String sendUserId);
	
	/**
	 * 양도 보낸 유저의 양도 작업 리스트 페이지로 출력
	 * @param page
	 * @return
	 */
	public List<LeaseTransfer> getSelectPageSendLeaseTransfers(Page page);
	
	/**
	 * 임대 양도 추가
	 * @param leaseTransfer
	 * @return
	 */
	public int insertLeaseTransfer(LeaseTransfer leaseTransfer);
	
	/**
	 * 임대 양도 삭제
	 * @param leaseTransfer
	 * @return
	 */
	public int deleteLeaseTransfer(LeaseTransfer leaseTransfer);
	
	/**
	 * 임대 양도 수락 날짜 갱신
	 * @param leaseTransfer
	 * @return
	 */
	public int permissionUpdateLeaseTransfer(LeaseTransfer leaseTransfer);

	/**
	 * 
	 * @param leaseTransferNo
	 * @return
	 */
	
	public LeaseTransfer getSelectLeaseTransfer(Integer leaseTransferNo);
	

}
