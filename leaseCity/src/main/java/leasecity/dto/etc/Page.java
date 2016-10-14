package leasecity.dto.etc;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Page {
	
	//게시글 총 갯수.
	public Integer totalCount;
	//총 페이지 갯수 = 전체 게시글 갯수 / 페이지 당 갯수 
	public Integer totalPage;
	//페이지 크기
	public Integer pageSize;
	
	
	
	/**
	 * 게시판 기능을 제공하는 목록
	 * 임대
	 * 커뮤니티
	 * Q&A
	 * 중기업체 조회
	 */
	public String serviceKind; 
	
	/**
	 * 검색 조건을 명시하는 멤버
	 * NORMAL : 없음
	 * TITLE : 제목으로 검색 
	 * COMPANY_NAME : 업체명(글쓴이)
	 * TITLE_AND_CONTENT : 제목+내용으로 검색
	 * LOCAL : 지역명으로 검색
	 */
	public String search;
	
	
	/**
	 * 검색어가 들어가는 변수.
	 */
	public String keyword;
	
	/**
	 * 정렬방식 (날짜에 대한 정렬만 함)
	 * ASC : 오름차순 
	 * DESC : 내림차순
	 */
	public String order;
	
}
