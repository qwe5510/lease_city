package leasecity.repo.user;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.user.HeavyEquipmentCompany;

@Repository
public class HeavyEquipmentCompanyRepoImpl implements HeavyEquipmentCompanyRepo {

	//mapper연동용 문자열 코드 - 중기업체
	private final String HEC_NS = "leasecity.repo.heavyEquipmentCompanyRepo.";
	
	//Sql쿼리를 작동시키는 SessionTemplate Bean
	@Autowired
	SqlSessionTemplate session;


	//모든 중기업체 검색
	@Override
	public List<HeavyEquipmentCompany> 
			getAllHeavyEquipmentCompanys() {
		String stmt = HEC_NS+"getAllSelectHECs";
		return session.selectList(stmt);
	}

	
	//중기업체 검색
	@Override
	public HeavyEquipmentCompany 
		getHeavyEquipmentCompany(String userId) {
		String stmt = HEC_NS+"getSelectHEC";
		return session.selectOne(stmt, userId);
	}
	
	@Override
	public HeavyEquipmentCompany 
		getHECUser(String userId) {
		String stmt = HEC_NS + "getSelectHECAndUser";
		return session.selectOne(stmt, userId);
	}
	
	//중기업체 추가
	@Override
	public int 
		insertHeavyEquipmentCompany(HeavyEquipmentCompany HEC) {
		String stmt = HEC_NS + "insertHEC";
		return session.insert(stmt, HEC);
	}
	
}
