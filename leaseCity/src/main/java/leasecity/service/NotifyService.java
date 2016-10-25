package leasecity.service;

import java.util.List;

import leasecity.dto.adminwork.Notify;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.RemoveFailException;

public interface NotifyService {

	/**
	 * 스케줄러로 로그인된 아이디의 notify가 있는지 확인
	 * 
	 * @param userId
	 *            - session으로 로그인된 아이디
	 * @return Notify를 List로 여러개 갖고오기
	 * @throws NotFoundDataException
	 */
	public List<Notify> searchNotifyByLoginUser(String userId) throws NotFoundDataException;

	/**
	 * 알림을 한 후, notify 자동 삭제
	 * 
	 * @param userId
	 *            - session으로 로그인된 아이디
	 * @return
	 * @throws RemoveFailException
	 */
	public void deleteNotifyByLoginUser(String userId) throws RemoveFailException;

}
