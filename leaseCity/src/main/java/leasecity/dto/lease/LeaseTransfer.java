package leasecity.dto.lease;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * 임대양도 모델 클래스.
 * 
 * @author generated by ERMaster
 * @version $Id$
 */
@Data
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
public class LeaseTransfer implements Serializable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** 임대 양도 번호. */
	private Integer LeaseTransferNo;
	
	/** 임대 양도 행 번호 */
	private Integer leaseTransferRowNum;

	/** 임대 양도 하는 아이디. */
	private String sendUserId;
	
	/** 보내는 쪽 업체 이름 (DTO전용)*/
	private String sendCompanyName;

	/** 임대 양도 하는 차량 번호. */
	private String sendIdNumber;

	/** 임대 양도 받는 아이디. */
	private String acceptUserId;

	/** 임대 양도 받는 차량 번호. */
	private String acceptIdNumber;

	/** 중장비 종류. */
	private String equipmentCategory;

	/** 작업 장소. */
	private String address;

	/** 양도 내용. */
	private String content;

	/** 시작 날짜 (~부터). */
	private Date fromDate;

	/** 종료 날짜 (~까지). */
	private Date toDate;

	/** 비용. */
	private Integer price;
	
	/** 수락 날짜. */
	private Date permissionDate;
}
