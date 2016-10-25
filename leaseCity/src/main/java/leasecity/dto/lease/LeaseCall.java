package leasecity.dto.lease;

import java.io.Serializable;
import java.util.Date;
import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 임대요청 모델 클래스.
 * 
 * @author generated by ERMaster
 * @version $Id$
 */
@Data
@EqualsAndHashCode
@AllArgsConstructor
public class LeaseCall implements Serializable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** 임대 요청 번호. */
	private Integer leaseCallNo;

	/** 회원 아이디 */
	private String userId;

	/** 임대 분류. */
	private String leaseCategory;

	/** 중장비 종류. */
	private String equipmentCategory;

	/** 작업 장소. */
	private String address;

	/** 임대 요청글 제목. */
	private String leaseCommentTitle;

	/** 임대 요청글 내용. */
	private String leaseCommentContent;

	/** 조회 수. */
	private Integer hits;

	/** 시작 날짜 (~부터). */
	private Date fromDate;

	/** 종료 날짜 (~까지). */
	private Date toDate;

	/** 요청글 등록날짜. */
	private Date regDate;

	/** 하한가격 (~부터). */
	private Integer fromPrice;

	/** 상한가격 (~까지). */
	private Integer toPrice;

	/** 임대 직접신청 목록. */
	private List<LeaseDirectCall> leaseDirectCallsList;

	/** 임대신청 목록. */
	private List<LeaseRequest> leaseRequestsList;

	/**
	 * 생성자.
	 */
	public LeaseCall() {
		this.leaseDirectCallsList = new ArrayList<LeaseDirectCall>();
		this.leaseRequestsList = new ArrayList<LeaseRequest>();
	}

}
