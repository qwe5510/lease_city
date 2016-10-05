package leasecity.dto.user;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import leasecity.dto.lease.LeaseCall;
import leasecity.dto.lease.LeaseDirectCall;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 건설업체 모델 클래스.
 * 
 * @author generated by ERMaster
 * @version $Id$
 */
@EqualsAndHashCode(callSuper=false)
@Data
@AllArgsConstructor
public class ConstructionCompany extends User implements Serializable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** 연매출. */
	private Float yearlySale;

	/** 연 수주량. */
	private Integer yearlyAoor;

	/** 회사 규모. */
	private String companySize;

	/** 회사 분야. */
	private String companyCategory;

	/** 임대요청 목록. */
	private List<LeaseCall> leaseCallsList;

	/** 임대 직접신청 목록. */
	private List<LeaseDirectCall> leaseDirectCallsList;

	/** 자격증 목록. */
	private List<License> licenseList;

	/**
	 * 생성자.
	 */
	public ConstructionCompany() {
		this.leaseCallsList = new ArrayList<LeaseCall>();
		this.leaseDirectCallsList = new ArrayList<LeaseDirectCall>();
		this.licenseList = new ArrayList<License>();
	}

}