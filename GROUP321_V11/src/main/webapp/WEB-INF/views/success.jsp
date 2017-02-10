<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>login2</title>
 	<script src="/resources/js/login1.js"type="text/javascript"></script>  
 	<script src="/resources/js/login2.js"></script>
 	<script src="/resources/js/login3.js"></script>
 	<script src="/resources/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="/resources/css/login.css">
	<style>
		
	</style>
	  
	  
  </head>
 <body>
<form action="/login" id="log" method="post">
<div class="box">
<h2>가입을 환영합니다</h2>
<h3>로그인을 해주세요</h3>

<input type="text" name="id" placeholder="아이디" class="email" />
  
<input type="password" name="pw" placeholder="비밀번호"  class="email" />
    
<a href="login" onclick="document.getElementById('log').submit();" ><div class="btn">로그인</div></a> <!-- End Btn -->


  
</div> <!-- End Box -->
  
</form>

<!-- <p>비밀번호를 잊어먹으셨나요? <u style="color:#f1c40f;">Click Here!</u></p> -->
  

  </body>
</html>