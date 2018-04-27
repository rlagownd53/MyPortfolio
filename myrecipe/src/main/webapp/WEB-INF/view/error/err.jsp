<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="http://code.jquery.com/jquery-3.2.1.js"></script>
<script src ="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script>
	$(document).ready(function(){
		swal({
			text: "옳지 않은 경로이거나 서버에서 오류가 발생했습니다",
			type: 'warning',
			showCancelButton: true,
			confirmButtonColor : '#3085d6',
		}).then(function(){
			location.href="<c:url value='/'/>";
		});	
	});
</script>


