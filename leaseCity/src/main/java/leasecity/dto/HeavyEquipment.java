package leasecity.dto;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * 중장비 모델 클래스.
 * 
 * @author generated by ERMaster
 * @version $Id$
 */
@Data
@AllArgsConstructor
public class HeavyEquipment implements Serializable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** 차량번호. */
	private String idNumber;

	/** 회원. */
	private Users users;

	/** 중장비 종류. */
	private String equipmentCategory;

	/** 임대신청 목록. */
	private Set<LeaseRequests> leaseRequestsSet;

	/** 임대양도 목록. */
	private Set<LeaseTransfer> leaseTransferSet;

	/** 작업 내역 목록. */
	private Set<WorkLog> workLogSet;

	/**
	 * 생성자.
	 */
	public HeavyEquipment() {
		this.leaseRequestsSet = new HashSet<LeaseRequests>();
		this.leaseTransferSet = new HashSet<LeaseTransfer>();
		this.workLogSet = new HashSet<WorkLog>();
	}

}