package leasecity.repo.user;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.user.HeavyEquipment;

@Repository
public class HeavyEquipmentRepoImpl implements HeavyEquipmentRepo{

	//mapper연동용 문자열 코드 - 중장비
	private final String HE_NS = "leasecity.repo.heavyEquipmentRepo.";
	
	//Sql쿼리를 작동시키는 SessionTemplate Bean
	@Autowired
	SqlSessionTemplate session;
	
	//중장비 전체 리스트 조회
	@Override
	public List<HeavyEquipment> getAllHeavyEquipments() {
		String stmt = HE_NS + "getAllSelectHEs";
		return session.selectList(stmt);
	}

	//중장비 유저별 리스트 조회
	@Override
	public List<HeavyEquipment> getUserHeavyEquipments(String userId) {
		String stmt = HE_NS + "getSelectUserHE";
		return session.selectList(stmt, userId);
	}

	// 중장비  차번으로 검색
	@Override
	public HeavyEquipment getHeavyEquipment(String idNumber) {
		String stmt = HE_NS + "getSelectHE";
		return session.selectOne(stmt, idNumber);
	}

	// 중장비 추가
	@Override
	public int insertHeavyEquipment(HeavyEquipment HE) {
		String stmt = HE_NS + "insertHE";
		return session.insert(stmt, HE);
	}

	// 중장비 정보 수정
	@Override
	public int updateHeavyEquipment(HeavyEquipment HE) {
		String stmt = HE_NS + "updateHE";
		return session.update(stmt, HE);
	}
	
	// 중장비 삭제
	@Override
	public int deleteHeavyEquipment(HeavyEquipment HE) {
		String stmt = HE_NS + "deleteHE";
		return session.delete(stmt, HE);
	}
	
	
}
