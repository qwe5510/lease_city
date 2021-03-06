package leasecity.service;

import java.util.List;
import java.util.StringTokenizer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import leasecity.dto.etc.Page;
import leasecity.dto.lease.LeaseCall;
import leasecity.dto.lease.LeaseDirectCall;
import leasecity.dto.lease.LeaseRequest;
import leasecity.dto.lease.LeaseTransfer;
import leasecity.dto.user.ConstructionCompany;
import leasecity.dto.user.HeavyEquipment;
import leasecity.dto.user.HeavyEquipmentCompany;
import leasecity.dto.user.User;
import leasecity.exception.ChangeValueFailException;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.RemoveFailException;
import leasecity.exception.ServiceFailException;
import leasecity.exception.WriteFailException;
import leasecity.repo.lease.LeaseCallRepo;
import leasecity.repo.lease.LeaseDirectCallRepo;
import leasecity.repo.lease.LeaseRequestRepo;
import leasecity.repo.lease.LeaseTransferRepo;
import leasecity.repo.user.ConstructionCompanyRepo;
import leasecity.repo.user.HeavyEquipmentRepo;
import leasecity.repo.user.LookUpHeavyEquipmentRepo;
import leasecity.repo.user.UserRepo;

@Service
@Transactional
public class LeaseServiceImpl implements LeaseService {

	@Autowired
	LeaseCallRepo leaseCallRepo;
	
	@Autowired
	LeaseRequestRepo leaseRequestRepo;
	
	@Autowired
	LeaseDirectCallRepo leaseDirectCallRepo;
	
	@Autowired
	LeaseTransferRepo leaseTransferRepo;
	
	@Autowired
	ConstructionCompanyRepo constructionCompanyRepo;
	
	@Autowired
	HeavyEquipmentRepo heavyEquipmentRepo;
	
	@Autowired
	LookUpHeavyEquipmentRepo lookUpHeavyEquipmentRepo;
	
	@Autowired
	UserRepo userRepo;
	
	
	static Logger logger = LoggerFactory.getLogger(LeaseServiceImpl.class);
	
	//임대 요청-----------------------------------------------------------------------------
	
	@Override
	public List<LeaseCall> loadLeaseCalls(Page page) throws NotFoundDataException {
		List<LeaseCall> result = leaseCallRepo.getPageLeaseCalls(page);
		
		if(result.size() <= 0){
			throw new NotFoundDataException("임대 요청글 목록");
		}
		
		for(LeaseCall leaseCall : result){
			leaseCall.setChoiceLRCount(
					leaseRequestRepo
					.getCountChoiceLeaseRequests(leaseCall.getLeaseCallNo()));
			
			leaseCall.setStandByLRCount(
					leaseRequestRepo
					.getCountStandByLeaseRequests(leaseCall.getLeaseCallNo()));
			
			//유저 정보 호출 후 신용도 가져오기
			User user = userRepo.getUserCheckId(leaseCall.getUserId());
			leaseCall.setTempGrade(user.getCreditGrade());
			
			StringTokenizer st = null;
			String temp = null;
			
			//임대 분류 문자열 재정렬
			String leaseCategory = leaseCall.getLeaseCategory();
			st = new StringTokenizer(leaseCategory, ",");
			
			int count = 0;
			while(st.hasMoreTokens()){
				if(count==0){
					temp = st.nextToken();
				}else{
					st.nextToken();
				}
				count++;
			}
			
			if(count == 1){
				leaseCall.setLeaseCategory(temp);
			}
			else{
				leaseCall.setLeaseCategory(temp + " 외 " + (count-1) + "종");
			}
			
			//필요 차량 종류 재분류
			String equipmentCategory = leaseCall.getEquipmentCategory();
			st = new StringTokenizer(equipmentCategory, ",");
			count = 0;
			while(st.hasMoreTokens()){
				if(count==0){
					temp = st.nextToken();
				}else{
					st.nextToken();
				}
				count++;
			}
			
			if(count == 1){
				leaseCall.setEquipmentCategory(temp);
			}
			else{
				leaseCall.setEquipmentCategory(temp + " 외 " + (count-1) + "종");
			}		
		}
		
		return result;
	}
	
