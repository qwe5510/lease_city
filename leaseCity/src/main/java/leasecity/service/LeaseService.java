package leasecity.service;

import java.util.List;

import leasecity.dto.etc.Page;
import leasecity.dto.lease.LeaseCall;
import leasecity.dto.lease.LeaseDirectCall;
import leasecity.dto.lease.LeaseRequest;
import leasecity.dto.lease.LeaseTransfer;
import leasecity.dto.user.HeavyEquipmentCompany;
import leasecity.dto.user.User;
import leasecity.exception.ChangeValueFailException;
import leasecity.exception.DuplicateValueException;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.RemoveFailException;
import leasecity.exception.ServiceFailException;
import leasecity.exception.WriteFailException;

public interface LeaseService {
	
	// 임대 요청
	
	/**
	 * 임대 요청 목록 페이지 Load
	 * @return
	 */
	public List<LeaseCall> loadLeaseCalls(Page page) throws NotFoundDataException;
	
	/**
	 * 건설업체 유저 id에 대한 요청글 조회.
	 * @param userId
	 * @return
	 * @throws NotFoundDataException
	 */
	public List<LeaseCall> loadConstructionUserLeaseCalls(String userId) throws NotFoundDataException;
	
	/**
	 * 임대 요청글 정보 리턴
	 * @param leaseCallNo
	 * @return
	 * @throws NotFoundDataException
	 */
	public LeaseCall loadLeaseCall(Integer leaseCallNo) throws NotFoundDataException;
	
	/**
	 * 임대 요청 보기
	 * @param lease
	 * @return
	 */
	public LeaseCall viewLeaseCall(Integer leaseCallNo, String userId) throws NotFoundDataException;
	
	/**
	 * 임대 요청 작성 (같은 지역 중기업체에게 알림)
	 * @param leaseCall
	 */
	public void writeLeaseCall(LeaseCall leaseCall) throws WriteFailException;
	
	/**
	 * 임대 요청 수정(신청자가 있을 경우 불가능)
	 * @param leaseCall
	 * @throws ChangeValueFailException
	 */
	public void updateLeaseCall(LeaseCall leaseCall) throws ChangeValueFailException;
	
	/**
	 * 임대요청 삭제
	 * @param leaseCall
	 * @throws RemoveFailException
	 */
	public void removeLeaseCall(LeaseCall leaseCall) throws RemoveFailException;
	
	
	
	// // // // // // // // // // // // // // // // // // // // // // // // // // // // //
	// 임대 신청
	
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

	/**
	 * 임대 신청 번호와 신청한 대상의 요청글 작성자 아이디로 임대신청 정보 확인
	 * @param leaseRequestNo 임대 신청 번호
	 * @param userId 요청글 작성자 아이디
	 * @return
	 * @throws NotFoundDataException 정보가 없을 때
	 */
	public LeaseRequest loadLeaseRequest(Integer leaseRequestNo, String userId)
											throws NotFoundDataException;
	
	/**
	 * 임대 신청 하기 (알림) - 신청과 동시에 중장비 사용여부 Y
	 * @param leaseRequest 
	 * @throws DuplicateValueException 
	 */
	public void doLeaseRequest(LeaseRequest leaseRequest)
									throws ServiceFailException;
	
	/**
	 * 임대 신청 수락 (알림)
	 * @param leaseRequest 수락 할 임대 신청 클래스
	 * @return
	 * @throws ChangeValueFailException
	 */
	public void permissionLeaseRequest(LeaseRequest leaseRequest)
											throws ChangeValueFailException;
	
	/**
	 * 임대 신청 거절 (알림)
	 * @param leaseRequest 거절 할 임대 신청 클래스 - 거절과 동시에 중장비 사용여부 N
	 * @throws ChangeValueFailException
	 */
	public void rejectionLeaseRequest(LeaseRequest leaseRequest)
											throws ChangeValueFailException;
	
	/**
	 * 임대 신청 취소 (알림)
	 * @param leaseRequest 취소 할 임대 신청 클래스 - 취소와 동시에 중장비 사용여부 N
	 * @throws ChangeValueFailException
	 */
	public void cancelLeaseRequest(LeaseRequest leaseRequest)
											throws ChangeValueFailException;
	
	// // // // // // // // // // // // // // // // // // // // // // // // // // // // //
	// 임대 직접 신청
	/**
	 * 중기업체 id에 대하여 임대 직접 요청 조회
	 * @param equipmentId
	 * @return
	 */
	public List<LeaseDirectCall> loadLeaseDirectCalls(String equipmentId)
											throws NotFoundDataException;
	
