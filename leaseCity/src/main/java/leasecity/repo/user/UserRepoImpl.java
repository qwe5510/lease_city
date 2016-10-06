package leasecity.repo.user;

import java.util.List;

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
	
	@Override
	public List<User> getAllUsers() {
		String stmt = USER_NS + "getAllSelectUsers";
		return session.selectList(stmt);
	}
	
	@Override
	public User getUser(String userId) {
		String stmt = USER_NS + "getSelectUser";
		return session.selectOne(stmt, userId);
	}
	
	@Override
	public int insertUsers(User user) {
		String stmt = USER_NS + "insertUser";		
		return session.insert(stmt, user);
	}
	
	//회원 삭제 (중기업체, 건설업체 전부 가능)
	@Override
	public int deleteUser(User user) {
		String stmt = USER_NS + "deleteUser";
		return session.delete(stmt, user);
	}
	
	@Override
	public int hashingPassword(User user) {
		String stmt = USER_NS + "hashingPassword";
		user.setPassword(HashingUtil.hashingString(user.getPassword()));		
		return session.update(stmt, user);
	}
	
}