	@Override
	public List<LeaseCall> loadConstructionUserLeaseCalls(String userId) 
										throws NotFoundDataException {
		
		if(userId == null){
			throw new NotFoundDataException("건설업체 유저 ID정보");
		}
		
		List<LeaseCall> results = leaseCallRepo.getSelectConstructionLeaseCalls(userId);
		
		if(results.size() <= 0){
			throw new NotFoundDataException(userId + "유저의 요청글 정보");
		}
		
		return results;
	}
	
	@Override
	public LeaseCall loadLeaseCall(Integer leaseCallNo) throws NotFoundDataException {
		if(leaseCallNo == null){
			throw new NotFoundDataException("임대 요청글 번호");
		}
		
		LeaseCall result = leaseCallRepo.getLeaseCall(leaseCallNo);
		
		if(result == null){
			throw new NotFoundDataException(leaseCallNo + "번 요청글");
		}
		
		return result;
	}

	@Override
	public LeaseCall viewLeaseCall(Integer leaseCallNo, String userId) throws NotFoundDataException {
		
		if(leaseCallNo == null){
			throw new NotFoundDataException("임대 요청글 번호");
		}
		
		LeaseCall result = leaseCallRepo.getLeaseCall(leaseCallNo);
		
		if(result == null){
			throw new NotFoundDataException(leaseCallNo + "번 임대 요청글 ");
		}
		
		if(userId != null && !result.getUserId().equals(userId)){
			leaseCallRepo.hitsUpLeaseCall(result); //조회수 증가
		}
		
		return result;
	}

	@Override
	public void writeLeaseCall(LeaseCall leaseCall) throws WriteFailException {
		int result = leaseCallRepo.insertLeaseCall(leaseCall);
		if(result != 1){
			throw new WriteFailException("임대 요청글 '" + leaseCall.getLeaseCommentTitle() + "'");
		}		
	}

	@Override
	public void updateLeaseCall(LeaseCall leaseCall) throws ChangeValueFailException {
		int result = leaseCallRepo.updateLeaseCall(leaseCall);
		if(result != 1){
			throw new ChangeValueFailException("임대 요청글 '" + leaseCall.getLeaseCommentTitle() + "'");
		}
		
	}

	@Override
	public void removeLeaseCall(LeaseCall leaseCall) throws RemoveFailException {
		int result = leaseCallRepo.deleteLeaseCall(leaseCall);
		if(result != 1){
			throw new RemoveFailException("임대 요청글 '" + leaseCall.getLeaseCommentTitle() + "'");
		}
	}
	
	
	//------------------------------------------------------------------------------------
	//임대 신청 영역
	
	@Override
	public List<LeaseRequest> loadStandByLeaseRequests(Integer leaseCallNo) 
												throws NotFoundDataException {
		if(leaseCallNo == null){
			throw new NotFoundDataException("대기중인 임대 신청자 목록");
		}
		
		List<LeaseRequest> results = leaseRequestRepo.getAllStandByLeaseRequests(leaseCallNo);
		
		if(results.size() <= 0){
			throw new NotFoundDataException("대기중인 임대 신청자 목록");
		}
		
		return results;
	}
	
	@Override
	public List<LeaseRequest> loadChoiceLeaseRequests(Integer leaseCallNo) 
												throws NotFoundDataException {
		if(leaseCallNo == null){
			throw new NotFoundDataException("선발중인 임대 신청자 목록");
		}
		
		List<LeaseRequest> results = leaseRequestRepo.getAllChoiceLeaseRequests(leaseCallNo);
		
		if(results.size() <= 0){
			throw new NotFoundDataException("선발중인 임대 신청자 목록");
		}
		
		return results;
	}
	
