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
	
	// 중장비 정보 수정
	public int updateHeavyEquipment(HeavyEquipment HE);
	
	// 증장비 삭제
	public int deleteHeavyEquipment(HeavyEquipment HE);

}
