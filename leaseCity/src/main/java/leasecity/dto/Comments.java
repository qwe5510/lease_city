package leasecity.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 커뮤니티 게시글 모델 클래스.
 * 
 * @author generated by ERMaster
 * @version $Id$
 */
@Data
@EqualsAndHashCode
@AllArgsConstructor
public class Comments implements Serializable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** 게시글 번호. */
	private Integer commentNo;

	/** 회원. */
	private String userId;

	/** 게시글 제목. */
	private String commentTitle;

	/** 게시글 분류. */
	private String commentCategory;

	/** 게시글 내용. */
	private String commentContent;

	/** 조회 수. */
	private Integer hits;

	/** 게시글 날짜. */
	private Date regDate;

	/** 커뮤니티 댓글 목록. */
	private List<Replys> replysList;

	/**
	 * 생성자.
	 */
	public Comments() {
		this.replysList = new ArrayList<Replys>();
	}

}
