package leasecity.repo.user;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.user.User;

@Repository
public class MypageRepoImpl implements MypageRepo{

	@Autowired
	SqlSessionTemplate session;
	
	private final String MYPAGE_NS = "leasecity.repo.mypageRepo.";

	// 로그인 유저 갖고오기
	@Override
	public User getUser(String userId) {
		String stmt = MYPAGE_NS + "getSelectUser";
		return session.selectOne(stmt, userId);
	}

	
}
