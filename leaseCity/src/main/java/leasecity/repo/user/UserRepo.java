package leasecity.repo.user;

import java.util.List;

import leasecity.dto.user.User;

public interface UserRepo {
	
	//모든 유저 검색
	public List<User> getAllUsers();
	
	//유저 정보 중복 검색 - Id,업체명, email / Id,Password
	public User getUserCheckId(String userId);
	public User getUserCheckCompanyName(String companyName);
	public User getUserCheckEmail(String email);
	
	public User getUserIdAndPassword(String userId, String password);
	
	//아이디 찾기, 비밀번호 찾기 기능
	//업체명, 대표자명, 이메일 정보로 유저id 뒷자리 **처리한 값 리턴.
	public User searchUserId(User user);
	
	//아이디, 업체명, 대표자명, 이메일 정보로 유저 정보가 있는지 확인.
	public User searchUserPassword(User user);
	
	//유저 추가
	public int insertUser(User user);
	
	//회원 삭제 (중기업체, 건설업체 전부 가능)
	public int deleteUser(User user);
	
	//유저 수정 - 정보변경(업체명, 대표자명, 이메일 제외)
	public int updateUser(User user);
	
	//유저 수정 - 비밀번호 변경
	public int updatePasswordUser(User user);
	
	// 유저 탈퇴
	public int withdrawUser(User user);
	
	// 탈퇴 유저 자동 삭제 (14일 이상)
	public int deletewithdrawUser();

}