	@Override
	public LeaseRequest loadLeaseRequest(Integer leaseRequestNo, String userId) throws NotFoundDataException {		
		if(leaseRequestNo == null || userId == null){
			throw new NotFoundDataException("임대 신청 번호나 유저ID정보");
		}
		
		LeaseRequest result = leaseRequestRepo.getLeaseRequest(leaseRequestNo, userId);
		
		if(result == null){
			throw new NotFoundDataException("임대 신청 정보");
		}
		
		return result;
	}
	
	@Override
	public void doLeaseRequest(LeaseRequest leaseRequest) throws ServiceFailException {		
		
		if(leaseRequest == null || leaseRequest.getIdNumber() == null){
			throw new ServiceFailException();
		}
		
		//신청글에 등록되어있는 중장비 호출
		HeavyEquipment heavyEquipment = heavyEquipmentRepo.getHeavyEquipment(leaseRequest.getIdNumber());
		
		int result = heavyEquipmentRepo.heavyEquipmentUsedYes(heavyEquipment);
		//임대 신청 실패 시, 자동롤백됨
		result = leaseRequestRepo.insertLeaseRequest(leaseRequest);		
		
		if(result != 1){
			throw new ServiceFailException();
		}
	}
	
	@Override
	public void permissionLeaseRequest(LeaseRequest leaseRequest) throws ChangeValueFailException {
		if(leaseRequest == null){
			throw new ChangeValueFailException("수락 대상 : 임대 신청 데이터");
		}
		
		int result = leaseRequestRepo.choiceLeaseRequest(leaseRequest);
		
		if(result != 1){
			throw new ChangeValueFailException("수락 대상 : 임대 신청 데이터");
		}
		
	}
	
	@Override
	public void rejectionLeaseRequest(LeaseRequest leaseRequest) throws ChangeValueFailException {
		if(leaseRequest == null || leaseRequest.getIdNumber() == null){
			throw new ChangeValueFailException("거절 대상 : 임대 신청 데이터");
		}
		
		//신청글에 등록되어있는 중장비 호출
		HeavyEquipment heavyEquipment = heavyEquipmentRepo.getHeavyEquipment(leaseRequest.getIdNumber());
		
		//사용여부 N으로 만들기
		int result = heavyEquipmentRepo.heavyEquipmentUsedNo(heavyEquipment);
		result = leaseRequestRepo.deleteLeaseRequest(leaseRequest);
		
		if(result != 1){
			throw new ChangeValueFailException("거절 대상 : 임대 신청 데이터");
		}
	}
	
	@Override
	public void cancelLeaseRequest(LeaseRequest leaseRequest) throws ChangeValueFailException {
		if(leaseRequest == null){
			throw new ChangeValueFailException("취소 대상 : 임대 신청 데이터");
		}
		
		//신청글에 등록되어있는 중장비 호출
		HeavyEquipment heavyEquipment = heavyEquipmentRepo.getHeavyEquipment(leaseRequest.getIdNumber());
		
		//사용여부 N으로 만들기
		int result = heavyEquipmentRepo.heavyEquipmentUsedNo(heavyEquipment);
		result = leaseRequestRepo.deleteLeaseRequest(leaseRequest);
		
		if(result != 1){
			throw new ChangeValueFailException("취소 대상 : 임대 신청 데이터");
		}
	}
	
	@Override
	public void autoRejectionLeaseRequest() {
		
		List<LeaseRequest> leaseRequests = leaseRequestRepo.selectCleanRequest();
		
		for(LeaseRequest leaseRequest : leaseRequests){
			HeavyEquipment HE = heavyEquipmentRepo.getHeavyEquipment(leaseRequest.getIdNumber());
			heavyEquipmentRepo.heavyEquipmentUsedNo(HE);
			
			logger.trace("중장비 사용여부 N으로 갱신 : {}", HE);
		}
				
		leaseRequestRepo.cleanLeaseRequest();
	}
	
