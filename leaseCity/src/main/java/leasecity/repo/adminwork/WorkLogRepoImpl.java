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
	public Integer getCountLeaseRequestAndCallWorkLog(String userId) {
		String stmt = WORKLOG_NS +"getCountLeaseRequestAndCallWorkLog";
		return session.selectOne(stmt, userId);
	}
	
	@Override
	public List<WorkLog> getPageLeaseRequestAndCallCCWorkLog(Page page) {
		String stmt = WORKLOG_NS +"getPageLeaseRequestAndCallCCWorkLog";
		return session.selectList(stmt, page);
	}
	
	@Override
	public List<WorkLog> getPageLeaseRequestAndCallHECWorkLog(Page page) {
		String stmt = WORKLOG_NS +"getPageLeaseRequestAndCallHECWorkLog";
		return session.selectList(stmt, page);
	}
	
	@Override
	public Integer getCountLeaseTransferWorkLog(String userId) {
		String stmt = WORKLOG_NS +"getCountLeaseTransferWorkLog";
		return session.selectOne(stmt, userId);
	}
	
	@Override
	public List<WorkLog> getPageLeaseTransferWorkLog(Page page) {
		String stmt = WORKLOG_NS +"getPageLeaseTransferWorkLog";
		return session.selectList(stmt, page);
	}
	
	@Override
	public Integer getCountLeaseCallWorkLog(String userId) {
		String stmt = WORKLOG_NS +"getCountLeaseCallWorkLog";
		return session.selectOne(stmt, userId);
	}
	
	@Override
	public List<WorkLog> getPageLeaseCallWorkLog(Page page) {
		String stmt = WORKLOG_NS +"getPageLeaseCallWorkLog";
		return session.selectList(stmt, page);
	}
	
	@Override
	public Integer insertWorkLog(WorkLog workLog) {
		String stmt = WORKLOG_NS +"insertWorkLog";
		return session.insert(stmt, workLog);
	}
	
	@Override
	public Integer updateEvaluationYes(WorkLog workLog) {
		String stmt = WORKLOG_NS +"updateEvaluationYes";
		return session.update(stmt, workLog);
	}
}
