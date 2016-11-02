package leasecity.repo.user;

import java.util.List;

import leasecity.dto.etc.Page;
import leasecity.dto.user.HeavyEquipment;
import leasecity.dto.user.HeavyEquipmentCompany;

public interface LookUpHeavyEquipmentRepo {
	
	/**
	 * 입력한 페이지 조건에 부합하는 도움여부 공개란이 ON된 회원
	 * @param page keyword 혹은 search가 들어갈 것임
	 * @return
	 */
	public Integer getCountHelpOnHeavyEquipment(Page page);
	
	/**
	 * 입력한 페이지 조건에 부합하는 중기업체 인원 확인
	 * @param page keyword 혹은 search가 들어갈 것임
	 * @return
	 */
	public Integer getCountInfoOnHeavyEquipment(Page page);
	
	/**
	 * Page단위로 출력하며, 도움 여부가 ON된 유저만을 리스트로 받는다.
	 * @param page
	 * @return
	 */
	public List<HeavyEquipmentCompany> getPageHelpOnHeavyEquipmentCompanies(Page page);
	
	
	/**
	 * Page단위로 출력하며, 정보 공개 여부가 ON된 유저만을 리스트로 받는다.
	 * @param page
	 * @return
	 */
	public List<HeavyEquipmentCompany> getPageInfoOnHeavyEquipmentCompanies(Page page);
	
	/**
	 * 회원 ID를 이용하여 중기업체 정보를 불러옴.
	 * @param userId
	 * @return
	 */
	public HeavyEquipmentCompany getHeavyEquipmentCompany(String userId);
	
	/**
	 * 입력한 유저id에 대한 중장비 목록 출력.
	 * @param userId
	 * @return
	 */
	public List<HeavyEquipment> getCompanyHeavyEquipments(String userId);
	

}