	//------------------------------------------------------------------------------------
	//임대 직접 요청 영역
	@Override
	public List<LeaseDirectCall> loadPageLeaseDirectCalls(Page page) throws NotFoundDataException {
		
		if(page == null){
			throw new NotFoundDataException("불러 올 직접 요청 목록");
		}
		
		List<LeaseDirectCall> results = leaseDirectCallRepo.getPageSelectHECLeaseDirectCalls(page);
		
		if(results.size() <= 0){
			throw new NotFoundDataException("불러 올 직접 요청 목록");
		}
		
		return results;
	}
	
	@Override
	public LeaseDirectCall loadLeaseDirectCall(Integer leaseDirectNo) throws NotFoundDataException{
		if(leaseDirectNo == null){
			throw new NotFoundDataException("직접 요청 번호");
		}
		
		LeaseDirectCall result = leaseDirectCallRepo.getLeaseDirectCall(leaseDirectNo);
		
		if(result == null){
			throw new NotFoundDataException("임대 직접 요청 게시글");
		}
		
		return result;
	}

	
	@Override
	public void doLeaseDirectCall(LeaseDirectCall leaseDirectCall) throws ServiceFailException {
		
		if(leaseDirectCall == null){
			throw new ServiceFailException();
		}
		int result = leaseDirectCallRepo.insertLeaseDirectCall(leaseDirectCall);
		
		if(result != 1){
			throw new ServiceFailException();
		}
	}
	
	@Override
	public void permissionLeaseDirectCall
		(LeaseDirectCall leaseDirectCall, LeaseRequest leaseRequest) 
			throws ServiceFailException, RemoveFailException, NotFoundDataException {
		if(leaseRequest == null || leaseDirectCall == null){
			throw new NotFoundDataException("임대 직접 요청 추가 작업");
		}
			
		//임대 신청 자동 작성
		int result = leaseRequestRepo.insertLeaseRequest(leaseRequest);
		if(result != 1){
			throw new ServiceFailException();
		}
		
		//즉시 선발
		result = leaseRequestRepo.choiceLeaseRequest(leaseRequest);
		if(result != 1){
			throw new ServiceFailException();
		}
		
		/**
		 * @알림
		 */
		
		//임대 직접신청 자동 삭제
		result = leaseDirectCallRepo.deleteLeaseDirectCall(leaseDirectCall);
		if(result != 1){
			throw new RemoveFailException("수락된 직접요청 정보");
		}
		
		//중장비 사용여부 Y로 변경
		HeavyEquipment heavyEquipment = heavyEquipmentRepo.getHeavyEquipment(leaseRequest.getIdNumber());
		result = heavyEquipmentRepo.heavyEquipmentUsedYes(heavyEquipment);
		if(result != 1){
			throw new ServiceFailException();
		}
		
	}
	
	@Override
	public void rejectionLeaseDirectCall(LeaseDirectCall leaseDirectCall) throws RemoveFailException {
		if(leaseDirectCall == null){
			throw new RemoveFailException("거절된 직접요청 정보");
		}
		
		int result = leaseDirectCallRepo.deleteLeaseDirectCall(leaseDirectCall);
		
		if(result != 1){
			throw new RemoveFailException("거절된 직접요청 정보");
		}
	}
	
	@Override
	public void reflashLeaseDirectCalls() {
		int result = leaseDirectCallRepo.deleteOutBoundDirectCall();
		logger.trace("삭제대상 - 시간이 경과된 직접요청 개수 : {}", result);
	}
	
	//------------------------------------------------------------------------------------
	//임대 양도 영역 
	
	@Override
	public List<LeaseTransfer> loadAcceptLeaseTransfer(Page page) throws NotFoundDataException {
		if(page == null){
			throw new NotFoundDataException("임대 양도 목록을 불러올 페이지");
		}
		
		List<LeaseTransfer> results = leaseTransferRepo.getSelectPageAcceptLeaseTransfers(page);
		if(results.size() <= 0){
			throw new NotFoundDataException("요청 받은 임대 양도 목록");
		}
		
		return results;
	}
	
