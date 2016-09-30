package leasecity.dto;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * 커뮤니티 게시글 모델 클래스.
 * 
 * @author generated by ERMaster
 * @version $Id$
 */
@Data
@AllArgsConstructor
public class Comments implements Serializable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** 게시글 번호. */
	private Integer commentNo;

	/** 회원. */
	private Users users;

	/** 게시글 제목. */
	private String commentTitle;

	/** 게시글 분류. */
	private String commentCategory;

	/** 게시글 내용. */
	private String commentContent;

	/** 게시글 날짜. */
	private Date regDate;

	/** 커뮤니티 댓글 목록. */
	private Set<Replys> replysSet;

	/**
	 * 생성자.
	 */
	public Comments() {
		this.replysSet = new HashSet<Replys>();
	}
}