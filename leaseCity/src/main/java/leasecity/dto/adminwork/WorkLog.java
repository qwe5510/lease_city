package leasecity.dto.adminwork;

import java.io.Serializable;
import java.util.Date;

import leasecity.dto.user.User;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * 작업 내역 모델 클래스.
 * 
 * @author generated by ERMaster
 * @version $Id$
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
public class WorkLog implements Serializable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** 작업기록번호. */
	private Integer logNo;
	
	/** 작업기록 행 번호 */
	private Integer rowNumLogNo;

	/** 회원. */
	private String userId;
	
	/** 업체 이름 */
	private String companyName;

	/** 임대 요청 번호. */
	private Integer leaseCallNo;
	
	/** 임대 분류 (요청기록용) */
	private String leaseCategory;
	
	/** 차량 분류 (요청기록용) */
	private String equipmentCategory;

	/** 임대 신청 번호. */
	private Integer leaseRequestNo;

	/** 임대 양도 번호. */
	private Integer leaseTransferNo;

	/** 시작 날짜 (~부터). */
	private Date fromDate;

	/** 종료 날짜 (~까지). */
	private Date toDate;

	/** 기록 날짜. */
	private Date regDate;
	
	/** 평가 여부 */
	private String evaluationCheck;
	
	/** 기록 경과에 따른 상태 */
	private String status;

}
