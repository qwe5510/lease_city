package leasecity.repo.adminwork;

import java.util.List;

import leasecity.dto.community.Comment;
import leasecity.dto.etc.Page;

public interface QuestionRepo {
	
	//모든 게시글 갯수 정수로 리턴
	public Integer getCountAllQuestions();
	
	//검색 했을 때 게시물 갯수 리턴
	public Integer getCountSearchQuestions(Page page);
	
	//모든 게시글 페이지 별로 리턴
	public List<Comment> getPageQuestions(Page page);
	
	//질문글 조회
	public Comment getQuestion(Integer commentNo);
	
	//질문글 조회 (번호, 아이디)
	public Comment getUserQuestion(Comment comment);
	
	//질문글 추가
	public int insertQuestion(Comment comment);
	
	//질문글 삭제 (답변도 같이 삭제)
	public int deleteQuestionAndAnswer(Comment comment);
	
	//질문글 수정
	public int updateQuestion(Comment comment);
	
	//조회수 증가
	public int hitsUpQuestion(Comment comment);
}

