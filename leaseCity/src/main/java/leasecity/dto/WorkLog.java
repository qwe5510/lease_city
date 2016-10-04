package leasecity.dto;

import java.io.Serializable;
import java.util.Date;

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

	/** 회원. */
	private User users;

	/** 임대 요청 번호. */
	private Integer leaseCallNo;

	/** 임대 신청 번호. */
	private Integer leaseRequestNo;

	/** 임대 직접 요청 번호. */
	private Integer leaseDirectNo;

	/** 임대 양도 번호. */
	private Integer leaseTransferNo;

	/** 임대 선정 번호. */
	private Integer leaseSelectionNo;

	/** 시작 날짜 (~부터). */
	private Date fromDate;

	/** 종료 날짜 (~까지). */
	private Date toDate;

	/** 기록 날짜. */
	private Date regDate;

}
