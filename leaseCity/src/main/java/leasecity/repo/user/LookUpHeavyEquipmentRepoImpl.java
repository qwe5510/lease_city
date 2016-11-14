package leasecity.repo.user;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.etc.Page;
import leasecity.dto.user.HeavyEquipment;
import leasecity.dto.user.HeavyEquipmentCompany;

@Repository
public class LookUpHeavyEquipmentRepoImpl implements LookUpHeavyEquipmentRepo{

	// Sql쿼리를 작동시키는 SessionTemplate Bean
	@Autowired
	SqlSessionTemplate session;

	// mapper연동용 문자열 코드 - 임대 요청
	private final String LOOKUP_HEC_NS = "leasecity.repo.LookUpHeavyEquipmentCompanyRepo.";
	
	@Override
	public Integer getCountHelpOnHeavyEquipmentCompanies() {
		String stmt = LOOKUP_HEC_NS +"getCountHelpOnHeavyEquipmentCompanies";
		return session.selectOne(stmt);
	}

	@Override
	public Integer getCountInfoOnHeavyEquipmentCompanies() {
		String stmt = LOOKUP_HEC_NS + "getCountInfoOnHeavyEquipmentCompanies";
		return session.selectOne(stmt);
	}
	
	@Override
	public Integer getCountAllHeavyEquipmentCompanies() {
		String stmt = LOOKUP_HEC_NS +"getCountAllHeavyEquipmentCompanies";
		return session.selectOne(stmt);
	}

	@Override
	public List<HeavyEquipmentCompany> getPageHelpOnHeavyEquipmentCompanies(Page page) {
		String stmt = LOOKUP_HEC_NS +"getPageHelpOnHeavyEquipmentCompanies";
		return session.selectList(stmt, page);
	}

	@Override
	public List<HeavyEquipmentCompany> getPageInfoOnHeavyEquipmentCompanies(Page page) {
		String stmt = LOOKUP_HEC_NS  +"getPageInfoOnHeavyEquipmentCompanies";
		return session.selectList(stmt, page);
	}
	
	@Override
	public List<HeavyEquipmentCompany> getPageAllHeavyEquipmentCompanies(Page page) {
		String stmt = LOOKUP_HEC_NS +"getPageAllHeavyEquipmentCompanies";
		return session.selectList(stmt, page);
	}
	
	@Override
	public HeavyEquipmentCompany getHeavyEquipmentCompany(String userId) {
		String stmt = LOOKUP_HEC_NS +"getHeavyEquipmentCompany";
		return session.selectOne(stmt, userId);
	}

	@Override
	public List<HeavyEquipment> getCompanyHeavyEquipments(String userId) {
		String stmt = LOOKUP_HEC_NS +"getCompanyHeavyEquipments";
		return session.selectList(stmt, userId);
	}

	
	
}
