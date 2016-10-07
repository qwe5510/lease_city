package leasecity.service;

import leasecity.dto.user.User;
import leasecity.exception.JoinFailException;
import leasecity.exception.LoginFailException;

public interface UserService {

	//회원가입
	public void join(User user) throws JoinFailException;
	
	//로그인
	public User login(String userId, String password)
								throws LoginFailException;
}
