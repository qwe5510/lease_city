package leasecity.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import leasecity.dto.adminwork.Notify;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.RemoveFailException;
import leasecity.repo.adminwork.NotifyRepo;

@Service
public class NotifyServiceImpl implements NotifyService {

	static Logger logger = LoggerFactory.getLogger(NotifyServiceImpl.class);

	@Autowired
	NotifyRepo notifyRepo;

	@Override
	public List<Notify> searchNotifyByLoginUser(String userId) throws NotFoundDataException {

		List<Notify> notify = null;

		// 로그인된 아이디가 있고, notify 해야 한다면 --> 알림
		if (userId != null && notifyRepo.getNotify(userId) != null) {
			notify = notifyRepo.getNotify(userId);
			logger.trace("알림 표시할 notify : {}", notify);
			return notify;
		} else {
			logger.trace("로그인이 안되있거나, 알림할 notify가 없음");
			throw new NotFoundDataException("notify 없음");
		}
	}

	@Override
	public void deleteNotifyByLoginUser(String userId) throws RemoveFailException {

		List<Notify> notify = null;

		// 로그인된 아이디가 있고, notify 했다면 --> 삭제
		if (userId != null && notifyRepo.getNotify(userId) != null) {
			notifyRepo.deleteNotify(userId);
			logger.trace("삭제 할 notify : {}", notify);
		} else {
			logger.trace("로그인이 안되있거나, 알림할 notify가 없음");
			throw new RemoveFailException("notify 없음");
		}

	}
}
