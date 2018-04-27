<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/template/header.jsp"%>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script type="text/javascript">
    $(function() {
        $("input[type='file']").on('change', function(){
//            alert(this.name);  //선택한 input 네임 표시
//            alert(this.value); //선택한 이미지 경로 표시
            readURL(this);
        });
    });

    function readURL(input) {
        if (input.files && input.files[0]) {
        var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
        reader.onload = function (e) {
        //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
                $('#blah').attr('src', e.target.result);
                 //이미지 Tag의 SRC속성에 읽어들인 File내용을 지정
                //(아래 코드에서 읽어들인 dataURL형식)
            }
          reader.readAsDataURL(input.files[0]);
        //File내용을 읽어 dataURL형식의 문자열로 저장
        }
    }
</script>
<style>
	input #menuinput{width: "120px";}
</style>
<div class="container" style="margin-top: 80px;">
   <div class="col-md-12"> 
         <div class="text-center">
            <h1>상품 등록 화면</h1>
         </div>
         <div class="col-md-6 center-block" style="float: unset;">
         <form id="madd" action="madd?${_csrf.parameterName}=${_csrf.token}" method="POST" enctype="multipart/form-data">
            <div class="col-md-12 form-group">
               <div class="col-md-6">
                  <img id="blah" src="http://via.placeholder.com/150x150" height="150" width="150">
               </div>
               <div class="col-md-6">
                  <a>메인 : <input type="file" id="menuinput" name="mainimg" accept="image/gif, image/jpeg, image/png" required></a> 
                  <a>재료 : <input type="file" id="menuinput" name="foodimg" accept="image/gif, image/jpeg, image/png" required></a> 
                  <a>레시피 : <input type="file" id="menuinput" name="recipeimg" accept="image/gif, image/jpeg, image/png" required></a>
               </div>
            </div>
               <table class="table table-striped table-hover">
                  <tbody class="text-center">
                     <tr>
                        <th>메뉴 명 :</th>
                        <th><input type="text" id="menuinput" name="name" required></th>
                     </tr>
                     <tr>
                        <th>메뉴 종류 :</th>
                        <th><input type="radio" id="menuinput" name="type" value="밥" checked="checked">밥 
                           <input type="radio" id="menuinput" name="type" value="찌개">찌개 
                           <input type="radio" id="menuinput" name="type" value="국">국</th>
                     </tr>
                     <tr>
                        <th>가격 :</th>
                        <th><input type="number" id="menuinput" name="price" required></th>
                     </tr>
                     <tr>
						<th>판매 수량 :</th>
						<th><input type="number" id="menuinput" name="stock" required></th>
                     </tr>
                     <tr>
                        <th>옵션1 :</th>
                        <th><input type="text" id="menuinput" name="op1_name" placeholder="고기 추가" value=""></th>
                     </tr>
                     <tr>
                        <th>옵션1 가격 :</th>
                        <th><input type="number" id="menuinput" name="op1_price" value="0"></th>
                     </tr>
                     <tr>
                        <th>옵션2 :</th>
                        <th><input type="text" id="menuinput" name="op2_name" placeholder="야채 추가" value=""></th>
                     </tr>
                     <tr>
                        <th>옵션2 가격 :</th>
                        <th><input type="number" id="menuinput" name="op2_price" value="0"></th>
                     </tr>
                     <tr>
                        <th>옵션3 :</th>
                        <th><input type="text" id="menuinput" name="op3_name" placeholder="양념 추가" value=""></th>
                     </tr>
                     <tr>
                        <th>옵션3 가격 :</th>
                        <th><input type="number" id="menuinput" name="op3_price" value="0"></th>
                     </tr>
                     <tr>
                        <th>상태 :</th>
                        <th><input type="radio" id="menuinput" name="stat" value="판매중" checked="checked">판매중 
                           <input type="radio" id="menuinput" name="stat" value="판매중지">판매중지</th>
                     </tr>
                     <tr>
                        <th>상품 등급 :</th>
                        <th><input type="radio" id="menuinput" name="stat_grade" value="일반" checked="checked">일반 
                           <input type="radio" id="menuinput" name="stat_grade" value="인기">인기 
                           <input type="radio" id="menuinput" name="stat_grade" value="베스트">베스트</th>
                     </tr>
                  </tbody>
               </table>
               <br>
               <div align="center">
                  <input type="submit" id="menuinput" value="등록하기"> 
                  <input type="button" id="menuinput" value="취소" onclick="location.href='mmodi'">
               </div>
         </form></div>
      </div>
      
<%@ include file="/WEB-INF/view/template/footer.jsp"%>