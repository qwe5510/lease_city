package leasecity.repo.lease;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.etc.Page;
import leasecity.dto.lease.LeaseTransfer;

@Repository
public class LeaseTransferRepoImpl implements LeaseTransferRepo{

	// Sql쿼리를 작동시키는 SessionTemplate Bean
	@Autowired
	SqlSessionTemplate session;

	// mapper연동용 문자열 코드 - 임대 요청
	private final String LEASE_TRANSFER_NS = "leasecity.repo.leaseTransferRepo.";
	
	@Override
	public Integer getCountSelectAllAcceptLeaseTransfers(String acceptUserId) {
		String stmt = LEASE_TRANSFER_NS + "getCountSelectAllAcceptLeaseTransfers";
		return session.selectOne(stmt, acceptUserId);
	}

	@Override
	public List<LeaseTransfer> getSelectPageAcceptLeaseTransfers(Page page) {
		String stmt = LEASE_TRANSFER_NS + "getSelectPageAcceptLeaseTransfers";
		return session.selectList(stmt, page);
	}
	
	@Override
	public LeaseTransfer getSelectAcceptLeaseTransfer(Integer leaseTransferNo, String acceptUserId) {
		String stmt = LEASE_TRANSFER_NS +"getSelectAcceptLeaseTransfer";
		Map<String, Object> map = new HashMap<>();
		map.put("leaseTransferNo", leaseTransferNo);
		map.put("acceptUserId", acceptUserId);
		return session.selectOne(stmt, map);
	}

	@Override
	public Integer getCountSelectAllSendLeaseTransfers(String sendUserId) {
		String stmt = LEASE_TRANSFER_NS + "getCountSelectAllSendLeaseTransfers";
		return session.selectOne(stmt, sendUserId);
	}

	@Override
	public List<LeaseTransfer> getSelectPageSendLeaseTransfers(Page page) {
		String stmt = LEASE_TRANSFER_NS + "getSelectPageSendLeaseTransfers";
		return session.selectOne(stmt, page);
	}

	@Override
	public int insertLeaseTransfer(LeaseTransfer leaseTransfer) {
		String stmt = LEASE_TRANSFER_NS + "insertLeaseTransfer";
		return session.insert(stmt, leaseTransfer);
	}

	@Override
	public int deleteLeaseTransfer(LeaseTransfer leaseTransfer) {
		String stmt = LEASE_TRANSFER_NS + "deleteLeaseTransfer";
		return session.delete(stmt, leaseTransfer);
	}

	@Override
	public int permissionUpdateLeaseTransfer(LeaseTransfer leaseTransfer) {
		String stmt = LEASE_TRANSFER_NS + "permissionUpdateLeaseTransfer";
		return session.update(stmt, leaseTransfer);
	}

	@Override
	public LeaseTransfer getSelectLeaseTransfer(Integer leaseTransferNo) {
		String stmt = LEASE_TRANSFER_NS + "getSelectLeaseTransfer";
		return session.selectOne(stmt, leaseTransferNo);
	}

}
