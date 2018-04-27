<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file = "/WEB-INF/view/template/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="${pageContext.request.contextPath}/js/jquery.tablesorter/jquery.tablesorter.js"></script>
<script src="http://code.jquery.com/jquery-3.2.1.js"></script>
<script src ="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<style>
    .table > thead > tr > th {
		text-align: center;	
	}
	.title {
		text-align: center;
	}
</style>

<script>
	function checkauth(auth) {
		if(auth!='관리자') {
			swal({
				text: "일반회원은 글쓰기를 할 수 없습니다.",
				type: 'warning',
				showCancelButton: true,
				confirmButtonColor : '#3085d6',
			}).then(function(){
				location.href="<c:url value="/"/>";
			})
		}else {
			location.href="bwrite";
		}
	}
</script>

<div class="container" style="margin-top: 90px;">
	<div class="row text-center" style="margin-bottom: 100px;">
 		<h1>공지 사항</h1>
 	</div>
    <div class="row">
        <table class="table">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성일</th>
                    <th>작성자</th>
                    <th>조회수</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="list" items="${list}">
                	<tr>
	                    <td class="title">${list.no}</td>
	                    <td width="50%">
	                    	<a href="binfo?no=${list.no}&auth=관리자">${list.title2}</a>
	                    </td>
	                    <td class="title">${list.reg}</td>
	                    <td class="title">${list.name}</td>
	                    <td class="title">${list.read}</td>
                	</tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <div class="row pull-right">
    	<c:choose>
    		<c:when test="${auth!='관리자'}">
    			<input type="button" class="btn btn-primary" value="글쓰기" style="display: none;">
    		</c:when>
    		<c:otherwise>
    			<input type="button" class="btn btn-primary" value="글쓰기" 
    					onclick="location.href='<c:url value="/bwrite"/>'">
    		</c:otherwise>
    	</c:choose>
	</div>
    
    
    <div class="row text-center">
	   	<nav>
	        <ul class="pagination">
	            <li>
	                <c:if test="${startBlock>1}">
	                    <a href="not?page=${startBlock-1}" aria-label="Previous">
	                        <span aria-hidden="true">&laquo;</span>
	                    </a>
	                </c:if>
	            </li>
	            <c:forEach var="i" begin="${startBlock}" end="${endBlock}" step="1">
	                <c:choose>
	                    <c:when test="${i == pageNo}">
	                        <li><a href="#">${i}</a></li>
	                    </c:when>
	                    <c:otherwise>
	                        <li><a href="not?page=${i}">${i}</a></li>
	                    </c:otherwise>
	                </c:choose>
	            </c:forEach>
	            <c:if test="${endBlock < blockTotal}">   
	                <li>
	                    <a href="not?page=${endBlock+1}" aria-label="Next">
	                        <span aria-hidden="true">&raquo;</span>
	                    </a>	
	                </li>
	             </c:if>
	        </ul>
		</nav>
	</div>

<%@ include file = "/WEB-INF/view/template/footer.jsp" %>