package leasecity.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import leasecity.dto.user.User;
import leasecity.exception.RemoveFailException;
import leasecity.repo.adminwork.AdminRepo;

@Service
@Transactional
public class AdminServiceImpl implements AdminService{
	
	@Autowired
	AdminRepo adminRepo;
	
	/**
	 * 해당 id가 관리자인지 확인.
	 * @param userId
	 * @return
	 */
	public boolean isAdmin(String userId){
		//null처리
		userId = userId==null?"":userId;
		User user = adminRepo.getNotAdmin(userId);
		
		if(user == null){
			return false;
		}else{
			return true;
		}
	}
	
	/**
	 * 커뮤니티 게시글 삭제
	 * @param commentNo
	 */
	public void removeCommunityComment(Integer commentNo)
								throws RemoveFailException{
		int result = adminRepo.deleteCommunityComment(commentNo);
		
		if(result != 1){
			throw new RemoveFailException(commentNo + "번 게시글");
		}
	}
	
	/**
	 * 커뮤니티 댓글 삭제 
	 * @param replyNo
	 */
	public void removeCommunityReply(Integer replyNo)
								throws RemoveFailException{
		int result = adminRepo.deleteCommunityReply(replyNo);
		
		if(result != 1){
			throw new RemoveFailException("댓글");
		}
	}
	
	/**
	 * 질문과 답변 질문 삭제
	 * @param commentNo
	 */
	public void removeQuestion(Integer commentNo)
								throws RemoveFailException{
		int result = adminRepo.deleteQuestion(commentNo);
		
		if(result != 1){
			throw new RemoveFailException(commentNo + "번 질문글");
		}
	}
	
	/**
	 * 질문과 답변 답변 삭제
	 * @param replyNo
	 */
	public void removeAnswer(Integer replyNo)
								throws RemoveFailException{
		int result = adminRepo.deleteAnswer(replyNo);
		
		if(result != 1){
			throw new RemoveFailException(replyNo + "번 질문글");
		}
	}
	
}
