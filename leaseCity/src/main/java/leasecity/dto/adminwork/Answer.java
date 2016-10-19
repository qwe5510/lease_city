package leasecity.dto.adminwork;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * 답변 모델 클래스.
 * 
 * @author generated by ERMaster
 * @version $Id$
 */

@Data
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
public class Answer implements Serializable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** 답변글 번호. */
	private Integer answerNo;

	/** 질문. */
	private Integer questionNo;

	/** 답변글 제목. */
	private String answerTitle;

	/** 답변글 내용. */
	private String answerContent;

	/** 조회 수. */
	private Integer hits;

	/** 답변 등록 날짜. */
	private Date regDate;

}
