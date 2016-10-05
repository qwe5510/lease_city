package leasecity.repo.user;

import java.util.List;

import leasecity.dto.user.HeavyEquipmentCompany;

public interface HeavyEquipmentCompanyRepo {
	//모든 중기업체 검색
	public List<HeavyEquipmentCompany> 
				getAllHeavyEquipmentCompanys();
	
	//중기업체 검색
	public HeavyEquipmentCompany
		getHeavyEquipmentCompany(String userId);
	
	//중기업체 추가
	public int
		insertHeavyEquipmentCompany(HeavyEquipmentCompany HEC);
	
	//중기업체 삭제
	public int
		deleteHeavyEquipmentCompany(HeavyEquipmentCompany HEC);
	
}
