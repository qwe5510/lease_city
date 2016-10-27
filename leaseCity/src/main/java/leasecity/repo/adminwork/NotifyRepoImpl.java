package leasecity.repo.adminwork;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.adminwork.Notify;

@Repository
public class NotifyRepoImpl implements NotifyRepo{
	
	// mapper 연동용 문자 코드 - Notify
	private final String N_NS = "leasecity.repo.notifyRepo.";
	
	// Sql쿼리를 작동시키는 SessionTemplate Bean
	@Autowired
	SqlSessionTemplate session;

	// 모든 새 알림 검색
	@Override
	public List<Notify> getAllNotify() {
		String stmt = N_NS + "getAllSelectNotify";
		return session.selectList(stmt);
	}

	// 로그인 시, 유저의 미확인 알림 검색 (n개 검색)
	@Override
	public List<Notify> getNotify(String userId) {
		String stmt = N_NS + "getSelectNotify";
		return session.selectList(stmt, userId);
	}

	// 알림 추가
	@Override
	public int insertNotify(Notify notify) {
		String stmt = N_NS + "insertNotify";
		return session.insert(stmt, notify);
	}

	// 알림 삭제
	@Override
	public int deleteNotify(int notifyNo) {
		String stmt = N_NS + "deleteNotify";
		return session.delete(stmt, notifyNo);
	}

	@Override
	public int updateNotify(int notifyNo) {
		String stmt = N_NS + "updateNotify";
		return session.update(stmt, notifyNo);
	}

}
