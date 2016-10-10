package leasecity.repo.adminwork;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.adminwork.LeasecityAdmin;

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
		map.put("adminId", adminId);
		map.put("adminPass", adminPass);
		
		return session.selectOne(stmt, map);
	}

	@Override
	public int updateLeasecityAdmin(LeasecityAdmin leasecityAdmin) {
		String stmt = ADMIN_NS + "updateLeasecityAdmin";
		return 0;
	}
	
	
}
