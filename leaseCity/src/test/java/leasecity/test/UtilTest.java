package leasecity.test;

import java.util.Date;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import leasecity.util.DateUtil;
import leasecity.util.HashingUtil;

public class UtilTest {
	static Logger logger = LoggerFactory.getLogger(UtilTest.class);

	@Test
	public void test() {
		
		
		Date date = DateUtil.getStringDate("2016", "5", "3");
		
		
		System.out.println(date);
		
		
		
		
	}

}
