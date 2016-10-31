package leasecity.repo.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.user.User;

@Repository
public class MypageRepoImpl implements MypageRepo{

	@Autowired
	SqlSessionTemplate session;
	
	private final String USER_NS = "leasecity.repo.myPageRepo.";
	


	
}
