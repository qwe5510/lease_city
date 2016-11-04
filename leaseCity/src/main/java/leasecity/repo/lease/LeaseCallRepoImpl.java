package leasecity.repo.lease;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.etc.Page;
import leasecity.dto.lease.LeaseCall;

@Repository
public class LeaseCallRepoImpl implements LeaseCallRepo {

	// Sql쿼리를 작동시키는 SessionTemplate Bean
	@Autowired
	SqlSessionTemplate session;

	// mapper연동용 문자열 코드 - 임대 요청
	private final String LEASE_CALL_NS = "leasecity.repo.leaseCallRepo.";
	
	@Override
	public Integer getCountAllLeaseCalls() {
		String stmt = LEASE_CALL_NS + "getCountAllLeaseCalls";
		return session.selectOne(stmt);
	}

	@Override
	public Integer getCountSearchLeaseCalls(Page page) {
		String stmt = LEASE_CALL_NS + "getCountSearchLeaseCalls";
		return session.selectOne(stmt, page);
	}

	@Override
	public List<LeaseCall> getPageLeaseCalls(Page page) {
		String stmt = LEASE_CALL_NS + "getPageLeaseCalls";
		return session.selectList(stmt, page);
	}

	@Override
	public LeaseCall getLeaseCall(Integer leaseCallNo) {
		String stmt = LEASE_CALL_NS + "getLeaseCall";
		return session.selectOne(stmt, leaseCallNo);
	}

	@Override
	public LeaseCall getUserLeaseCall(LeaseCall leaseCall) {
		String stmt = LEASE_CALL_NS + "getUserLeaseCall";
		return session.selectOne(stmt, leaseCall);
	}

	@Override
	public int insertLeaseCall(LeaseCall leaseCall) {
		String stmt = LEASE_CALL_NS + "insertLeaseCall";
		return session.insert(stmt, leaseCall);
	}

	@Override
	public int deleteLeaseCall(LeaseCall leaseCall) {
		String stmt = LEASE_CALL_NS + "deleteLeaseCall";
		return session.delete(stmt, leaseCall);
	}

	@Override
	public int updateLeaseCall(LeaseCall leaseCall) {
		String stmt = LEASE_CALL_NS + "updateLeaseCall";
		return session.update(stmt, leaseCall);
	}

	@Override
	public int hitsUpLeaseCall(LeaseCall leaseCall) {
		String stmt = LEASE_CALL_NS + "hitsUpLeaseCall";
		leaseCall.setHits(leaseCall.getHits()+1);
		return session.update(stmt, leaseCall);
	}

	@Override
	public List<LeaseCall> getAllLeaseCalls() {
		String stmt = LEASE_CALL_NS + "getAllLeaseCalls";
		return session.selectList(stmt);
	}

}
