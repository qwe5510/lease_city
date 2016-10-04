package leasecity.dto;

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
public class LeaseDirectCalls implements Serializable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** 임대 직접 요청 번호. */
	private Integer leaseDirectNo;

	/** 회원. */
	private User constructionIdusers;

	/** 회원. */
	private User equipmentIdusers;

	/** 임대요청. */
	private LeaseCalls leaseCalls;

	/** 직접요청 내용. */
	private String directCallContent;

}
