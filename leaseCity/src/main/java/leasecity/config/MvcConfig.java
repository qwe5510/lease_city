package leasecity.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration
@ComponentScan(basePackages={"leasecity.controller"})
@EnableWebMvc
public class MvcConfig extends WebMvcConfigurerAdapter{
	static Logger logger = LoggerFactory.getLogger(MvcConfig.class);
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		
		registry.addResourceHandler("/images/**")
		.addResourceLocations("/WEB-INF/images/");
		
		registry.addResourceHandler("/css/**")
		.addResourceLocations("/WEB-INF/css/");
		
		registry.addResourceHandler("/js/**")
		.addResourceLocations("/WEB-INF/js/");
	}
	
	@Bean
	public ViewResolver internalResourceViewResolver(){
		InternalResourceViewResolver resolver
			= new InternalResourceViewResolver();
		resolver.setPrefix("/WEB-INF/view/");
		resolver.setSuffix(".jsp");
		return resolver;
	}
	
}
