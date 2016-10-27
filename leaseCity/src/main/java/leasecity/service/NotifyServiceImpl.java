package leasecity.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import leasecity.dto.adminwork.Notify;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.RemoveFailException;
import leasecity.exception.ServiceFailException;
import leasecity.repo.adminwork.NotifyRepo;

@Service
public class NotifyServiceImpl implements NotifyService {

	static Logger logger = LoggerFactory.getLogger(NotifyServiceImpl.class);

	@Autowired
	NotifyRepo notifyRepo;

	// 로그인 유저의 notify가 있는지 검색 ( 자동검색 )
	@Override
	public List<Notify> searchNotifyByLoginUser(String userId) throws NotFoundDataException {

		List<Notify> notifyList = new ArrayList<>();
	
		// 로그인된 아이디가 있고, notify 해야 한다면 --> 알림
		if (userId != null && notifyRepo.getNotify(userId) != null) {
			for(Notify notify : notifyRepo.getNotify(userId)) {
				if( notify.getNotifyCheck().equals("N")) {
					notifyList.add(notify);
					logger.trace("N인 notify : {}", notify);
				}
			}
			logger.trace("알림 표시할 notifyList : {}", notifyList);
			return notifyList;
		} else {
			logger.trace("로그인이 안되있거나, 알림할 notify가 없음");
			throw new NotFoundDataException("notify 없음");
		}
	}

	// 로그인한 유저가, 해당 알람 클릭시, 삭제
	@Override
	public void deleteNotifyByLoginUser(int notifyNo) throws RemoveFailException {

		// 로그인된 아이디가 있고, notify 했다면 --> 삭제 (미완)
		notifyRepo.deleteNotify(notifyNo);
		logger.trace("삭제된 notifyNo : {}", notifyNo);
	}

	// 로그인 유저가 임대, Q&A, 커뮤니티 게시판 등에 글을 올릴시, notify 생성
	@Override
	public void insertNotifyByLoginUser(Notify notify) throws ServiceFailException {
		
		logger.trace("추가할 notify : {}", notify);
		notifyRepo.insertNotify(notify);
	}

	// 알람 후, update 하기
	@Override
	public void updateNotifyByLoginUser(int notifyNo) throws ServiceFailException {
		
		logger.trace("업데이트 할 notifyNo : {}", notifyNo);
		notifyRepo.updateNotify(notifyNo);
	}

	////////////////////////////// 헤더에 담을 정보  //////////////////////////////////////////
	
	// 헤더 notify에 담을 정보
	@Override
	public List<Notify> searchHeaderNotifyByLoginUser(String userId) throws NotFoundDataException {
		List<Notify> notifyList = new ArrayList<>();
		
		// 로그인된 아이디가 있고, notify 해야 한다면 --> 알림
		if (userId != null && notifyRepo.getNotify(userId) != null) {
			notifyList = notifyRepo.getNotify(userId);
			logger.trace("알림 표시할 notifyList : {}", notifyList);
			return notifyList;
		} else {
			logger.trace("로그인이 안되있거나, 알림할 notify가 없음");
			throw new NotFoundDataException("notify 없음");
		}
	}
}
