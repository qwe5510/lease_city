package leasecity.dto.user;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import leasecity.dto.lease.LeaseDirectCall;
import leasecity.dto.lease.LeaseRequest;
import leasecity.dto.lease.LeaseTransfer;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 중기업체 모델 클래스.
 * 
 * @author generated by ERMaster
 * @version $Id$
 */
@Data
@EqualsAndHashCode(callSuper=false)
@AllArgsConstructor
public class HeavyEquipmentCompany extends User  implements Serializable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** 업무대기 여부. */
	private String helpOnOff;

	/** 정보공개 여부. */
	private String infoOnOff;

	/** 중장비 목록. */
	private List<HeavyEquipment> heavyEquipmentList;

	/** 임대 직접신청 목록. */
	private List<LeaseDirectCall> leaseDirectCallsList;

	/** 임대신청 목록. */
	private List<LeaseRequest> leaseRequestsList;

	/** 임대양도 목록. */
	private List<LeaseTransfer> leaseTransferList;

	/**
	 * 생성자.
	 */
	public HeavyEquipmentCompany() {
		this.heavyEquipmentList = new ArrayList<HeavyEquipment>();
		this.leaseDirectCallsList = new ArrayList<LeaseDirectCall>();
		this.leaseRequestsList = new ArrayList<LeaseRequest>();
		this.leaseTransferList = new ArrayList<LeaseTransfer>();
	}
	
	//User를 파라미터로 받는 생성자.
	public HeavyEquipmentCompany
			(User user, String helpOnOff, String infoOnOff){
		super(user);
		
		this.helpOnOff = helpOnOff;
		this.infoOnOff = infoOnOff;
		
		this.heavyEquipmentList = new ArrayList<HeavyEquipment>();
		this.leaseDirectCallsList = new ArrayList<LeaseDirectCall>();
		this.leaseRequestsList = new ArrayList<LeaseRequest>();
		this.leaseTransferList = new ArrayList<LeaseTransfer>();
	}
	
	/*public HeavyEquipmentCompany(HeavyEquipmentCompany HEC){
		super(HEC);
		
		this.helpOnOff = HEC.helpOnOff;
		this.infoOnOff = HEC.infoOnOff;
		
		this.heavyEquipmentList = new ArrayList<HeavyEquipment>();
		this.leaseDirectCallsList = new ArrayList<LeaseDirectCall>();
		this.leaseRequestsList = new ArrayList<LeaseRequest>();
		this.leaseTransferList = new ArrayList<LeaseTransfer>();
	}*/

	
	/**
	 * UserId도 같이 출력되게 임의 설정
	 */
	@Override
	public String toString() {
		return "HeavyEquipmentCompany(userId="+ getUserId() +", helpOnOff=" + helpOnOff + ", infoOnOff=" + infoOnOff + ")";
	}
	
}
