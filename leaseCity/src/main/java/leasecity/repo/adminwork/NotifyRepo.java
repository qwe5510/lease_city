package leasecity.repo.adminwork;

import java.util.List;

import leasecity.dto.adminwork.Notify;

public interface NotifyRepo {
	
	// 모든 새 알림 검색
	public List<Notify> getAllNotify();
	
	// 로그인 유저가 새 알림을 갖고 있는지 확인
	public List<Notify> getNotify(String userId);
	
	// 새 알림 추가
	public int insertNotify(Notify notify);
	
	// 새 알림 수정
	public int updateNotify(int notifyNo);
	
	// 새 알림 삭제
	public int deleteNotify(int notifyNo);

}
