package leasecity.repo.user;

import java.util.List;

import leasecity.dto.user.User;

public interface UserRepo {
	
	//모든 유저 검색
	public List<User> getAllUsers();
	
	//유저 검색
	public User getUser(String userId);
	
	//유저 추가
	public int insertUsers(User user);
	
	//회원 삭제 (중기업체, 건설업체 전부 가능)
	public int deleteUser(User user);
	
	//비밀번호 해싱
	public int hashingPassword(User user);
}
