package leasecity.repo.user;

import java.util.List;

import leasecity.dto.user.License;

public interface LicenseRepo {
	
	
	//모든 자격증 조회
	public List<License> getAllLicense();
	//유저별 자격증 조회
	public List<License> getUserLicense(String userId);
	//자격증 검색
	public License getLicense(String licenseNo);
	
	//자격증 추가
	public int insertLicense(License license);
	//자격증 삭제
	public int deleteLicense(License license);
	//유저가 가진 자격증 총괄삭제
	public int deleteUserLicense(String userId);
	
}
