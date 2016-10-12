package leasecity.service;

import leasecity.dto.user.User;
import leasecity.exception.JoinFailException;
import leasecity.exception.LoginFailException;
import leasecity.exception.ServiceFailException;

public interface UserService {

	
	//회원가입
	public void join(User user) throws JoinFailException;
	
	//로그인
	public User login(String userId, String password)
								throws LoginFailException;
	
	//이미 존재하는 아이디인지 중복여부 확인. -> 중복 시 true, 아니면 false
	public boolean isUserId(String userId);
	
	//회원 정보변경, keyword를 통해 비밀번호, 정보 중 하나 변경 
	public void changeInfo(String keyword, User user)
								throws ServiceFailException;

}
