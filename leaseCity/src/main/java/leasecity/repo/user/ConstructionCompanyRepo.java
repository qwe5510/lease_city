package leasecity.repo.user;

import java.util.List;

import leasecity.dto.user.ConstructionCompany;
import leasecity.dto.user.HeavyEquipmentCompany;

public interface ConstructionCompanyRepo {
	// 모든 건설업체 검색
	public List<ConstructionCompany> getAllConstructionCompanys();

	// 건설업체 검색
	public ConstructionCompany getConstructionCompany(String userId);

	// 건설업체 추가
	public int 
		insertConstructionCompany(ConstructionCompany CC);
}
