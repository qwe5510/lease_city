package leasecity.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.SchedulingConfigurer;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;

import leasecity.service.LeaseService;
import leasecity.service.StandByUserService;

@Configuration
@EnableScheduling
public class StandByUserScheduler implements SchedulingConfigurer{

	@Autowired
	StandByUserService SBUService;
	
	@Autowired
	LeaseService leaseService;
	
	@Bean
	public ThreadPoolTaskScheduler taskShceduler(){
		ThreadPoolTaskScheduler scheduler = new ThreadPoolTaskScheduler();
		scheduler.setPoolSize(5);
		return scheduler;
	}
	
	@Override
	public void configureTasks(ScheduledTaskRegistrar taskRegistrar) {
		
		//TEST용 코드
		/*taskRegistrar.setScheduler(taskShceduler());
		taskRegistrar.addFixedDelayTask(new Runnable(){
			@Override
			public void run() {
				SBUService.cleanStandByUser();
			}
		}, 1000 * 60 * 5);*/
		
		taskRegistrar.addCronTask(new Runnable(){
			@Override
			public void run() {
				SBUService.cleanStandByUser();
				leaseService.autoRejectionLeaseRequest();
				leaseService.reflashLeaseDirectCalls();
			}
		}, " 0 0 0 * * ?");
		//0초 0분 0시 매일 아무요일이나
		//CRONTRIGGER OPTION (ss, mm, hh, DD, MM, DAY_OF_WEEK) / 년도는 지정하지않음.
	}
}
