<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>insertForm</title>
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<script src="/resources/js/login1.js"></script>
<script src="/resources/js/login2.js"></script>
<script src="/resources/js/login3.js"></script>
<link rel="stylesheet" href="resources/css/insert.css">
<style>
</style>
<script src="/resources/js/jquery-3.1.1.min.js"></script>
<script>
	var dupFlag = false;
	$(document).ready(function() {
	
		$('#dupBtn').click(function() {
			// 1. 입력값 체크
			var ID = $.trim($('#ID').val());
			
			if ('' == ID) {
				alert('아이디를 입력해주세요.');
				$('#ID').focus();
			} else {
				// 2. 중복 체크(AJAX)
				$.ajax({
					method : 'post',
					url : '/chkIdDup',
					data : {
						id : ID
					}
				}).done(function(msg) {
					
					if('-1' == msg){
						alert('사용중인 아이디입니다.');
					}else{
						// 3. 사용 여부 체크
						var use = confirm('사용하시겠습니까?');
						if(use){
							$('#ID').attr('readonly','true');
							$('#dupBtn').attr('disabled','true');
							dupFlag = true;
						}else{
							
						}
					}
				
					console.log(msg);
				
				});
			}

		});

		$('#memBtn').click(function() {

			if (!dupFlag) {
				alert('아이디 중복체크를 해주세요.');
				return false;
			}

			var PW = $.trim($('#PW').val());
			if ('' == PW) {
				alert('패스워드를 입력해주세요.');
				$('#PW').focus();
				return false;
			}

			var name = $.trim($('#name').val());
			if ('' == name) {
				alert('이름을 입력해주세요.');
				$('#name').focus();
				return false;
			}

			var isOk = confirm('정말로 가입하시겠습니까?');
			if (isOk) {
				$('#memFrm').submit();
			} else {
				return false;
			}
		});

	});
</script>

</head>



<body>
 
<div class="box">
<form method="post" id="memFrm" action="/insert">
<h1>회원가입</h1>

		
<input type="text" id="ID" name="id" placeholder="아이디" class="email"/>
<input type="password" id="PW" name="pw" placeholder="패스워드" class="email"/>
<input type="text" id="name" name="name" placeholder="이름" class="email"/>
	

<div class="btn" id="dupBtn" value="중복확인">아이디 중복확인</div> <!-- End Btn -->
<div class="btn2" id="memBtn" value="회원가입">회원가입</div><!-- End Btn2 -->

</form>
</div>



  </body>
</html>