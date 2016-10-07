package leasecity.config;

import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import leasecity.util.HashingUtil;

@Configuration
@ComponentScan(basePackages={
		"leasecity.dto", 
		"leasecity.repo",
		"leasecity.service"})
@PropertySource("classpath:/config/dbconfig.properties")
@EnableTransactionManagement
public class ApplicationConfig {

	@Bean
	public PlatformTransactionManager transactionManager(DataSource ds){
		PlatformTransactionManager tm = new DataSourceTransactionManager(ds);
		return tm;
	}// 트랜잭션 처리 설정
	
	@Bean
	public DataSource dataSource(
			@Value("${ds.driverClassName}") String driverClassName,
			@Value("${ds.url}") String url,
			@Value("${ds.userName}") String userName,
			@Value("${ds.password}") String password,
			@Value("${ds.maxTotal}") int maxTotal,
			@Value("${ds.initialSzie}") int initialSize,
			@Value("${ds.maxIdle}") int maxIdle){
		BasicDataSource ds = new BasicDataSource();
		ds.setDriverClassName(driverClassName);
		ds.setUrl(url);
		ds.setUsername(userName);
		ds.setPassword(password);
		ds.setMaxTotal(maxTotal);
		ds.setInitialSize(initialSize);
		ds.setMaxIdle(maxIdle);
		return ds;
	}// 데이터소스 연결
	
	@Bean
	public SqlSessionFactoryBean sqlSessionFactoryBean(DataSource ds){
		SqlSessionFactoryBean bean = new SqlSessionFactoryBean();
		bean.setDataSource(ds);
		String loc = "config/mybatis-config.xml";
		bean.setConfigLocation(new ClassPathResource(loc));
		
		return bean;
	}// mybatis연동
	
	@Bean
	public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactoryBean sfb) throws Exception{
		SqlSessionTemplate template = new SqlSessionTemplate(sfb.getObject());
		return template;
	} // mybatis연동으로 SQLSession생성
	
	
	@Bean
	public MessageSource messageSource(){
		ReloadableResourceBundleMessageSource ms = new ReloadableResourceBundleMessageSource();
		ms.setCacheSeconds(0);
		ms.setBasename("classpath:/message/error/binding");
		return ms;
	}//error시 문구 작성

}
