package leasecity.service;

import java.util.List;

import leasecity.dto.adminwork.Notify;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.RemoveFailException;
import leasecity.exception.ServiceFailException;

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
	 * 알림을 한 후, 클릭하면 notify 자동 삭제
	 * 
	 * @param userId
	 *            - session으로 로그인된 아이디
	 * @return
	 * @throws RemoveFailException
	 */
	public void deleteNotifyByLoginUser(int notifyNo) throws RemoveFailException;
	
	/**
	 * 어떠한 알람을 추가할 떄
	 * 
	 * @param notify
	 *            - 추가할 notify
	 * @return
	 * @throws ServiceFailException
	 */
	public void insertNotifyByLoginUser(Notify notify) throws ServiceFailException;
	
	/**
	 * 알림을 한 후, notify 자동 수정
	 * 
	 * @param notify
	 *            - 추가할 notify
	 * @return
	 * @throws ServiceFailException
	 */
	public void updateNotifyByLoginUser(int notifyNo) throws ServiceFailException;
	
	/**
	 * 헤더에 표시할 notify 가져오기
	 * 
	 * @param userId
	 *            - 로그인 된 아이디
	 * @return
	 * @throws NotFoundDataException
	 */
	public List<Notify> searchHeaderNotifyByLoginUser(String userId) throws NotFoundDataException;

}
