package leasecity.test;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import leasecity.config.AsyncConfig;
import leasecity.exception.NotFoundDataException;

public class schedulerTest {
	
	static Logger logger = LoggerFactory.getLogger(schedulerTest.class);
	
	
	@Test
	public void test() throws NotFoundDataException{
		AnnotationConfigApplicationContext atx
				= new AnnotationConfigApplicationContext(AsyncConfig.class);
	}

}
