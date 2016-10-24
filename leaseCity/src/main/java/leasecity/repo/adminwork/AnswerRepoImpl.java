package leasecity.repo.adminwork;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.community.Comment;
import leasecity.dto.community.Reply;
import leasecity.dto.etc.Page;

@Repository
public class AnswerRepoImpl implements AnswerRepo{
	
	// Sql쿼리를 작동시키는 SessionTemplate Bean
	@Autowired
	SqlSessionTemplate session;

	// mapper연동용 문자열 코드 - 게시글
	private final String ANSWER_NS = "leasecity.repo.answerRepo.";
	
	/**
	 * 질문글 별 답변 갯수 리턴
	 * @param commentNo : 출력할 댓글에 대한 게시글 번호
	 * @return
	 */
	public Integer getCountQuestionAnswer(Integer commentNo){
		String stmt = ANSWER_NS + "getCountQuestionAnswer";
		return session.selectOne(stmt, commentNo);
	}
		
	/**
	 * 임의 게시글 페이지 별로 리턴
	 * @param page : currentPage, pageSize, to, from가 있어야 함.
	 * @return 덧글 목록
	 */
	public List<Reply> getPageAnswers(Page page){
		String stmt = ANSWER_NS + "getPageSelectAnswer";
		return session.selectList(stmt, page);
	}
		
	
	/**
	 * 덧글 추가 기능 
	 * @param reply : 넣을 덧글
	 * @return 추가된 개수.
	 */
	public int insertAnswer(Reply reply){
		String stmt = ANSWER_NS + "insertAnswer";
		return session.insert(stmt, reply);
	}
		
	/**
	 * 덧글 삭제 기능
	 * @param reply : 삭제할 덧글
	 * @return 삭제한 개수
	 */
	public int deleteAnswer(Reply reply){
		String stmt = ANSWER_NS + "deleteAnswer";
		return session.delete(stmt, reply);
	}
		
	/**
	 * 덧글 수정
	 * @param reply: 수정할 덧글
	 * @return 수정한 개수
	 */
	public int updateAnswer(Reply reply){
		String stmt = ANSWER_NS + "updateAnswer";
		return session.update(stmt, reply);
	}
}

