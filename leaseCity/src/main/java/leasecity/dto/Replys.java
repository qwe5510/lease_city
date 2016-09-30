package leasecity.dto;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 커뮤니티 댓글 모델 클래스.
 * 
 * @author generated by ERMaster
 * @version $Id$
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Replys implements Serializable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** 댓글 인식번호. */
	private Integer replyNo;

	/** 커뮤니티 게시글. */
	private Comments comments;

	/** 회원. */
	private Users users;

	/** 댓글 내용. */
	private String replyContent;

	/** 댓글 등록 날짜. */
	private Date regDate;

}
