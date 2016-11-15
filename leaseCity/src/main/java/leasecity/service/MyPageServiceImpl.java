package leasecity.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import leasecity.dto.adminwork.WorkLog;
import leasecity.dto.etc.Page;
import leasecity.dto.lease.LeaseCall;
import leasecity.dto.lease.LeaseRequest;
import leasecity.dto.lease.LeaseTransfer;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.WriteFailException;
import leasecity.repo.adminwork.WorkLogRepo;
import leasecity.repo.lease.LeaseCallRepo;
import leasecity.repo.lease.LeaseRequestRepo;
import leasecity.util.DateUtil;

@Service
public class MyPageServiceImpl implements MyPageService {

	@Autowired
	WorkLogRepo workLogRepo;
	
	@Autowired
	LeaseCallRepo leaseCallRepo;
	
	@Autowired
	LeaseRequestRepo leaseRequestRepo;
	
	
	
	@Override
	public List<WorkLog> loadPageLeaseRequestAndCallCCWorkLog(Page page) throws NotFoundDataException {
		List<WorkLog> result = workLogRepo.getPageLeaseRequestAndCallCCWorkLog(page);
		String[] categoryArr = null;
		Long todayTime = DateUtil.getToday().getTime(); // 오늘 날짜
		
		if(result.size() <= 0){
			throw new NotFoundDataException("임대 신청 기록");
		}
		
		for(WorkLog workLog : result){
			Long fromDate = workLog.getFromDate().getTime();
			Long toDate = workLog.getToDate().getTime();
			
			LeaseRequest leaseRequest = leaseRequestRepo.getSimpleLeaseRequest(workLog.getLeaseRequestNo());
			
			if(leaseRequest == null){
				workLog.setStatus("CANCELED"); // 작업 대기
			}else if(todayTime < fromDate){
				workLog.setStatus("STAND_BY"); // 작업 대기
			}else if(todayTime >= fromDate && todayTime <= toDate){
				workLog.setStatus("WORKING"); // 작업중
			}else if(workLog.getEvaluationCheck().equals("Y")){
				workLog.setStatus("EVALUATED"); // 평가된상태
			}else if(todayTime > toDate){
				workLog.setStatus("COMPLETE"); // 작업완료
			}

		}
		
		return result;
	}
	
	@Override
	public List<WorkLog> loadPageLeaseRequestAndCallHECWorkLog(Page page) throws NotFoundDataException {
		List<WorkLog> result = workLogRepo.getPageLeaseRequestAndCallHECWorkLog(page);
		
		if(result.size() <= 0){
			throw new NotFoundDataException("임대 신청 기록");
		}
		
		for(WorkLog workLog : result){
			
		}
		
		return result;
	}
	
	@Override
	public List<WorkLog> loadPageLeaseTransferWorkLog(Page page) throws NotFoundDataException {
		List<WorkLog> result = workLogRepo.getPageLeaseTransferWorkLog(page);
		
		if(result.size() <= 0){
			throw new NotFoundDataException("임대 양도 기록");
		}
		
		return result;
	}
	
	@Override
	public List<WorkLog> loadPageLeaseCallWorkLog(Page page) throws NotFoundDataException {
		List<WorkLog> result = workLogRepo.getPageLeaseCallWorkLog(page);
		String[] categoryArr = null;
		
		Long todayTime = DateUtil.getToday().getTime();
		
		for(WorkLog workLog : result){
			Long fromDate = workLog.getFromDate().getTime();
			Long toDate = workLog.getToDate().getTime();
			
			LeaseCall leaseCall = leaseCallRepo.getLeaseCall(workLog.getLeaseCallNo());
			
			if(leaseCall == null){
				workLog.setStatus("CANCELED"); // 작업 대기
			}else if(todayTime < fromDate){
				workLog.setStatus("STAND_BY"); // 작업 대기
			}else if(todayTime >= fromDate && todayTime <= toDate){
				workLog.setStatus("WORKING"); // 작업중
			}else if(workLog.getEvaluationCheck().equals("Y")){
				workLog.setStatus("EVALUATED"); // 평가된상태
			}else if(todayTime > toDate){
				workLog.setStatus("COMPLETE"); // 작업완료
			}
			
			
			categoryArr = workLog.getEquipmentCategory().split(",");
			String equipmentCategory = null;
			if(categoryArr.length > 1){
				equipmentCategory = categoryArr[0] + " 외 " + (categoryArr.length-1) + "종";
			}else{
				equipmentCategory = categoryArr[0];
			}
			
			categoryArr = workLog.getLeaseCategory().split(",");
			String leaseCategory = null;
			if(categoryArr.length > 1){
				leaseCategory = categoryArr[0] + " 외 " + (categoryArr.length-1) + "종";
			}else{
				leaseCategory = categoryArr[0];
			}
			
			workLog.setEquipmentCategory(equipmentCategory);
			workLog.setLeaseCategory(leaseCategory);
			
		}
		
		if(result.size() <= 0){
			throw new NotFoundDataException("임대 요청 기록");
		}
		
		return result;
	}
	
	
	//----페이지 리턴 메서드--------------------------------------------------------

