package leasecity.repo.user;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.user.HeavyEquipmentCompany;

@Repository
public class HeavyEquipmentCompanyRepoImpl implements HeavyEquipmentCompanyRepo {

	
	@Autowired
	SqlSessionTemplate session;

	private final String HEC_NS = "leasecity.repo.heavyEquipmentCompanyRepo.";
	
	@Override
	public List<HeavyEquipmentCompany> 
			getAllHeavyEquipmentCompanys() {
		String stmt = HEC_NS+"getAllSelectHECs";
		return session.selectList(stmt);
	}

	@Override
	public HeavyEquipmentCompany 
		getHeavyEquipmentCompany(String userId) {
		String stmt = HEC_NS+"getSelectHEC";
		return session.selectOne(stmt, userId);
	}

	@Override
	public int 
		insertHeavyEquipmentCompany(HeavyEquipmentCompany HEC) {
		String stmt = HEC_NS + "insertHEC";
		return session.insert(stmt, HEC);
	}
	
	@Override
	public int deleteHeavyEquipmentCompany(HeavyEquipmentCompany HEC) {
		String stmt = HEC_NS + "deleteHEC";
		return session.delete(stmt, HEC);
	}
	
}
