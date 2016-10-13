package leasecity.repo.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.user.License;

@Repository
public class LicenseRepoImpl implements LicenseRepo{

	//mapper연동용 문자열 코드 - 자격증
	private final String LICENSE_NS = "leasecity.repo.license.";
	
	//Sql쿼리를 작동시키는 SessionTemplate Bean
	@Autowired
	SqlSessionTemplate session;
	
	@Override
	public List<License> getAllLicense() {
		String stmt = LICENSE_NS + "getAllSelectLicense";
		return session.selectList(stmt);
	}

	@Override
	public List<License> getUserLicense(String userId) {
		String stmt = LICENSE_NS + "getSelectUserLicense";
		return session.selectList(stmt, userId);
	}

	@Override
	public License getLicense(String licenseNo) {
		String stmt = LICENSE_NS + "getSelectlicense";
		return session.selectOne(stmt, licenseNo);
	}

	@Override
	public int insertLicense(License license) {
		String stmt = LICENSE_NS + "insertLicense";
		return session.insert(stmt, license);
	}

	@Override
	public int updateLicense(License prev, License next) {
		String stmt = LICENSE_NS + "updateLicense";
		
		Map<String, License> map = new HashMap<>();
		
		map.put("prev", prev);
		map.put("next", next);
		
		return session.update(stmt);
	}

	@Override
	public int deleteLicense(License license) {
		String stmt = LICENSE_NS + "deleteLicense";
		return session.delete(stmt, license);
	}
	
	@Override
	public int deleteUserLicense(String userId) {
		String stmt = LICENSE_NS + "deleteUserLicense";
		return session.delete(stmt, userId);
	}

	
	
}
