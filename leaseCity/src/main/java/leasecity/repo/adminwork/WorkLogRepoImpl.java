package leasecity.repo.adminwork;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.adminwork.WorkLog;
import leasecity.dto.etc.Page;

@Repository
public class WorkLogRepoImpl implements WorkLogRepo{
	
	// Sql쿼리를 작동시키는 SessionTemplate Bean
	@Autowired
	SqlSessionTemplate session;
	
	// mapper연동용 문자열 코드 - 작업기록
	private final static String WORKLOG_NS = "leasecity.repo.workLogRepo."; 
	
	@Override
	public Integer getCountAllWorkLog(String userId) {
		String stmt = WORKLOG_NS +"getCountAllWorkLog";
		return session.selectOne(stmt, userId);
	}
	
	@Override
	public List<WorkLog> getPageWorkLog(Page page) {
		String stmt = WORKLOG_NS +"getPageWorkLog";
		return session.selectList(stmt, page);
	}
}
