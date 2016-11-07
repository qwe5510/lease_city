<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="leasecity.util.DateUtil"%>
<%@page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LEASE CALL | LEASE CITY</title>

<c:if test="${!empty lease_message }">
	<script>
		alert('${lease_message }');
	</script>
</c:if>

<%
	Date todayDate = new Date();
	String today = DateUtil.getDateString(todayDate);
	request.setAttribute("today", today);
%>

</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<c:url value="/lookupHeavy" var="lookupHeavy"></c:url>
	<div class="lease">
		<div class="lease_menu">
			<div class="lease_menu_inner"></div>
		</div>
		<ul class="lease_menu_ul">
			<li class="lease_menu_first"><a id="lease_call"><img id="lease_call_img" src="<%=request.getContextPath()%>/images/lease/lease_menu2_1.png"></a></li>
			<li><a id="lease_lookup" href="${lookupHeavy}"><img id="lease_lookup_img" src="<%=request.getContextPath()%>/images/lease/lease_menu3.png"></a></li>
		</ul>				
		<div class="lease_main">
			<table class="lease_table">
				<tr>
					<td colspan="6" class="boardLine" style="height: 4px !important;"></td>
				</tr>
				<tr class="notify">
					<td class="td1">신용도</td>
					<td class="td2">분류</td>
					<td class="td3">제목</td>
					<td class="td4">글쓴이</td>
					<td class="td5">조회수</td>
					<td class="td6">날짜</td>
				</tr>
				<c:forEach var="leaseCall" items="${leaseCalls}">
               <tr>
                  <td colspan="6" class="boardLine" style="height: 4px !important;"></td>
               </tr>
               <tr class="boardShow">
               
               <fmt:formatNumber value="${leaseCall.tempGrade/5}" var="creditPercent" type="percent"></fmt:formatNumber>
               <fmt:formatNumber value="${leaseCall.tempGrade}" pattern="0.00" var="credit"></fmt:formatNumber>
                  <td>
                  <div class="credit-min-area">
                  <i class="credit-max-area" style="width: ${creditPercent}"></i>
                  </div>
                  <strong>${credit}</strong>
                  </td>
                  <td>
                  ${leaseCall.leaseCategory}<br>
                  ${leaseCall.equipmentCategory}
                  </td>
                  <td class='leaseCallTitle'>
	                 <a href="<%=request.getContextPath() %>/leaseCall/read?leaseCallNo=${leaseCall.leaseCallNo}">
                     	${leaseCall.leaseCommentTitle}
                     </a>
	                 
                     <c:if test="${leaseCall.hits >= 100}">
                     	<span class="label label-important">
                     		hot
                     	</span>
                     </c:if>
                     
                     <c:if test="${!(leaseCall.choiceLRCount eq 0)}">
                     	<span class="label label-success">
                     		선발 : ${leaseCall.choiceLRCount}
                     	</span>
                     </c:if>
                     
                     <c:if test="${!(leaseCall.standByLRCount eq 0)}">
                     	<span class="label label-warning">
                     		대기 : ${leaseCall.standByLRCount}
                     	</span>
                     </c:if>
                     
                  </td>
                  <td>${leaseCall.companyName}</td>
                  <td>${leaseCall.hits}</td>               
                  
                  <fmt:formatDate value="${leaseCall.regDate}"
                        pattern="yyyy-MM-dd"
                        var="strRegDate"/>
                  
                  <fmt:formatDate value="${leaseCall.regDate}"
                        pattern="hh:mm:ss"
                        var="strRegTime"/>
                  
                  <c:choose>
                  <c:when test="${strRegDate eq today}">
                     <td><c:out value="${strRegTime}" /></td>
                  </c:when>
                  <c:otherwise>
                     <td><c:out value="${strRegDate}" /></td>
                  </c:otherwise>
                  </c:choose>                           
               </tr>
            </c:forEach>
            
            <!-- 페이지가 아무것도 없을 시 출력 -->
            <c:if test="${empty page.totalPage and !empty errorMsg}">
               <tr>
                  <td colspan="6"><c:out value="${errorMsg}"></c:out></td>
               </tr>
            </c:if>
            
				<tr>
					<td colspan="6" class="boardLine" style="height: 4px !important;"></td>
				</tr>
				
			</table>
			
			
				<div style="float: left;">
					<a href="#" id="morePage" class="icon-plus"> 더 보기</a>
				</div>
				
				<div class="board_write">
					<c:url value="/leaseCall/write" var="leaseCallWrite"/>
					<a href="${leaseCallWrite}"><button><i class="icon-pencil"></i>글작성</button></a>
				</div>
			<div class="boardSearch">
				<div class="boardBottom">
				<c:url value="/leaseCall" var="leaseCall"></c:url>
				<sform:form action="${leaseCall}" method="get" modelAttribute="page">
                     <sform:select path="search">
                        <sform:option value="AUTHOR">글쓴이</sform:option>
                        <sform:option value="TITLE">제목</sform:option>
                        <sform:option value="ADDRESS">지역</sform:option>
                        <sform:option value="CATEGORY">임대,차량</sform:option>
                     </sform:select>
                     <sform:input path="keyword" placeholder="검색어를 입력해주세요."/>
                     <button id="boardBtn"><i class="icon-search"></i>검색</button>
                 </sform:form>
                  </div>
         	</div>
		</div>
	</div>	
	<jsp:include page="../layout/footer.jsp"></jsp:include>	
