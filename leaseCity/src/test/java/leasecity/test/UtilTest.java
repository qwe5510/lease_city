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
		Date date = new Date();
		
		String test = DateUtil.getDateString(date);
		logger.trace("날짜 String : {}", test);
		
		test = DateUtil.getTimeString(date);
		
		
	}

}
