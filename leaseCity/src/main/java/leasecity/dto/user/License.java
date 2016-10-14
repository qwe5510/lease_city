package leasecity.dto.user;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * 자격증 모델 클래스.
 * 
 * @author generated by ERMaster
 * @version $Id$
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
public class License implements Serializable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;
	
	/** 자격증 인식 번호 */
	private Integer licenseNo;

	/** 회원. */
	private String userId;

	/** 자격증 이름. */
	private String licenseName;

	/** 자격증 취득 날짜. */
	private Date licenseDate;

	/** 발급처. */
	private String licenser;
	
	public License(String userId, String licenseName, 
			Date licenseDate, String licenser){
		this.licenseNo = null;
		this.userId = userId;
		this.licenseName = licenseName;
		this.licenseDate = licenseDate;
		this.licenser = licenser;
	}

}
