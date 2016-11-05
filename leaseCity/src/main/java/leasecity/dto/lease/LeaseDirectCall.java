package leasecity.dto.lease;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * 임대 직접신청 모델 클래스.
 * 
 * @author generated by ERMaster
 * @version $Id$
 */
@Data
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
public class LeaseDirectCall implements Serializable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** 임대 직접 요청 번호. */
	private Integer leaseDirectNo;

	/** 건설업체 회원 ID. (송신자) */
	private String constructionId;

	/** 중기업체 회원 ID. (수신자) */
	private String equipmentId;

	/** 임대요청 번호 */
	private Integer leaseCallNo;

	/** 직접요청 내용. */
	private String directCallContent;
	
	/** 하한가격 (~부터). */
	private Integer fromPrice;

	/** 상한가격 (~까지). */
	private Integer toPrice;
}
