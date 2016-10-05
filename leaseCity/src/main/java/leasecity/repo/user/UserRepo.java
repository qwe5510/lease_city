package leasecity.repo.user;

import java.util.List;

import leasecity.dto.user.User;

public interface UserRepo {
	
	//모든 유저 검색
	public List<User> getAllUsers();
	
	//유저 검색
	public User getUser(String userId);
	
	//유저 추가
	public int addUsers(User user);
	
	//유저 삭제
	public int deleteUser(User user);
}
