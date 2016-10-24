package leasecity.repo.adminwork;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.community.Comment;
import leasecity.dto.etc.Page;

@Repository
public class QuestionRepoImpl implements QuestionRepo{

	// Sql쿼리를 작동시키는 SessionTemplate Bean
	@Autowired
	SqlSessionTemplate session;
		
	// mapper연동용 문자열 코드 - 게시글
	private final String QUESTION_NS = "leasecity.repo.questionRepo.";
		
	
	@Override
	public Integer getCountAllQuestions() {
		String stmt = QUESTION_NS + "getCountAllQAndAComments";
		return session.selectOne(stmt);
	}

	@Override
	public Integer getCountSearchQuestions(Page page) {
		String stmt = QUESTION_NS + "getPageSelectQuestionCount";
		return session.selectOne(stmt, page);
	}

	@Override
	public List<Comment> getPageQuestions(Page page) {
		String stmt = QUESTION_NS + "getPageSelectQuestions";
		return session.selectList(stmt, page);
	}

	@Override
	public Comment getQuestion(Integer commentNo) {
		String stmt = QUESTION_NS + "getSelectQuestion";
		return session.selectOne(stmt, commentNo);
	}

	@Override
	public Comment getUserQuestion(Comment comment) {
		String stmt = QUESTION_NS + "getSelectUserQuestion";
		return session.selectOne(stmt, comment);
	}

	@Override
	public int insertQuestion(Comment comment) {
		String stmt = QUESTION_NS + "insertQuestion";
		return session.insert(stmt, comment);
	}

	@Override
	public int deleteQuestionAndAnswer(Comment comment) {
		String stmt = QUESTION_NS + "deleteQuestionAndAnswer";
		return session.delete(stmt, comment);
	}

	@Override
	public int updateQuestion(Comment comment) {
		String stmt = QUESTION_NS + "updateQuestion";
		return session.update(stmt, comment);
	}

	@Override
	public int hitsUpQuestion(Comment comment) {
		String stmt = QUESTION_NS + "hitsUpQuestion";
		comment.setHits(comment.getHits()+1);
		return session.update(stmt, comment);
	}
	

}

