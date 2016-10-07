package leasecity.repo.user;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.user.ConstructionCompany;

@Repository
public class ConstructionCompanyRepooImpl implements ConstructionCompanyRepo{

	private final String CC_NS = "leasecity.repo.constructionCompanyRepo.";
	
	@Autowired
	SqlSessionTemplate session;
	
	//건설업체 회원 전체 조회
	@Override
	public List<ConstructionCompany> 
			getAllConstructionCompanys() {
		String stmt = CC_NS + "getAllSelectCC";
		return session.selectList(stmt);
	}

	//건설업체 회원 ID로 검색
	@Override
	public ConstructionCompany 
			getConstructionCompany(String userId) {
		String stmt = CC_NS + "getSelectCC";
		return session.selectOne(stmt, userId);
	}

	@Override
	public ConstructionCompany getCCUser(String userId) {
		String stmt = CC_NS + "getSelectCCAndUser";
		return session.selectOne(stmt, userId);
	}

	
	//건설업체 회원 추가
	@Override
	public int 
		insertConstructionCompany(ConstructionCompany CC) {
		String stmt = CC_NS + "insertCC";		
		return session.insert(stmt, CC);
	}
	
}
