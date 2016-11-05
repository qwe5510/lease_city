package leasecity.repo.community;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leasecity.dto.community.Reply;
import leasecity.dto.etc.Page;

@Repository
public class ReplyRepoImpl implements ReplyRepo {

	// Sql쿼리를 작동시키는 SessionTemplate Bean
	@Autowired
	SqlSessionTemplate session;

	// mapper연동용 문자열 코드 - 게시글
	private final String REPLY_NS = "leasecity.repo.replyRepo.";

	@Override
	public Integer getCountCommentReply(Integer commentNo) {
		String stmt = REPLY_NS + "getCountCommentReply";
		return session.selectOne(stmt, commentNo);
	}

	@Override
	public List<Reply> getPageReplys(Page page) {
		String stmt = REPLY_NS + "getPageSelectReply";
		return session.selectList(stmt, page);
	}

	@Override
	public int insertReply(Reply reply) {
		String stmt = REPLY_NS + "insertReply";
		return session.insert(stmt, reply);
	}

	@Override
	public int deleteReply(Reply reply) {
		String stmt = REPLY_NS + "deleteReply";
		return session.delete(stmt, reply);
	}

	@Override
	public int updateReply(Reply reply) {
		String stmt = REPLY_NS + "updateReply";
		return session.update(stmt, reply);
	}

}
