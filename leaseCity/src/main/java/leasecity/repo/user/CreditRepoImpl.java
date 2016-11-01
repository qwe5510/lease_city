package leasecity.repo.user;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.user.Credit;

@Repository
public class CreditRepoImpl implements CreditRepo{
	
	
	// mapper연동용 문자열 코드 - 중기업체
	private final String CREDIT_NS = "leasecity.repo.creditRepo.";

	// Sql쿼리를 작동시키는 SessionTemplate Bean
	@Autowired
	SqlSessionTemplate session;
	
	public List<Credit> getSelectAcceptCredits(String acceptUserId){
		String stmt = CREDIT_NS + "getSelectAcceptCredits";
		return session.selectList(stmt, acceptUserId);
	}

}
