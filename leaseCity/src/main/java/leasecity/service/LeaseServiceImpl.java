package leasecity.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import leasecity.dto.etc.Page;
import leasecity.dto.lease.LeaseCall;
import leasecity.dto.lease.LeaseRequest;
import leasecity.exception.ChangeValueFailException;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.RemoveFailException;
import leasecity.exception.WriteFailException;
import leasecity.repo.lease.LeaseCallRepo;
import leasecity.repo.lease.LeaseRequestRepo;

@Service
public class LeaseServiceImpl implements LeaseService {

	@Autowired
	LeaseCallRepo leaseCallRepo;
	
	@Autowired
	LeaseRequestRepo leaseRequestRepo;
	
	
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
		}
		
		return result;
	}

	@Override
	public LeaseCall viewLeaseCall(Integer leaseCallNo) throws NotFoundDataException {
		
		if(leaseCallNo == null){
			throw new NotFoundDataException("임대 요청글");
		}
		
		LeaseCall result = leaseCallRepo.getLeaseCall(leaseCallNo);
		
		if(result == null){
			throw new NotFoundDataException(leaseCallNo + "번 임대 요청글 ");
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
	
	
	//------------------------------------------------------------------------------------
	
	//페이지 리턴 메소드 영역
	@Override
	public Page getSearchCommentPage
		(Integer currentPage, Integer pageSize, String search, String keyword) {
		Page page = new Page(search, keyword);
		page.setCurrentPage(currentPage);
		page.setPageSize(pageSize);
		page.setFromTo();
		return page;
	}
	
	//------------------------------------------------------------------------------------
	
	
}

