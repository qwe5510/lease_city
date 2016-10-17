package leasecity.repo.community;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.community.Comment;
import leasecity.dto.etc.Page;

@Repository
public class CommentRepoImpl implements CommentRepo{
	
	// Sql쿼리를 작동시키는 SessionTemplate Bean
	@Autowired
	SqlSessionTemplate session;
	
	// mapper연동용 문자열 코드 - 게시글
	private final String COMMENT_NS = "leasecity.repo.commentRepo.";
	
	//모든 게시글 갯수 정수로 리턴
	@Override
	public Integer getCountAllComments() {
		String stmt = COMMENT_NS + "getCountAllComments";
		return session.selectOne(stmt);
	}
	
	@Override
	public Integer getCountSearchComments(Page page) {
		String stmt = COMMENT_NS + "getPageSelectCommentCount";
		return session.selectOne(stmt, page);
	}
	
	//모든 게시글 페이지 별로 리턴
	@Override
	public List<Comment> getPageComments(Page page) {
		String stmt = COMMENT_NS + "getPageSelectComment";
		return session.selectList(stmt, page);
	}
	
	@Override
	public Comment getComment(Integer commentNo) {
		String stmt = COMMENT_NS + "getSelectComment";
		return session.selectOne(stmt, commentNo);
	}
	
	//게시글 추가
	@Override
	public int insertComment(Comment comment) {
		String stmt = COMMENT_NS + "insertComment";
		return session.insert(stmt, comment);
	}
	
	
	//게시글 삭제 (댓글도 같이 삭제)
	@Override
	public int deleteCommentAndReply(Comment comment) {
		String stmt = COMMENT_NS + "deleteCommentAndReply";
		return session.delete(stmt, comment);
	}
	
	//게시글 수정
	@Override
	public int updateComment(Comment comment) {
		String stmt = COMMENT_NS + "updateComment";
		return session.update(stmt, comment);
	}

}
