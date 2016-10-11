package leasecity.repo.adminwork;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.adminwork.LeasecityAdmin;
import leasecity.util.HashingUtil;

@Repository
public class LeasecityAdminRepoImpl implements LeasecityAdminRepo{

	// mapper연동용 문자열 코드 - 건설업체
	private final String ADMIN_NS = "leasecity.repo.leasecityAdminRepo.";
	
	// Sql쿼리를 작동시키는 SessionTemplate Bean
	@Autowired
	SqlSessionTemplate session;
	
	@Override
	public LeasecityAdmin getLeasecityAdmin
				(String adminId, String adminPass) {
		String stmt = ADMIN_NS + "getSelectLeasecityAdmin";
		Map<String, String> map = new HashMap<>();
		
		//입력한 비밀번호 해싱
		String hashPass = HashingUtil.hashingString(adminPass);
		map.put("adminId", adminId);
		map.put("adminPass", hashPass);
		
		return session.selectOne(stmt, map);
	}

	@Override
	public int updateLeasecityAdmin(LeasecityAdmin leasecityAdmin) {
		String stmt = ADMIN_NS + "updateLeasecityAdmin";
		
		//비밀번호 해싱
		String hashPass = HashingUtil.hashingString(leasecityAdmin.getAdminPass());
		leasecityAdmin.setAdminPass(hashPass);
		
		return session.update(stmt, leasecityAdmin);
	}
	
	
}
