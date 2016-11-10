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

import leasecity.dto.etc.Weather;
import leasecity.dto.lease.LeaseCall;
import leasecity.exception.NotFoundDataException;
import leasecity.service.LeaseService;
import leasecity.service.UserService;
import leasecity.util.WeatherUtil;

@Controller
public class IntroduceController {

	@Autowired
	LeaseService leaseService;

	@Autowired
	UserService userService;

	static Logger logger = LoggerFactory.getLogger(IntroduceController.class);

	@RequestMapping(value = "/introduction", method = RequestMethod.GET)
	public String introduction(Model model) {
		model.addAttribute("message", "Good Morning");
		logger.trace("컨트롤러!!");
		System.out.println("컨틀롤러들어옴!");
		return "introduce/introduction";
	}

	@RequestMapping(value = "/autoSelectLeaseCalls", method = RequestMethod.GET)
	public @ResponseBody List<LeaseCall> autoSelectLeaseCalls(
			Model model/* , @RequestParam Integer leaseCallNo */) {

		List<LeaseCall> leaseCallList = new ArrayList<LeaseCall>();

		try {
			leaseCallList = leaseService.loadAllLeaseCalls();

		} catch (NotFoundDataException e) {
			logger.trace("순위 갖고오기 실패");
			return leaseCallList;
		}

		return leaseCallList;
	}

	@RequestMapping(value = "/selectWeather", method = RequestMethod.GET)
	public @ResponseBody List<Weather> selectWeather(@RequestParam String regionNo) {

		// 날씨 담을 변수
		List<Weather> weatherList = new ArrayList<>();
		// 날씨 함수 가져올 Util
		WeatherUtil weather = new WeatherUtil();
		
		logger.trace("날씨 번호 : {}", regionNo);

		try {
			switch (regionNo) {
			
			case "1": // 서울/경기(경기 안양 기준)
				weatherList = weather.xmlRssParser("58", "123");
				for ( Weather w : weatherList) {
					w.setWeatherNo(1);
					w.setCity("서울");
				}
				break;
			case "2": // 충북(충북 충주 기준)
				weatherList = weather.xmlRssParser("75", "115");
				for ( Weather w : weatherList) {
					w.setWeatherNo(2);
					w.setCity("충주");
				}
				break;
			case "3": // 충남(충남 아산 기준)
				weatherList = weather.xmlRssParser("59", "110");
				for ( Weather w : weatherList) {
					w.setWeatherNo(3);
					w.setCity("아산");
				}
				break;
			case "4": // 경북(경북 포항 기준)
				weatherList = weather.xmlRssParser("105", "94");
				for ( Weather w : weatherList) {
					w.setWeatherNo(4);
					w.setCity("포항");
				}
				break;
			case "5": // 경남(경남 사천 기준)
				weatherList = weather.xmlRssParser("80", "73");
				for ( Weather w : weatherList) {
					w.setWeatherNo(5);
					w.setCity("사천");
				}
				break;
			case "6": // 전북(전북 남원 기준)
				weatherList = weather.xmlRssParser("67", "80");
				for ( Weather w : weatherList) {
					w.setWeatherNo(6);
					w.setCity("남원");
				}
				break;
			case "7": // 전남(전남 광양 기준)
				weatherList = weather.xmlRssParser("74", "70");
				for ( Weather w : weatherList) {
					w.setWeatherNo(7);
					w.setCity("광양");
				}
				break;
			case "8": // 강원(강원 춘천 기준)
				weatherList = weather.xmlRssParser("72", "133");
				for ( Weather w : weatherList) {
					w.setWeatherNo(8);
					w.setCity("춘천");
				}
				break;
			case "9": // 제주(제주 제주 기준)
				weatherList = weather.xmlRssParser("53", "38");
				for ( Weather w : weatherList) {
					w.setWeatherNo(9);
					w.setCity("제주");
				}
				break;
			case "10": // 울릉(경북 울릉 기준)
				weatherList = weather.xmlRssParser("127", "127");
				for ( Weather w : weatherList) {
					w.setWeatherNo(10);
					w.setCity("울릉");
				}
				break;
			default:
				logger.trace("날씨 가져오기 실패");
				break;
			}
		} catch (Exception e) {
			logger.error("먼가 알수 없는 오류 {}", e);
		}
		
		logger.trace("날씨 List : {}", weatherList);

		return weatherList;
	}

}
