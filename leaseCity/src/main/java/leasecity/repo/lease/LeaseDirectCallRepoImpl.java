package leasecity.repo.lease;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.etc.Page;
import leasecity.dto.lease.LeaseDirectCall;

@Repository
public class LeaseDirectCallRepoImpl implements LeaseDirectCallRepo{

	// Sql쿼리를 작동시키는 SessionTemplate Bean
	@Autowired
	SqlSessionTemplate session;

	// mapper연동용 문자열 코드 - 임대 신청
	private final String LEASE_DIRECT_CALL_NS = "leasecity.repo.leaseDirectCallRepo.";

	
	@Override
	public Integer getCountSelectHECLeaseDirectCalls(String equipmentId) {
		String stmt = LEASE_DIRECT_CALL_NS + "getCountSelectHECLeaseDirectCalls";
		return session.selectOne(stmt, equipmentId);
	}
	
	@Override
	public List<LeaseDirectCall> getPageSelectHECLeaseDirectCalls(Page page) {
		String stmt = LEASE_DIRECT_CALL_NS + "getPageSelectHECLeaseDirectCalls";
		return session.selectList(stmt, page);
	}

	@Override
	public LeaseDirectCall getLeaseDirectCall(Integer leaseDirectNo) {
		String stmt = LEASE_DIRECT_CALL_NS + "getLeaseDirectCall";
		return session.selectOne(stmt, leaseDirectNo);
	}

	@Override
	public int insertLeaseDirectCall(LeaseDirectCall leaseDirectCall) {
		String stmt = LEASE_DIRECT_CALL_NS + "insertLeaseDirectCall";
		return session.insert(stmt, leaseDirectCall);
	}

	@Override
	public int deleteLeaseDirectCall(LeaseDirectCall leaseDirectCall) {
		String stmt = LEASE_DIRECT_CALL_NS + "deleteLeaseDirectCall";
		return session.delete(stmt, leaseDirectCall);
	}
	
	@Override
	public int deleteOutBoundDirectCall() {
		String stmt = LEASE_DIRECT_CALL_NS +"deleteOutBoundDirectCall";
		return session.delete(stmt);
	}

}
