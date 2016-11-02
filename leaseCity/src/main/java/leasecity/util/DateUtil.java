package leasecity.util;

import java.util.Calendar;
import java.util.Date;
import java.util.StringTokenizer;

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
			
			int year = calendar.get(Calendar.YEAR);
			int month = calendar.get(Calendar.MONTH)+1;
			int dateOfMonth = calendar.get(Calendar.DAY_OF_MONTH);
			
			String strYear = year+"";
			String strMonth = month+"";
			String strDate = dateOfMonth+"";
			
			if(month < 10){strMonth = "0"+strMonth;}
			if(dateOfMonth < 10){strDate = "0"+strDate;}
			
			return strYear+"-"+strMonth+"-"+strDate;
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
	
	
	public static Date dateFormat(String dateStr){
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.HOUR, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		
		StringTokenizer st = new StringTokenizer(dateStr, " ");
		
		while(st.hasMoreTokens()){
			String dateTime = st.nextToken();
				
			if(dateTime.indexOf(":") != -1){
				StringTokenizer timeToken = new StringTokenizer(dateTime, ":");
				
				int[] timeArray = {Calendar.HOUR, Calendar.MINUTE, Calendar.SECOND};
				int count=0;
				
				while(timeToken.hasMoreTokens()){
					calendar.set(timeArray[count++], 
							Integer.parseInt(timeToken.nextToken())); 
				}
				
			}else if(dateTime.indexOf("-") != -1){
				StringTokenizer dateToken = new StringTokenizer(dateTime, "-");
				
				int[] dateArray = {Calendar.YEAR, Calendar.MONTH, Calendar.DAY_OF_MONTH};
				int count=0;
				
				while(dateToken.hasMoreTokens()){
					
					if(dateArray[count] == Calendar.MONTH){
						calendar.set(dateArray[count++], 
						Integer.parseInt(dateToken.nextToken())-1);
					}
					else{
						calendar.set(dateArray[count++], 
								Integer.parseInt(dateToken.nextToken()));
					}
				}
			}
		}
		
		return calendar.getTime();
	}
}
