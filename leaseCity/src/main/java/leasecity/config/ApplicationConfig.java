package leasecity.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

@Configuration
@ComponentScan(basePackages={
		"leasecity.dto", 
		"leasecity.repo", 
		"leasecity.config"
		})
@EnableWebMvc
public class ApplicationConfig {

}
