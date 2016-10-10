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

}
