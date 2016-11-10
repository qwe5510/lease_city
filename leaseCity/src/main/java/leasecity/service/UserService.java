package leasecity.service;

import java.util.List;

import leasecity.dto.user.HeavyEquipment;
import leasecity.dto.user.License;
import leasecity.dto.user.User;
import leasecity.exception.JoinFailException;
import leasecity.exception.LoginFailException;
import leasecity.exception.NotFoundDataException;
import leasecity.exception.ServiceFailException;

public interface UserService {

	
	//회원가입
	public void join(User user) throws JoinFailException;
	
	//관리자 로그인
	public User adminLogin(String userId, String password)
								throws LoginFailException;
	
	//로그인
	public User login(String userId, String password)
								throws LoginFailException;
	
	//이미 존재하는 아이디, 업체명, 이메일인지 중복여부 확인. -> 중복 시 true, 아니면 false
	public boolean isUserId(String userId);
	public boolean isUserCompanyName(String companyName);
	public boolean isUserEmail(String email);
	
	//아이디 찾기 - 뒷자리가 *처리된 id와 이메일, 업체명, 대표자명 정보가 담긴 유저 리턴
	public User searchUserId(User user) 
				throws NotFoundDataException;
	
	//비밀번호 찾기 : 아이디, 업체명, 대표자명, 이메일정보로 검색하여 유저가있는지 확인.
	public User searchUserPassword(User user) 
				throws NotFoundDataException;
	
	/**
	 * 유저 정보 변경
	 * @param isPassword true일 시, 비밀번호까지 변경
	 * @param user
	 * @throws ServiceFailException
	 */
	public void changeInfo(Boolean isPassword, User user)
								throws ServiceFailException;
	
	/**
	 * 유저 정보 리턴
	 * @param userId
	 * @return
	 * @throws NotFoundDataException
	 */
	public User loadUserInfo(String userId)
								throws NotFoundDataException;
	
	/**
	 * 회원ID에 대한 중장비 정보 리턴 - 중기업체
	 * @param userId
	 * @return
	 * @throws NotFoundDataException
	 */
	public List<HeavyEquipment> loadUserHeavyEquipment(String userId)
								throws NotFoundDataException;
	
	/**
	 * 회원ID에 대한 자격증 정보 리턴 - 건설업체
	 * @param userId
	 * @return
	 * @throws NotFoundDataException
	 */
	public List<License> loadUserLicense(String userId)
								throws NotFoundDataException;
	
	
	/**
	 * 유저 신용도 점수 계산
	 * @param userId
	 */
	public void calcCreditGrade(User user);
	
	/**
	 * 회원의 완료작업 기록 개수 (Credit DTO를 이용하여 작성)
	 * @param user
	 * @return
	 */
	public Integer getCountWorkLog(User user);
	
	
	/**
	 * 해당 차량번호가 존재하는지 검색
	 * @param idNumber
	 * @return
	 */
	public Boolean checkHEC(String idNumber);
								
}

