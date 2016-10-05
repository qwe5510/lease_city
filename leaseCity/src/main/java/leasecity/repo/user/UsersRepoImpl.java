package leasecity.repo.user;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.user.User;

@Repository
public class UsersRepoImpl implements UsersRepo{

	@Autowired
	SqlSessionTemplate session;
	
	private final String USER_NS = "leasecity.repo.userRepo.";
	
	@Override
	public List<User> getAllUsers() {
		String stmt = USER_NS + "getAllSelectUser";
		return session.selectList(stmt);
	}
	
}
