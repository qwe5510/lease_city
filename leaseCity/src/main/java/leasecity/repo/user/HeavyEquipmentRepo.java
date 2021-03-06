package leasecity.repo.user;

import java.util.List;

import leasecity.dto.user.HeavyEquipment;

public interface HeavyEquipmentRepo {

	// 모든 중장비 호출
	public List<HeavyEquipment> 
				getAllHeavyEquipments();	

	// 한 회원의 중장비 리스트 호출
	public List<HeavyEquipment> 
				getUserHeavyEquipments(String userId);
	
	// 중장비 검색
	public HeavyEquipment
				getHeavyEquipment(String idNumber);

	// 중장비 추가
	public int insertHeavyEquipment(HeavyEquipment HE);
	
	// 증장비 삭제
	public int deleteHeavyEquipment(HeavyEquipment HE);
	
	/**
	 * 유저가 가진 중장비 총괄삭제
	 * @param userId
	 * @return
	 */
	public int deleteUserHeavyEquipment(String userId);
	
	/**
	 * 중장비 사용여부 Y로 변경
	 * @param idNumber
	 * @param userId
	 * @return
	 */
	public int heavyEquipmentUsedYes(HeavyEquipment HE);
	
	/**
	 * 중장비 사용여부 N으로 변경
	 * @param idNumber
	 * @param userId
	 * @return
	 */
	public int heavyEquipmentUsedNo(HeavyEquipment HE);
	
	

}
