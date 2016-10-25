package leasecity.repo.adminwork;

import leasecity.dto.user.User;

public interface AdminRepo {
	
	public User getNotAdmin(String userId);
	
	public int deleteCommunityComment(Integer commentNo);
	
	public int deleteCommunityReply(Integer replyNo);
	
	public int deleteQuestion(Integer commentNo);
	
	public int deleteAnswer(Integer replyNo);
	
}
