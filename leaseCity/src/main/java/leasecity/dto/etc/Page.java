package leasecity.dto.etc;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Page {
	
	//게시글 총 갯수.
	public Integer totalCount;
	//총 페이지 갯수 = 전체 게시글 갯수 / 페이지 당 갯수 
	public Integer totalPage;
	//페이지 크기
	public Integer pageSize;
	
	/**
	 * 검색 조건을 명시하는 멤버
	 * NORMAL : 일반적인 경우
	 * KEYWORD : 
	 * 
	 */
	public String keyword;
	
	//
	
}
