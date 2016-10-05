package leasecity.dto.adminwork;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * 대기 유저 모델 클래스.
 * 
 * @author generated by ERMaster
 * @version $Id$
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
public class StandByUser implements Serializable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** 대기유저번호. */
	private Integer standByNo;

	/** 업체명. */
	private String companyName;

	/** 대표자명. */
	private String representName;

	/** 이메일 주소. */
	private String email;

	/** 요청날짜(가입 요청 시). */
	private Date requestDate;

	/** 발급코드. */
	private Integer permissionNo;

	/** 발급 날짜(관리자 수락 기준). */
	private Date regDate;

}