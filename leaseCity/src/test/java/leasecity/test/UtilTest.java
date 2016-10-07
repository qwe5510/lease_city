package leasecity.test;

import java.util.Date;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import leasecity.util.DateUtil;

public class UtilTest {
	static Logger logger = LoggerFactory.getLogger(UtilTest.class);

	@Test
	public void test() {
		
		Date testDate = new Date();
		
		String dateString = 
			DateUtil.getDateString(testDate);
		
		logger.trace("{}",dateString);
		logger.trace("{}", dateString.getClass());
		
		java.sql.Date sqlDate = DateUtil.utilToSqlDate(testDate);		
		
		logger.trace("sqlDate : {}", sqlDate);
		logger.trace("sqlDate : {}", sqlDate.getClass());
		
		Date utilDate = DateUtil.sqlToUtilDate(sqlDate);

		logger.trace("utilDate : {}", utilDate);
		logger.trace("utilate : {}", utilDate.getClass());
		
		String timeString = DateUtil.getTimeString(utilDate);
		logger.trace("{}", timeString);
		logger.trace("{}", timeString.getClass());
		
	}

}
