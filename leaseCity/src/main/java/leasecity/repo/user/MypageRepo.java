package leasecity.repo.user;

import java.util.List;

import leasecity.dto.user.User;

public interface MypageRepo {

	// 로그인 유저 갖고오기
	public User getUser(String userId);
	
}
