package leasecity.repo.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.user.User;
import leasecity.util.HashingUtil;

@Repository
public class UserRepoImpl implements UserRepo{

	@Autowired
	SqlSessionTemplate session;
	
	private final String USER_NS = "leasecity.repo.userRepo.";
	
	//모든 유저 검색
	@Override
	public List<User> getAllUsers() {
		String stmt = USER_NS + "getAllSelectUsers";
		return session.selectList(stmt);
	}
	
	//유저 검색 - id 
	@Override
	public User getUser(String userId) {
		String stmt = USER_NS + "getSelectUser";
		return session.selectOne(stmt, userId);
	}
	
	//유저 검색 - id,password
	@Override
	public User getUserIdAndPassword(String userId, String password) {
		Map<String, String> idAndPassword = new HashMap<>();
		String stmt = USER_NS + "getSelectUserIdAndPassword";
		idAndPassword.put("userId", userId);
		idAndPassword.put("password", password);
		return session.selectOne(stmt, idAndPassword);
	}
	
	@Override
	public int insertUser(User user) {
		String stmt = USER_NS + "insertUser";
		return session.insert(stmt, user);
	}
	
	//회원 삭제 (중기업체, 건설업체 전부 가능)
	@Override
	public int deleteUser(User user) {
		String stmt = USER_NS + "deleteUser";
		return session.delete(stmt, user);
	}

	
}
