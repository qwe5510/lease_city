package leasecity.util;

import java.io.BufferedInputStream;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

import leasecity.dto.etc.Weather;

public class WeatherUtil {

	// 함수 1 : 경도 위도로 날씨정보 갖고오기
	public List<Weather> xmlRssParser(String gridx, String gridy) throws Exception {

		// 가져온 날씨 담는 변수
		List<Weather> list = new ArrayList<Weather>();
		
		// 현재 시간 갖고오기
		long time = System.currentTimeMillis();
		SimpleDateFormat dayTime = new SimpleDateFormat("HH");
		String currentHour = dayTime.format(new Date(time));

		// 기상청 xml은 3시간 단위로 예보를 보여줌. 현재시간 기준으로 어떤 예보를 가져올 것인지 정함.
		if (currentHour.equals("00") || currentHour.equals("01") || currentHour.equals("02")) {
			currentHour = "3";
		} else if (currentHour.equals("03") || currentHour.equals("04") || currentHour.equals("05")) {
			currentHour = "6";
		} else if (currentHour.equals("06") || currentHour.equals("07") || currentHour.equals("08")) {
			currentHour = "9";
		} else if (currentHour.equals("09") || currentHour.equals("10") || currentHour.equals("11")) {
			currentHour = "12";
		} else if (currentHour.equals("12") || currentHour.equals("13") || currentHour.equals("14")) {
			currentHour = "15";
		} else if (currentHour.equals("15") || currentHour.equals("16") || currentHour.equals("17")) {
			currentHour = "18";
		} else if (currentHour.equals("18") || currentHour.equals("19") || currentHour.equals("20")) {
			currentHour = "21";
		} else if (currentHour.equals("21") || currentHour.equals("22") || currentHour.equals("23")) {
			currentHour = "24";
		}

		// 기상청에서 날씨정보를 갖고오는 소스
		URL url = new URL("http://www.kma.go.kr/wid/queryDFS.jsp?gridx=" + gridx + "&gridy=" + gridy);

		XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
		XmlPullParser xpp = factory.newPullParser();
		BufferedInputStream bis = new BufferedInputStream(url.openStream());
		xpp.setInput(bis, "utf-8");

		// dto
		String tag = null;
		String wfKor = null, tmn = null, tmx = null, day = null, hour = null, temp = null;

		int eventType = xpp.getEventType();
		while (eventType != XmlPullParser.END_DOCUMENT) {
			if (eventType == XmlPullParser.START_TAG) {
				tag = xpp.getName();
			}
			// 갖고오기
			else if (eventType == XmlPullParser.TEXT) {
				if (tag.equals("tmn") && !xpp.getText().contains("\n")) {
					tmn = xpp.getText();
				} else if (tag.equals("tmx") && !xpp.getText().contains("\n")) {
					tmx = xpp.getText();
				} else if (tag.equals("day") && !xpp.getText().contains("\n")) {
					day = xpp.getText();
				} else if (tag.equals("wfKor") && !xpp.getText().contains("\n")) {
					wfKor = xpp.getText();
				} else if (tag.equals("hour") && !xpp.getText().contains("\n")) {
					hour = xpp.getText();
				} else if (tag.equals("temp") && !xpp.getText().contains("\n")) {
					temp = xpp.getText();
				}

			} else if (eventType == XmlPullParser.END_TAG) {
				tag = xpp.getName();

				if (tag.equals("location")) {
					break;
				}

				// dto에 담기
				if (tag.equals("data") && hour.equals(currentHour)) {
					Weather entity = new Weather();
					entity.setWfKor(wfKor);
					entity.setTmn(tmn);
					entity.setTmx(tmx);
					entity.setDay(day);
					entity.setHour(hour);
					entity.setTemp(temp);
					list.add(entity);
				}
			}
			eventType = xpp.next();
		}
		
		System.out.println("가져갈 날씨 : " + list.size());
		
		return list;
	}

	public static void printResult(List<Weather> list) {
		for (Weather entity : list) {
			System.out.println("날짜 : " + entity.getDay() + " 시간 : " + entity.getHour() + " 날씨 : " + entity.getWfKor());
			System.out.println("최저기온 : " + entity.getTmn());
			System.out.println("최고기온 : " + entity.getTmx());
			System.out.println("현재기온 : " + entity.getTemp());
		}
	}

}
