package leasecity.repo.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.user.User;

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
	
	//유저 중복값 확인 - id 
	@Override
	public User getUserCheckId(String userId) {
		String stmt = USER_NS + "getSelectUserCheckId";
		return session.selectOne(stmt, userId);
	}
	
	//유저 중복값 확인 - 업체명
	@Override
	public User getUserCheckCompanyName(String companyName) {
		String stmt = USER_NS + "getSelectUserCheckId";
		return session.selectOne(stmt, companyName);
	}

	//유저 중복값 확인 - email
	@Override
	public User getUserCheckEmail(String email) {
		String stmt = USER_NS + "getSelectUserCheckId";
		return session.selectOne(stmt, email);
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
	
	//유저 아이디 찾기
	@Override
	public User searchUserId(User user) {
		String stmt = USER_NS + "searchUserId";
		return session.selectOne(stmt, user);
	}
	
	//유저 비밀번호 찾기
	@Override
	public User searchUserPassword(User user) {
		String stmt = USER_NS + "searchUserPassword";
		return session.selectOne(stmt, user);
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
	
	//회원 수정 - 정보변경.(업체명, 대표자명, 이메일 제외)
	@Override
	public int updateUser(User user) {
		String stmt = USER_NS + "updateInfoUser";
		return session.update(stmt, user);
	}
	
	//회원 수정 - 비밀번호 변경
	@Override
	public int updatePasswordUser(User user) {
		String stmt = USER_NS + "updatePasswordUser";
		return session.update(stmt, user);
	}


	
}
