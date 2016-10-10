package leasecity.repo.adminwork;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.adminwork.StandByUser;

@Repository
public class StandByUserRepoImpl implements StandByUserRepo {

	// mapper연동용 문자열 코드 - 건설업체
	private final String SBU_NS = "leasecity.repo.standByUserRepo.";

	// Sql쿼리를 작동시키는 SessionTemplate Bean
	@Autowired
	SqlSessionTemplate session;
	
	// 모든 대기유저 검색
	@Override
	public List<StandByUser> getAllStandByUser() {
		String stmt = SBU_NS + "getAllSelectStandByUsers";
		return null;
	}

	// 대기유저 검색
	@Override
	public StandByUser getStandByUser(
			String companyName, 
			String representName, 
			String email) {
		String stmt = SBU_NS + "getSelectStandByUser";
		Map<String, String> map = new HashMap<>();
		
		map.put("companyName", companyName);
		map.put("representName", representName);
		map.put("email", email);
		
		return session.selectOne(stmt, map);
	}
	
	// 발급코드가 존재하는 대기유저 검색
	@Override
	public StandByUser getAgreeStandByUser(String permissionNo) {
		String stmt = SBU_NS + "getSelectAgreeStandByUser";
		return session.selectOne(stmt, permissionNo);
	}

	// 대기유저 추가
	@Override
	public int insertStandByUser(StandByUser standByUser) {
		String stmt = SBU_NS + "insertStandByUser";
		return session.insert(stmt, standByUser);
	}

	// 대기유저 수정 - 발급코드 부여
	@Override
	public int updateStandByUser(StandByUser standByUser) {
		String stmt = SBU_NS + "updateStandByUser";
		return session.update(stmt, standByUser);
	}

	// 대기 유저 삭제 - 거절
	@Override
	public int deleteStandByUser(StandByUser standByUser) {
		String stmt = SBU_NS + "deleteStandByUser";
		return session.delete(stmt, standByUser);
	}
	
	// 대기유저 삭제 - 요청한지 30일 경과된 유저대상
	@Override
	public int deleteStandByUserRequest() {
		String stmt = SBU_NS + "deleteStandByUserRequest";
		return session.delete(stmt);
	}
	
	// 대기유저 삭제 - 발급코드 받은지 3일 경과된 유저대상
	@Override
	public int deleteStandByUserRegistry() {
		String stmt = SBU_NS + "deleteStandByUserRegistry";
		return session.delete(stmt);
	}

}
