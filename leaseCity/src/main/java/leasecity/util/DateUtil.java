package leasecity.util;

import java.util.Calendar;
import java.util.Date;

public class DateUtil {
	
	//java.util.Date -> java.sql.Date로 전환
	public static java.sql.Date utilToSqlDate
							(Date date){
		long dateTime = date.getTime();		
		return new java.sql.Date(dateTime);
	}
	
	//java.sql.Date -> java.util.Date로 전환
	public static Date sqlToUtilDate
							(java.sql.Date date){
		long dateTime = date.getTime();
		return new java.util.Date(dateTime);
	}
	
	//java.util.Date의 날짜를 String으로 전환.
	public static String getDateString(Date date){
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		
		return calendar.get(Calendar.YEAR) + "-"
				+ (calendar.get(Calendar.MONTH)+1) + "-"
				+ calendar.get(Calendar.DAY_OF_MONTH); 
	}
	
	//java.util.Date의 시간을 String으로 전환.
	public static String getTimeString(Date date){
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		
		return calendar.get(Calendar.HOUR_OF_DAY) + ":"
				+ calendar.get(Calendar.MINUTE) + ":"
				+ calendar.get(Calendar.SECOND); 
	}

}
