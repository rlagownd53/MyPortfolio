<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file= "/WEB-INF/view/template/header.jsp" %>
<link rel="stylesheet" type="text/css" href="/recipe/css/main.css">


<html>
<head>
    <title>Menu List</title>
    <style>
        div{
            align-content: center;
            text-align: center;
            border: 1px;
            border-color: darkgreen;
            border-style: solid;
        }
        .menu_grid{
            width: 800px;
            height: auto;
            border: 1px;
            border-color: red;
            border-style: dotted;
        }
        .menu_item{
            width: 150px;
            height: 200px;
            background-color: darkgray;
            display: inline-block;
        }
        .admin_option{
            width: 200px;
            height: 50px;
            background-color: aqua;
        }
    </style>
</head>
<body>
    <div>
        <h1>Menu List !</h1>
        <div>
            <div class="admin_option" align="right">
              	  관리자 옵션 
              	 <a href="menuAdd"><input type="button" value="메뉴 추가"></a>
            </div>
            <div class="menu_grid center">
                <div class="menu_item">
                    <h4>메뉴 명 : 김치볶음밥</h4>
                    <h4>메뉴 가격 : 7,000원</h4>
                </div>
                <div class="menu_item">
                    <h4>메뉴 명 : 소고기볶음밥</h4>
                    <h4>메뉴 가격 : 8,000원</h4>
                </div>
                <div class="menu_item">
                    <h4>메뉴 명 : 갈릭스팸볶음밥</h4>
                    <h4>메뉴 가격 : 7,500원</h4>
                </div>
                <div class="menu_item">
                    <h4>메뉴 명 : 제육볶음밥</h4>
                    <h4>메뉴 가격 : 7,500원</h4>
                </div>
            </div>
            
<!--            	반복 출력 가능토록 구현예정 -->
            <div class="menu_grid">
               <c:forEach var="list" items="${mdto}">
					<tr>
						<td>${mdto.name}</td>
						<td>${mdto.price}</td>
					</tr>
				</c:forEach>
            </div>
        </div>
    
    </div>
    
    
</body>
</html>



<%@ include file= "/WEB-INF/view/template/footer.jsp" %>