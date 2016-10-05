package leasecity.repo.user;

import java.util.List;

import org.springframework.stereotype.Repository;

import leasecity.dto.user.ConstructionCompany;

@Repository
public class ConstructionCompanyRepooImpl implements ConstructionCompanyRepo{

	private final String CC_NS = "";
	
	@Override
	public List<ConstructionCompany> 
			getAllConstructionCompanys() {
		
		return null;
	}

	@Override
	public ConstructionCompany 
			getConstructionCompany(String userId) {
		
		return null;
	}

	@Override
	public int 
		addConstructionCompany(ConstructionCompany CC) {
		
		return 0;
	}

}