	/**
	 * 중기업체 직접요청 수락 (알림)
	 * @param leaseDirectCall
	 * @param price
	 */
	public void permissionLeaseDirectCall(LeaseDirectCall leaseDirectCall, LeaseRequest leaseRequest)
														throws ServiceFailException, RemoveFailException, NotFoundDataException;
	
	/**
	 * 중기업체 직접요청 거절 (알림)
	 * @param leaseDirectCall
	 * @throws ServiceFailException
	 */
	public void rejectionLeaseDirectCall(LeaseDirectCall leaseDirectCall)
														throws RemoveFailException;
	
	
	// // // // // // // // // // // // // // // // // // // // // // // // // // // // //
	//임대 양도
	
	/**
	 * 페이지에 대하여 임대 받을 양도 리스트 출력
	 * @param page
	 * @return
	 */
	public List<LeaseTransfer> loadAcceptLeaseTransfer(Page page) 
														throws NotFoundDataException;
	
	/**
	 * 임대 양도 보기
	 * @param leaseTransferNo
	 * @param acceptUserId
	 * @return 정보를 확인 할 임대 양도
	 * @throws NotFoundDataException
	 */
	public LeaseTransfer viewLeaseTransfer(Integer leaseTransferNo, String acceptUserId)
														throws NotFoundDataException;
	
	/**
	 * 임대 양도 하기 (알림)
	 * @param leaseTransfer
	 */
	public void doLeaseTransfer(LeaseTransfer leaseTransfer) throws ServiceFailException;
	
	/**
	 * 임대 양도 수락하기 (알림)
	 * @param leaseTransfer
	 * @throws ServiceFailException
	 */
	public void permissionLeaseTransfer(LeaseTransfer leaseTransfer)
												throws ChangeValueFailException;
	
	/**
	 * 임대 양도 거절
	 * @param leaseTransfer
	 * @throws ChangeValueFailException
	 */
	public void rejectionLeaseTransfer(LeaseTransfer leaseTransfer)
												throws RemoveFailException;
	/**
	 * 임대 양도 취소
	 * @param leaseTransfer
	 * @throws RemoveFailException
	 */
	public void cancelLeaseTransfer(LeaseTransfer leaseTransfer)
												throws RemoveFailException;
	

	// // // // // // // // // // // // // // // // // // // // // // // // // // // // //
	//현재 미사용 영역
	
	/**
	 * 건설업체에 대한 정보 출력을 위한 메서드
	 * @param ConstructionId
	 * @return
	 *//*
	public ConstructionCompany viewConstructionCompanyInfo(String constructionId)
														throws NotFoundDataException;*/
	
	// // // // // // // // // // // // // // // // // // // // // // // // // // // // //
	//중기업체 조회 영역
	
	/**
	 * 유저 별 중기업체 페이지 단위 리스트 출력
	 * @param user : 로그인 중인 회원 정보
	 * @param page : 페이지 정보.
	 * @return
	 */
	public List<HeavyEquipmentCompany> lookUpHeavyEquipmentCompanies(User user, Page page)
														throws NotFoundDataException;
	
	/**
	 * 중기업체 정보 열람. 로그인중인 회원과 열람대상 회원 Id를 파라미터로 받음
	 * @param user
	 * @param equipmentId
	 * @return
	 */
	public HeavyEquipmentCompany viewHeavyEquipment(String equipmentId)
														throws NotFoundDataException;
	
	
	
	// // // // // // // // // // // // // // // // // // // // // // // // // // // // //
	//페이지 영역
	
	/**
	 * 더보기 방식의 페이지를 리턴하는 메소드 (검색 포함)
	 * @param currentPage
	 * @param pageSize
	 * @param search
	 * @param keyword
	 * @return
	 */
	public Page getMoreViewSearchPage
		(Integer currentPage, Integer pageSize,	String search, String keyword);
	
	/**
	 * 더 보기 방식의 페이지를 리턴하는 메소드(중기업체 조회 / 검색 포함)
	 * @param currentPage 현재 페이지
	 * @param pageSize 페이지 크기
	 * @param search 검색컨텐츠
	 * @param keyword 검색어
	 * @param isCompany (HEC : 중기업체 / CC : 건설업체)
	 * @return 
	 */
	public Page getMoreViewHECPage
		(Integer currentPage, Integer pageSize,	String search, String keyword, String isCompany);
	
	/**
	 * 임대 양도에 대한 페이지 (검색없음)
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public Page getTransferPage(Integer currentPage, Integer pageSize, String userId);
	
	/**
	 * 모든 임대 요청 갖고 오기
	 * @return
	 */
	public List<LeaseCall> loadAllLeaseCalls() throws NotFoundDataException;
	
}
