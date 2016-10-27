package leasecity.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import leasecity.dto.adminwork.Notify;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.RemoveFailException;
import leasecity.exception.ServiceFailException;
import leasecity.service.NotifyService;

@Controller
public class ConvenienceController {
	
	static Logger logger = LoggerFactory.getLogger(ConvenienceController.class);
	
	@Autowired
	NotifyService nService;
	
	@RequestMapping(value="/evaluate",method=RequestMethod.GET)
	public String evaluate(Model model){
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "convenience/evaluate";
	}

	// 로그인 유저가 notify 있는지 확인 및 던지기
	@RequestMapping(value = "/confirmNotify", method = RequestMethod.POST)
	public @ResponseBody List<Notify> confirmNotify(Model model, @RequestParam String userId) {
		
		logger.trace("loginUser : {}", userId);
		List<Notify> notifyList = null;
		
		try {
			notifyList = nService.searchNotifyByLoginUser(userId);
			logger.trace("로그인 유저가 가진 notify : {}", notifyList);
			//nService.deleteNotifyByLoginUser(userId);
		} catch (NotFoundDataException e) {
			logger.trace("가진거 없음");
		} 
		
		return notifyList;
	}
	
	// 로그인 유저가 notify 있는지 확인 및 던지기
	@RequestMapping(value = "/deleteNotify", method = RequestMethod.POST)
	public @ResponseBody String deleteNotify(Model model, @RequestParam int notifyNo) {

		logger.trace("삭제 예정 번호 : {}", notifyNo);

		try {
			nService.deleteNotifyByLoginUser(notifyNo);
		} catch (RemoveFailException e) {
			logger.trace("삭제 실패");
		}

		return "success";
	}
	
	// 알람을 띄워주면 다시 알람을 불러오지 않도록 막기
	@RequestMapping(value = "/updateNotify", method = RequestMethod.POST)
	public @ResponseBody String updateNotify(Model model, @RequestParam int notifyNo) {

		logger.trace("수정 예정 번호 : {}", notifyNo);

		try {
			nService.updateNotifyByLoginUser(notifyNo);
		} catch (ServiceFailException e) {
			logger.trace("수정 실패");
		}
		
		return "success";
	}
	
	// notify 모두 삭제 클릭 시, 로그인 아이디 notify 모두 delete
	@RequestMapping(value = "/deleteAllNotify", method = RequestMethod.POST)
	public @ResponseBody String deleteAllNotify(Model model, @RequestParam String userId) {

		logger.trace("모두 삭제할 아이디 : {}", userId);

		List<Notify> notifyList = null;
		try {
			notifyList = nService.searchHeaderNotifyByLoginUser(userId);
			logger.trace("모두 삭제할 List : {}", notifyList);
			for (Notify notify : notifyList) {
				nService.deleteNotifyByLoginUser(notify.getNotifyNo());
			}
		} catch (NotFoundDataException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (RemoveFailException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "success";
	}
	
	///////////////////////////////////////////////////////////////////////////////////////
	
	// 로그인 유저가 notify 있는지 확인 및 던지기
	@RequestMapping(value = "/confirmHeaderNotify", method = RequestMethod.POST)
	public @ResponseBody List<Notify> confirmHeaderNotify(Model model, @RequestParam String userId) {

		logger.trace("headerNotify 컨트롤러!");
		logger.trace("loginUser : {}", userId);
		List<Notify> notifyList = null;

		try {
			notifyList = nService.searchHeaderNotifyByLoginUser(userId);
			logger.trace("로그인 유저가 가진 notify : {}", notifyList);
			// nService.deleteNotifyByLoginUser(userId);
		} catch (NotFoundDataException e) {
			logger.trace("가진거 없음");
		}

		return notifyList;
	}
}