</body>


<!-- 페이지 펼치기 -->
<script src="http://code.jquery.com/jquery.js"></script>
<script>

<c:url value="/images/lease/lease_menu3_1.png" var="lookupHeavyHover"></c:url>
<c:url value="/images/lease/lease_menu3.png" var="lookupHeavyNormal"></c:url>
<c:url value="/images/lease/lease_menu2_1.png" var="leaseCallHover"></c:url>
<c:url value="/images/lease/lease_menu2.png" var="leaseCallNormal"></c:url>
	$("#lease_lookup").hover(
			function(){
				$("#lease_call_img").attr("src", "${leaseCallNormal}")
				$("#lease_lookup_img").attr("src", "${lookupHeavyHover}");
			},
			function(){
				$("#lease_call_img").attr("src", "${leaseCallHover}")
				$("#lease_lookup_img").attr("src", "${lookupHeavyNormal}");
			});
	
	var g_currentPage = 1;
	
	Date.prototype.format = function(f) {
	    if (!this.valueOf()) return " ";
	 
	    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
	    var d = this;
	     
	    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
	        switch ($1) {
	            case "yyyy": return d.getFullYear();
	            case "yy": return (d.getFullYear() % 1000).zf(2);
	            case "MM": return (d.getMonth() + 1).zf(2);
	            case "dd": return d.getDate().zf(2);
	            case "E": return weekName[d.getDay()];
	            case "HH": return d.getHours().zf(2);
	            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
	            case "mm": return d.getMinutes().zf(2);
	            case "ss": return d.getSeconds().zf(2);
	            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
	            default: return $1;
	        }
	    });
	};
	 
	String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
	String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
	Number.prototype.zf = function(len){return this.toString().zf(len);};

	<c:url value="/moreCallPageAjax" var="moreCallPage"></c:url>
	$("#morePage").on("click", function(e){
		e.preventDefault();	
		
		$.ajax({
			url:"${moreCallPage}",
			method:"GET",
			data: {
				currentPage : ++g_currentPage,
				search : "${page.search}",
				keyword : "${page.keyword}"
			},
			success: function(map){
				
				var leaseCallList = map.leaseCalls;
				
				var str="";
				
				$(leaseCallList).each(function(idx, leaseCall){
					
					var creditPercent = (leaseCall.tempGrade/5 * 100);
                    var credit = leaseCall.tempGrade.toFixed(2);
                    
					str+= "<tr class='boardShow'><td><div class='credit-min-area'>";
					str+= "<i class='credit-max-area' style='width:"+ creditPercent + "%'></i>";
					str+= "</div><strong>"+credit+"</strong></td>";
					str+= "<td>"+leaseCall.leaseCategory+"<br>"+leaseCall.equipmentCategory+"</td>";
					str+= "<td class='leaseCallTitle'>";					
					str+= "<a href='<%=request.getContextPath() %>/leaseCall/read?leaseCallNo="+ leaseCall.leaseCallNo + "'>";
					str+= leaseCall.leaseCommentTitle + "</a>";
					
					if(leaseCall.hits >= 100){
						str+= "<span class='label label-important'>";
						str+= "hot</span>";
					}
					
					if(leaseCall.choiceLRCount > 0){
						str+= "<span class='label label-success' style='margin-left: 5px'>";
						str+= "선발 : " + leaseCall.choiceLRCount + "</span>";
					}
					if(leaseCall.standByLRCount > 0){
						str+= "<span class='label label-warning' style='margin-left: 5px'>";
						str+= "대기 : " + leaseCall.standByLRCount + "</span>";
					}
							
					
					str+= "</td><td>"+leaseCall.companyName+"</td>";
					str+= "<td>"+leaseCall.hits+"</td><td>";
					
					var leaseCallDate = new Date(leaseCall.regDate).format("yyyy-MM-dd");
					var leaseCallTime = new Date(leaseCall.regDate).format("hh:mm:ss");
					
					if(leaseCallDate == "${today}"){
						str+=leaseCallTime;
					}else{
						str+=leaseCallDate;
					}
					
					str+= "</td></tr>";
					str+= "<tr><td colspan='6' class='boardLine' style='height: 4px !important;'></td></tr>";
				});
			
				$(".lease_table").append(str);
				
				var totalCount = map.pageCount;
				var nextCount = map.pageSize*g_currentPage+1;
				
				if(totalCount < nextCount){
					$("#morePage").css("display", "none");
				}

			},
			error: function(xhr, status, error){
				alert("더 이상 불러올 요청이 없습니다.");
			}			
		})
	});
</script>

</html>