	@Override
	public String loadHeavyEquipmentUsingAddress(String idNumber) throws NotFoundDataException {
		if(idNumber == null){
			throw new NotFoundDataException("주소를 확인 할 차량번호");
		}
		
		Integer leaseCallNo = leaseRequestRepo.getSearchIdNumberLeaseRequest(idNumber);
		
		if(leaseCallNo == null){
			throw new NotFoundDataException("사용중인 차량의 임대요청 정보");
		}
		
		LeaseCall leaseCall = leaseCallRepo.getLeaseCall(leaseCallNo);
		
		return leaseCall.getAddress();
	}
	
	@Override
	public LeaseTransfer viewLeaseTransfer(Integer leaseTransferNo, String acceptUserId) throws NotFoundDataException {
		if(leaseTransferNo == null || acceptUserId == null){
			throw new NotFoundDataException("임대 양도 정보");
		}
		LeaseTransfer result = leaseTransferRepo.getSelectAcceptLeaseTransfer(leaseTransferNo, acceptUserId);
		
		if(result == null){
			throw new NotFoundDataException("임대 양도 정보");
		}
		return result;
	}
	
	@Override
	public void doLeaseTransfer(LeaseTransfer leaseTransfer) 
												throws ServiceFailException {
		if(leaseTransfer == null){
			throw new ServiceFailException();
		}
		
		int result = leaseTransferRepo.insertLeaseTransfer(leaseTransfer);
		
		if(result != 1){
			throw new ServiceFailException();
		}		
	}
	
	@Override
	public void permissionLeaseTransfer(LeaseTransfer leaseTransfer) 
												throws ChangeValueFailException, ServiceFailException{
		if(leaseTransfer == null){
			throw new ChangeValueFailException("임대 양도 수락");
		}
		
		logger.trace("퍼미션 양도 : {}", leaseTransfer);
		
		//임대 업무를 받는 
		HeavyEquipment acceptCar = heavyEquipmentRepo.getHeavyEquipment
								(leaseTransfer.getAcceptIdNumber());
		//임대 업무를 주는
		HeavyEquipment sendCar = heavyEquipmentRepo.getHeavyEquipment
								(leaseTransfer.getSendIdNumber());
		
		if(acceptCar == null || sendCar == null){
			leaseTransferRepo.deleteLeaseTransfer(leaseTransfer);
			throw new ServiceFailException();
		}
		
		//업무를 주는 중장비 사용여부 N으로 바꾸기
		heavyEquipmentRepo.heavyEquipmentUsedNo(sendCar);
		
		//업무를 받는 중장비 사용여부 Y로 바꾸기
		heavyEquipmentRepo.heavyEquipmentUsedYes(acceptCar);
		
		int result = leaseTransferRepo.permissionUpdateLeaseTransfer(leaseTransfer);
		if(result != 1){
			throw new ChangeValueFailException("임대 양도 수락");
		}
		
	}
	
	@Override
	public void rejectionLeaseTransfer(LeaseTransfer leaseTransfer) throws RemoveFailException{
		if(leaseTransfer == null){
			throw new RemoveFailException("임대 양도 거절");
		}
		
		int result = leaseTransferRepo.deleteLeaseTransfer(leaseTransfer);
		if(result != 1){
			throw new RemoveFailException("임대 양도 거절");
		}
	}
	
	@Override
	public void cancelLeaseTransfer(LeaseTransfer leaseTransfer) throws RemoveFailException {
		if(leaseTransfer == null){
			throw new RemoveFailException("임대 양도 거절");
		}
		
		int result = leaseTransferRepo.deleteLeaseTransfer(leaseTransfer);
		if(result != 1){
			throw new RemoveFailException("임대 양도 거절");
		}
	}
	