	@Override
	public Page getRequestAndCallLogPage(Integer currentPage, Integer pageSize, String userId) {
		Page page = new Page();
		page.setTotalCount(workLogRepo.getCountLeaseRequestAndCallWorkLog(userId));
		page.setCurrentPage(currentPage);
		page.setPageSize(pageSize);
		page.setTotalPage((page.getTotalCount()-1)/page.getPageSize()+1);
		page.setUserId(userId);
		page.setFromTo();
		
		return page;
	}
	
	@Override
	public Page getTransferLogPage(Integer currentPage, Integer pageSize, String userId) {
		Page page = new Page();
		page.setTotalCount(workLogRepo.getCountLeaseTransferWorkLog(userId));
		page.setCurrentPage(currentPage);
		page.setPageSize(pageSize);
		page.setTotalPage((page.getTotalCount()-1)/page.getPageSize()+1);
		page.setUserId(userId);
		page.setFromTo();
		return page;
	}
	
	@Override
	public Page getCallLogPage(Integer currentPage, Integer pageSize, String userId) {
		Page page = new Page();
		page.setTotalCount(workLogRepo.getCountLeaseCallWorkLog(userId));
		page.setCurrentPage(currentPage);
		page.setPageSize(pageSize);
		page.setTotalPage((page.getTotalCount()-1)/page.getPageSize()+1);
		page.setUserId(userId);
		page.setFromTo();
		return page;
	}

	
	//----쓰기 메서드--------------------------------------------------------
	
	
	
	@Override
	public void writeRequestWorkLog(LeaseRequest leaseRequest, String userId) throws WriteFailException{
		if(leaseRequest == null){throw new WriteFailException("임대 요청/신청 기록");}
		
		//작업기록 생성
		WorkLog workLog = new WorkLog();
		workLog.setFromDate(leaseRequest.getFromDate());
		workLog.setToDate(leaseRequest.getToDate());
		workLog.setLeaseRequestNo(leaseRequest.getLeaseRequestNo());
		workLog.setLeaseCallNo(leaseRequest.getLeaseCallNo());
		
		workLog.setUserId(leaseRequest.getUserId());
		int result = workLogRepo.insertWorkLog(workLog);
		if(result != 1){
			throw new WriteFailException("임대 요청/신청 기록");
		}
		
		workLog.setUserId(userId);
		result = workLogRepo.insertWorkLog(workLog);
		if(result != 1){
			throw new WriteFailException("임대 요청/신청 기록");
		}
		
		System.out.println("임대 요청 기록 작성 완료 : " + workLog);
		
	}	
	
	@Override
	public void writeTransferWorkLog(LeaseTransfer leaseTransfer) throws WriteFailException{
		if(leaseTransfer == null){throw new WriteFailException("임대 신청 기록");}
		
		//작업기록 생성
		WorkLog workLog = new WorkLog();
		workLog.setFromDate(leaseTransfer.getFromDate());
		workLog.setToDate(leaseTransfer.getToDate());
		workLog.setLeaseTransferNo(leaseTransfer.getLeaseTransferNo());
		workLog.setUserId(leaseTransfer.getAcceptUserId());

		//임대양도 받는 상대에 대한 
		int result = workLogRepo.insertWorkLog(workLog);
		
		if(result != 1){
			throw new WriteFailException("임대 신청 기록");
		}
		
		workLog.setUserId(leaseTransfer.getSendUserId());
		result = workLogRepo.insertWorkLog(workLog);
		
		if(result != 1){
			throw new WriteFailException("임대 신청 기록");
		}
	}
	
	@Override
	public void writeCallWorkLog(LeaseCall leaseCall) throws WriteFailException {
		if(leaseCall == null){throw new WriteFailException("임대 신청 기록");}
		
		//작업기록 생성
		WorkLog workLog = new WorkLog();
		workLog.setFromDate(leaseCall.getFromDate());
		workLog.setToDate(leaseCall.getToDate());
		workLog.setLeaseCallNo(leaseCall.getLeaseCallNo());
		workLog.setUserId(leaseCall.getUserId());
		
		int result = workLogRepo.insertWorkLog(workLog);
		
		if(result != 1){
			throw new WriteFailException("임대 신청 기록");
		}
		
	}
	

}
