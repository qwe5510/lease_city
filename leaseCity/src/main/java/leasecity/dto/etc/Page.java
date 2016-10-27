package leasecity.dto.etc;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class Page {
	
	//게시글 총 갯수.
	private Integer totalCount;
	//총 페이지 갯수 = (전체 게시글 갯수 / 페이지 당 갯수) + 1
	private Integer totalPage;
	
	//각 기능의 덧글에서만 사용됨
	private Integer superNo;
	//현재 페이지
	private Integer currentPage;
	//페이지 크기
	private Integer pageSize;
	
	
	
	/**
	 * 게시판 기능을 제공하는 목록
	 * 임대 : LEASE
	 * 커뮤니티 : COMMUNITY
	 * Q&A : Q_AND_A
	 * 중기업체 조회 : HE_SELECT
	 */
	private String serviceKind; 
	// 총괄검색에서 사용하는 기능.
	
	/**
	 * 검색 조건을 명시하는 멤버
	 * TITLE : 제목으로 검색 (기본값) 
	 * COMPANY_NAME : 업체명으로 검색
	 * TITLE_AND_CONTENT : 제목+내용으로 검색
	 * LOCAL : 지역명으로 검색
	 */
	private String search;
	
	
	/**
	 * 검색어가 들어가는 변수.
	 * 공백(' ')을 ('%')로 변환 후 LIKE를 이용항 쿼리를 돌림.
	 */
	private String keyword;
	
	/**
	 * 정렬방식 (날짜에 대한 정렬만 함)
	 * ASC : 오름차순 
	 * DESC : 내림차순 (기본값)
	 */
	private String order;
	
	/**
	 * TO : ~까지
	 * FROM : ~부터
	 */
	private Integer to;
	private Integer from;
	
	public Page(String search, String keyword){
		this.search = search;
		this.keyword = keyword;
	}
	
	// From과 To
	public void setFromTo() {
		this.from = (this.currentPage-1)*this.pageSize+1;
		this.to = (this.from-1)+this.pageSize;
	}
	
}
