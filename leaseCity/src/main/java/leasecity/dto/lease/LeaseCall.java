package leasecity.dto.lease;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
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
	
	/** 회원의 신용도 */
	private Double tempGrade;

	/** 회원 아이디 */
	private String userId;

	/** 업체 명 (DB 칼럼에는 없음) */
	private String companyName;
	
	/** 대표자 명 (칼럼 값에는 없음) */
	private String representName;
	
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
	
	/** 신용도 점수 */
	private Integer creditGrade;

	/** 임대 직접신청 목록. */
	private List<LeaseDirectCall> leaseDirectCallsList;

	/** 임대 신청 대기자 명수 */
	private Integer standByLRCount; 
	
	/** 임대 신청 선발자 명수 */
	private Integer choiceLRCount;
	
	/** 임대신청 목록. */
	private List<LeaseRequest> leaseRequestsList;

	/**
	 * 생성자.
	 */
	public LeaseCall() {
		this.leaseDirectCallsList = new ArrayList<LeaseDirectCall>();
		this.leaseRequestsList = new ArrayList<LeaseRequest>();
	}

	public LeaseCall(Integer leaseCallNo, String userId, String companyName, String leaseCategory,
			String equipmentCategory, String address, String leaseCommentTitle, String leaseCommentContent,
			Integer hits, Date fromDate, Date toDate, Date regDate, Integer fromPrice, Integer toPrice) {
		this.leaseCallNo = leaseCallNo;
		this.userId = userId;
		this.companyName = companyName;
		this.leaseCategory = leaseCategory;
		this.equipmentCategory = equipmentCategory;
		this.address = address;
		this.leaseCommentTitle = leaseCommentTitle;
		this.leaseCommentContent = leaseCommentContent;
		this.hits = hits;
		this.fromDate = fromDate;
		this.toDate = toDate;
		this.regDate = regDate;
		this.fromPrice = fromPrice;
		this.toPrice = toPrice;
		
		this.leaseDirectCallsList = new ArrayList<LeaseDirectCall>();
		this.leaseRequestsList = new ArrayList<LeaseRequest>();
	}
}
