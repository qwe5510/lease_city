package leasecity.repo.adminwork;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.user.User;

@Repository
public class AdminRepoImpl implements AdminRepo{

	// Sql쿼리를 작동시키는 SessionTemplate Bean
	@Autowired
	SqlSessionTemplate session;

	// mapper연동용 문자열 코드 - 관리자
	private final String ADMIN_NS = "leasecity.repo.adminRepo.";
	
	//관리자 인증
	@Override
	public User getNotAdmin(String userId) {
		String stmt = ADMIN_NS + "isAdminSelect";
		return session.selectOne(stmt, userId);
	}
	
	@Override
	public int deleteCommunityComment(Integer commentNo) {
		String stmt = ADMIN_NS + "deleteCommunityComment";
		return session.delete(stmt, commentNo);
	}

	@Override
	public int deleteCommunityReply(Integer replyNo) {
		String stmt = ADMIN_NS + "deleteCommunityReply";
		return session.delete(stmt, replyNo);
	}

	@Override
	public int deleteQuestion(Integer commentNo) {
		String stmt = ADMIN_NS + "deleteQuestion";
		return session.delete(stmt, commentNo);
	}

	@Override
	public int deleteAnswer(Integer replyNo) {
		String stmt = ADMIN_NS + "deleteAnswer";
		return session.delete(stmt, replyNo);
	}

	
}
