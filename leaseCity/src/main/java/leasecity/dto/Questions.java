package leasecity.dto;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 질문 모델 클래스.
 * 
 * @author generated by ERMaster
 * @version $Id$
 */
@Data
@AllArgsConstructor
public class Questions implements Serializable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** 질문글 번호. */
	private Integer questionNo;

	/** 회원. */
	private Users users;

	/** 질문글 제목. */
	private String questionTitle;

	/** 질문글 분류. */
	private String questionCategory;

	/** 질문글 내용. */
	private String questionContent;

	/** 질문 등록 날짜. */
	private Date regDate;

	/** 답변 목록. */
	private Set<Answers> answersSet;

	/**
	 * 생성자.
	 */
	public Questions() {
		this.answersSet = new HashSet<Answers>();
	}
}