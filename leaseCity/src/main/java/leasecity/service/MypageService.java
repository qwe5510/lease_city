package leasecity.service;

import leasecity.dto.user.User;
import leasecity.exception.JoinFailException;
import leasecity.exception.LoginFailException;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.ServiceFailException;

public interface MypageService {

	// 로그인 유저 갖고오기
	public User searchUser(String userId) 
			throws NotFoundDataException;
}

