package leasecity.util;

import java.util.Calendar;
import java.util.Date;

//날짜를 문자열로 리턴
public class DateUtil {
	
	//Date의 날짜를 String으로 전환.
	public static String getDateString(Date date){
		Calendar calendar;
		
		if(date==null){ // date가 null일때 null반환
			return null;
		}else{
			calendar = Calendar.getInstance();
			calendar.setTime(date);
			//Date가 null이 아니면
			return calendar.get(Calendar.YEAR) + "-"
					+ (calendar.get(Calendar.MONTH)+1) + "-"
					+ calendar.get(Calendar.DAY_OF_MONTH);
		}
	}
	
	//Date의 시간을 String으로 전환.
	public static String getTimeString(Date date){
		Calendar calendar;
		
		if(date==null){ // date가 null일때 null반환
			return null;
		}else{
			calendar = Calendar.getInstance();
			calendar.setTime(date);
			//Date가 null이 아니면
			return calendar.get(Calendar.HOUR_OF_DAY) + ":"
					+ calendar.get(Calendar.MINUTE) + ":"
					+ calendar.get(Calendar.SECOND); 
		}
	}
	
	//Date의 날짜와 시간을 String으로 전환
	
	public static String getDateTimeString(Date date){
		Calendar calendar;
		if(date==null){ // date가 null일때 null반환
			return null;
		}else{
			calendar = Calendar.getInstance();
			calendar.setTime(date);
			//Date가 null이 아니면
			return calendar.get(Calendar.YEAR) + "-"
					+ (calendar.get(Calendar.MONTH)+1) + "-"
					+ calendar.get(Calendar.DAY_OF_MONTH) + " "
					+ calendar.get(Calendar.HOUR_OF_DAY) + ":"
					+ calendar.get(Calendar.MINUTE) + ":"
					+ calendar.get(Calendar.SECOND); 
		}
	}
	
	
	//year, month, day값을 파라미터로 Date를 리턴하는 메서드
	public static Date getStringDate(String year, String month, String day){
		Calendar calendar = Calendar.getInstance();
		int intYear = Integer.parseInt(year);
		int intMonth = Integer.parseInt(month);
		int intDay = Integer.parseInt(day);
		
		calendar.set(Calendar.YEAR, intYear);
		//0 -> 1월
		calendar.set(Calendar.MONTH, intMonth-1);
		calendar.set(Calendar.DAY_OF_MONTH, intDay);
		
		return calendar.getTime();
	}
	
	public static Integer getTimeNumber(Date date){
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		
		StringBuffer sb = new StringBuffer();
		
		sb
		.append(calendar.get(Calendar.YEAR))
		.append(calendar.get(Calendar.MONTH)+1)
		.append(calendar.get(Calendar.DAY_OF_MONTH))
		.append(calendar.get(Calendar.HOUR))
		.append(calendar.get(Calendar.MINUTE))
		.append(calendar.get(Calendar.SECOND));
		
		return Integer.parseInt(sb.toString());
	}

}
