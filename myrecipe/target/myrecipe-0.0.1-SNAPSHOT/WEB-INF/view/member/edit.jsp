<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>  
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>정보 수정 페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
    <!-- Bootstrap -->
</head>
  <body>
  <nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
      <a class="navbar-brand" href="#">MyRecipe</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item active">
            <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Link</a>
          </li>
          <li class="nav-item">
            <a class="nav-link disabled" href="#">Disabled</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="http://example.com" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Dropdown</a>
            <div class="dropdown-menu" aria-labelledby="dropdown01">
              <a class="dropdown-item" href="#">Action</a>
              <a class="dropdown-item" href="#">Another action</a>
              <a class="dropdown-item" href="#">Something else here</a>
            </div>
          </li>
        </ul>
        <form class="form-inline my-2 my-lg-0">
          <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>
      </div>
    </nav>
  
      <article class="container"  style="margin-top: 5%">
        <div class="page-header">
          <h1>정보 수정 <small>edit page</small></h1>
        </div>
        <div class="col-md-6 col-md-offset-3">
          <form role="form" action="#" method="post">
            <div class="form-group">
              <label for="InputEmail">이메일 주소</label>
              <input name="email" type="email" class="form-control" id="InputEmail" placeholder="gksrldydsla@naver.com" required>
            </div>
            <div class="form-group">
              <label for="InputPassword1">비밀번호</label>
              <input name="pw" type="password" class="form-control" id="InputPassword1" placeholder="변경할 비밀번호 입력">
            </div>
            <div class="form-group">
              <label for="username">이름</label>
              <input name="name" type="text" class="form-control" id="username" placeholder="한기용" required>
            </div>
            <div class="form-group">
              <label for="username">전화번호 입력</label>
                 </div>
              <div class="form-group">
                <input name="phone" type="tel" class="form-control" id="username" placeholder="01089029664">
              </div>
              <label for="username">주소 입력</label>
              <div class="form-group">
                <input name="post" type="text" class="form-control" id="username" placeholder="444-444">
              </div>
                    <div class="form-group">
                <input name="addr1" type="text" class="form-control" id="username" placeholder="서울 금천구">
              </div>
                    <div class="form-group">
                <input name="addr2" type="text" class="form-control" id="username" placeholder="아이티 뱅크">
              </div>
                
            <div class="form-group text-center">
              <button type="submit" class="btn btn-info">정보 수정<i class="fa fa-check spaceLeft"></i></button>
              <button type="submit" class="btn btn-warning">취소<i class="fa fa-times spaceLeft"></i></button>
            </div>
          </form>
          <hr> </div>
      </article>

 <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
  
  </body>
</html>
