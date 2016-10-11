package leasecity.repo.user;

import java.util.List;

import leasecity.dto.user.User;

public interface UserRepo {
	
	//모든 유저 검색
	public List<User> getAllUsers();
	
	//유저 검색 - Id / Id,Password
	public User getUser(String userId);
	public User getUserIdAndPassword(String userId, String password);
	
	//유저 추가
	public int insertUser(User user);
	
	//회원 삭제 (중기업체, 건설업체 전부 가능)
	public int deleteUser(User user);
	
	//유저 수정 - 정보변경(업체명, 대표자명, 이메일 제외)
	public int updateUser(User user);
	//유저 수정 - 비밀번호 변경
	public int updatePasswordUser(User user);

}