	//------------------------------------------------------------------------------------
	//중기업체 조회 영역
	@Override
	public List<HeavyEquipmentCompany> lookUpHeavyEquipmentCompanies(User user, Page page) 
											throws NotFoundDataException{
		
		List<HeavyEquipmentCompany> results = null;
		
		if(user != null && user instanceof HeavyEquipmentCompany){			
			results = lookUpHeavyEquipmentRepo.getPageHelpOnHeavyEquipmentCompanies(page);
			
		}else if(user != null && user instanceof ConstructionCompany){
			results = lookUpHeavyEquipmentRepo.getPageInfoOnHeavyEquipmentCompanies(page);
		}
		else{
			results = lookUpHeavyEquipmentRepo.getPageAllHeavyEquipmentCompanies(page);
		}
		
		if(results.size() <= 0){
			throw new NotFoundDataException("중기업체 조회 정보");
		}
		
		for(HeavyEquipmentCompany item : results){
			item.setHeavyEquipmentList(
					lookUpHeavyEquipmentRepo.
					getCompanyHeavyEquipments(item.getUserId()));
		}
		
		return results;
	}
	
	
	@Override
	public HeavyEquipmentCompany viewHeavyEquipment(String equipmentId) {
		HeavyEquipmentCompany result =
				lookUpHeavyEquipmentRepo.
						getHeavyEquipmentCompany(equipmentId);
		
		List<HeavyEquipment> HEList =
					lookUpHeavyEquipmentRepo.getCompanyHeavyEquipments(equipmentId);
		
		//중장비 리스트 가져오기
		result.setHeavyEquipmentList(HEList);
		
		return result;
	}
	
	//------------------------------------------------------------------------------------
	//페이지 리턴 메소드 영역
	@Override
	public Page getMoreViewSearchPage
		(Integer currentPage, Integer pageSize,	String search, String keyword) {
		
		Page page;
		
		if(search!=null && keyword != null){
			page = new Page(search, keyword);
		}else{
			page = new Page();
		}
		
		page.setCurrentPage(currentPage);
		page.setPageSize(pageSize);
		page.setFromTo();
		page.setTotalCount(leaseCallRepo.getCountSearchLeaseCalls(page));
		
		return page;
	}
	
	@Override
	public Page getMoreViewHECPage(Integer currentPage, Integer pageSize,	
			String search, String keyword, String isCompany, String userId) {
		Page page;
		
		if(search!=null && keyword != null){
			page = new Page(search, keyword);
		}else{
			page = new Page();
		}
		
		page.setCurrentPage(currentPage);
		page.setPageSize(pageSize);
		page.setFromTo();
		
		if(isCompany!=null && isCompany.equals("CC")){
			page.setTotalCount(lookUpHeavyEquipmentRepo.getCountInfoOnHeavyEquipmentCompanies());
		}else if(isCompany!=null && isCompany.equals("HEC")){
			page.setTotalCount(lookUpHeavyEquipmentRepo.getCountHelpOnHeavyEquipmentCompanies());
		}else{
			page.setTotalCount(lookUpHeavyEquipmentRepo.getCountAllHeavyEquipmentCompanies());
		}
		page.setUserId(userId);
		
		return page;
	}
	
	@Override
	public Page getDirectCallPage(Integer currentPage, Integer pageSize, String userId) {
		Page page = new Page();
		page.setTotalCount(leaseDirectCallRepo.getCountSelectHECLeaseDirectCalls(userId));
		page.setCurrentPage(currentPage);
		page.setPageSize(pageSize);
		page.setTotalPage((page.getTotalCount()-1)/page.getPageSize()+1);
		page.setUserId(userId);
		page.setFromTo();
		
		return page;
	}
	
	@Override
	public Page getTransferPage(Integer currentPage, Integer pageSize, String userId) {
		Page page = new Page();
		page.setTotalCount(leaseTransferRepo.getCountSelectAllAcceptLeaseTransfers(userId));
		page.setPageSize(pageSize);
		page.setTotalPage((page.getTotalCount()-1)/page.getPageSize()+1);
		page.setCurrentPage(currentPage);
		page.setUserId(userId);
		page.setFromTo();
		return page;
	}

	@Override
	public List<LeaseCall> loadAllLeaseCalls() throws NotFoundDataException {
		List<LeaseCall> leaseCall = leaseCallRepo.getAllLeaseCalls();
		return leaseCall;
	}

	//-----------------------------------------------------------------------------------
	
	
}

