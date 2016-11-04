package leasecity.repo.user;

import java.util.List;

import leasecity.dto.user.Credit;

public interface CreditRepo {
	
	/**
	 * 평가받은 유저의 아이디로 검색한 신용도평가 리스트 
	 * @param acceptUserId
	 * @return
	 */
	public List<Credit> getSelectAcceptCredits(String acceptUserId);
	
	/**
	 * 평가 한 유저의 아이디로 검색한 신용도 평가 리스트의 개수
	 * @param sendUserId
	 * @return
	 */
	public Integer getCountSendCredits(String sendUserId);

}
