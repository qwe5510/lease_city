package leasecity.service;

import leasecity.dto.user.User;
import leasecity.exception.NotFoundDataException;

public interface MypageService {

	// 로그인 유저 갖고오기
	public User searchUser(String userId) 
			throws NotFoundDataException;
}

