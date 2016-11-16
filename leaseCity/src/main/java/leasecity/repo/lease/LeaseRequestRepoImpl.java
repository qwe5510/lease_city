package leasecity.repo.lease;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.lease.LeaseRequest;

@Repository
public class LeaseRequestRepoImpl implements LeaseRequestRepo{

	// Sql쿼리를 작동시키는 SessionTemplate Bean
	@Autowired
	SqlSessionTemplate session;

	// mapper연동용 문자열 코드 - 임대 신청
	private final String LEASE_REQUEST_NS = "leasecity.repo.leaseRequestRepo.";

	
	@Override
	public Integer getCountStandByLeaseRequests(Integer leaseCallNo) {
		String stmt = LEASE_REQUEST_NS + "getCountStandByLeaseRequests";
		return session.selectOne(stmt, leaseCallNo);
	}
	
	@Override
	public Integer getCountChoiceLeaseRequests(Integer leaseCallNo) {
		String stmt = LEASE_REQUEST_NS + "getCountChoiceLeaseRequests";
		return session.selectOne(stmt, leaseCallNo);
	}
	
	@Override
	public Integer getSearchIdNumberLeaseRequest(String idNumber) {
		String stmt = LEASE_REQUEST_NS +"getSearchIdNumberLeaseRequest";
		return session.selectOne(stmt, idNumber);
	}
	
	
	@Override
	public List<LeaseRequest> getAllStandByLeaseRequests(Integer leaseCallNo) {
		String stmt = LEASE_REQUEST_NS + "getAllStandByLeaseRequests";
		return session.selectList(stmt, leaseCallNo);
	}

	@Override
	public List<LeaseRequest> getAllChoiceLeaseRequests(Integer leaseCallNo) {
		String stmt = LEASE_REQUEST_NS + "getAllChoiceLeaseRequests";
		return session.selectList(stmt, leaseCallNo);
	}
	
	@Override
	public LeaseRequest getLeaseRequest(Integer leaseRequestNo, String userId) {
		String stmt = LEASE_REQUEST_NS + "getLeaseRequest";
		Map<String, Object> map = new HashMap<>();
		map.put("leaseRequestNo", leaseRequestNo);
		map.put("userId", userId);
		return session.selectOne(stmt, map);
	}
	
	@Override
	public LeaseRequest getSimpleLeaseRequest(Integer leaseRequestNo) {
		String stmt = LEASE_REQUEST_NS +"getSimpleLeaseRequest";
		return session.selectOne(stmt, leaseRequestNo);
	}

	@Override
	public int insertLeaseRequest(LeaseRequest leaseRequest) {
		String stmt = LEASE_REQUEST_NS + "insertLeaseRequest";
		return session.insert(stmt, leaseRequest);
	}

	@Override
	public int deleteLeaseRequest(LeaseRequest leaseRequest) {
		String stmt = LEASE_REQUEST_NS + "deleteLeaseRequest";
		return session.delete(stmt, leaseRequest);
	}

	@Override
	public int choiceLeaseRequest(LeaseRequest leaseRequest) {
		String stmt = LEASE_REQUEST_NS + "choiceLeaseRequest";
		return session.update(stmt, leaseRequest);
	}
	
	@Override
	public List<LeaseRequest> selectCleanRequest() {
		String stmt = LEASE_REQUEST_NS +"selectCleanRequest";
		return session.selectList(stmt);
	}
	
	@Override
	public int cleanLeaseRequest() {
		String stmt = LEASE_REQUEST_NS +"cleanLeaseRequest";
		return session.delete(stmt);
	}

	
}
