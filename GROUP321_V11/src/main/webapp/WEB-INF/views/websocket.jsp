<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=utf-8"%>
<link rel="stylesheet" href="/resources/css/websocket.atj.css">
<div class="chatBoard">
	<div id="user"></div>
	<div id="dis">
		<div class="dis display"></div>
		<div class="dis inputMsg">
			<textarea id="inputMessage" style="width: 100%; height: 100%;"
				type="text"></textarea>
		</div>
		<div class="dis sub">
			<input type="submit" style="width: 100%; height: 100%;" value="send"
				onclick="send()" />
		</div>
	</div>
</div>

<script type="text/javascript">
	var inputMessage = document.getElementById('inputMessage');

	var sessionId = '${sessionScope.id}';

	var html = '';
	var userHtml = '';

	function onMessage(event) {

		var spMsg = event.data;
		var arrMsg = spMsg.split(":");
		var id = arrMsg[0];
		var msg = arrMsg[1];
		var access = arrMsg[2];
		var b_num = arrMsg[3];

		if ("message" == access) {
			if (id == sessionId) {

				html = '<div class="dis myMsg">'
						+ '<img src="#" onclick="profile(\'' + id + '\');"/>'
						+ msg + '<br/>' + id + '</div>';
			} else {

				html = '<div class="dis memberMsg">'
						+ '<img src="#" onclick="profile(\'' + id + '\');"/>'
						+ msg + '<br/>' + id + '</div>';

				alert(msg);
			}

			console.log(chatOnOff);

			$('.display').append(html);
			$('.display').append('<br><br><br>');
			$('.display').scrollTop($('.display')[0].scrollHeight);

		} else if ("open" == access) {
			if (b_num == '${b_num}') {

				/*
				새로 접속한 클라이언트의 아이디를 서버로부터 전송받아
				userHtml에 값을 넣은 후 기존 div담긴 값을 지우고 userHtml값을
				새로 세팅하여 표시
				 */

				var userArr = userHtml.split('<br/>');
				var censor = true;

				/*
				userHtml에 저장되잇는 아이디들 중 새로 동일한 아이디가 있을경우를
				체크하여 중복되지 않게 처리.
				 */
				$.each(userArr, function(i) {
					if (id == userArr[i]) {
						censor = false;
					}
				});
				if (censor) {
					if (b_num == '${b_num}') {
						userHtml += id + '<br/>';
						$('#user').empty();
						$('#user').append(userHtml);
					}
				}
			}

		} else if ("close" == access) {
			if (b_num == '${b_num}') {
				userHtml = '';
				userHtml += id + '<br/>';
				$('#user').empty();
				$('#user').append(userHtml);
			}
		}

	}
	function profile(getId) {

		window.open('person/profile?profileId=' + getId, '',
				'width=400, height=300, left=500, top=400');
	}
	function onOpen(event) {
		console.log('open');

		$.ajax({
			method : 'post',
			url : '/chat/viewMsg',
			data : {
				b_num : '${b_num}'
			}
		}).done(
				function(json) {

					/* 
					새로 접속한 클라이언트의 정보를 서버에 전송.
					 */
					var info = {
						"userId" : sessionId,
						"msg" : 'open',
						"access" : 'open',
						"b_num" : '${b_num}'
					}
					var jsonStr = JSON.stringify(info);
					webSocket.send(jsonStr);

					/* 
					접속시 DB에 저장되있던 이전 데이터들을 SELECT하여
					화면에 뿌려준다
					 */
					var jObj = JSON.parse(json);
					var jArr = jObj.msg;
					var juArr = jObj.userId;
					var jSize = jObj.size;

					$.each(jArr, function(i) {
						if (jArr[i].id == sessionId) {
							html = '<div class="dis myMsg">'
									+ '<img src="#" onclick="profile(\''
									+ jArr[i].id + '\');"/>' + jArr[i].msg
									+ '<br/>' + jArr[i].id + '</div>';

						} else {
							html = '<div class="dis memberMsg">'
									+ '<img src="#" onclick="profile(\''
									+ jArr[i].id + '\');"/>' + jArr[i].msg
									+ '<br/>' + jArr[i].id + '</div>';
						}

						$('.display').append(html);

						$('.display').append('<br><br><br>');
					});
					$(".display").scrollTop($(".display")[0].scrollHeight);

					/* 
					새로 접속한 클라이언트에게 이전에 접속해있는 클라이언트들의
					아이디를 받아오는 메서드.
					접속한 유저의 id들의 값을 저장하고있는 juArr의 사이즈에서
					새로 접속한 클라이언트의 id값을 제외한 다른 클라이언트의
					id를 div에 뿌린다.
					 */
					var size = jSize.size - 1;

					for (var i = 0; i < size; i++) {
						if ('${b_num}' == juArr[i].b_num) {

							userHtml += juArr[i].userId + '<br/>';
						}

					}
					$('#user').append(userHtml);

				});

	}

	function onError(event) {
		alert(event.data);
	}

	function onClose(event) {

		alert('close');

	}

	function send() {

		var message = inputMessage.value;
		var msg = {
			"userId" : sessionId,
			"msg" : message,
			"access" : 'message',
			"b_num" : '${b_num}'
		}

		var jsonStr = JSON.stringify(msg);
		$.ajax({
			method : 'post',
			url : '/chat/chatMsg',
			data : {
				JSON : jsonStr

			}

		}).done(function(msg) {

			var jObj = JSON.parse(msg);
			if ('001' == jObj.error) {
				webSocket.send(jsonStr);
				$('#inputMessage').val('');
				$('#inputMessage').focus();
			} else {
				console.log('error');
			}

		});

	}
</script>
