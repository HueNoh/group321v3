<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<title>Board</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet" href="/resources/css/style.css">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<style>
#addBoard, .createBoard, .board {
	width: 150px;
	height: 150px;
	margin: 5px;
	border: 1px solid black;
	float: left;
}

#content {
	height: 100%;
	padding-top: 100px;
}
</style>
<script>
	var sessionId = '${sessionScope.id}';
	var createDiv = '';
	var webSocket = new WebSocket('ws://211.183.8.14/socket');
	webSocket.onopen = function(event) {
		onOpen(event)

	};
	webSocket.onclose = function() {
		onClose()
	};
	webSocket.onerror = function(event) {
		onError(event)
	};
	webSocket.onmessage = function(event) {
		onMessage(event)

	};
	function onMessage(event) {
		var spMsg = event.data;
		var arrMsg = spMsg.split("::");
		var id = arrMsg[0];
		var msg = arrMsg[1];
		var access = arrMsg[2];

		if ("boardCreate" == access) {
			if (id != sessionId) {
				createDiv += msg;
				$('#' + id).html(createDiv);
			}
		}
	}
	function onOpen(event) {

	}
	function onError(event) {
		alert(event.data);
	}

	function onClose() {

	}

	function send(message, acc, id) {
		console.log('efsef: ' + message);
		var msg = {
			"userId" : id,
			"msg" : message,
			"access" : acc,
			"create" : 'board'
		}

		if ("boardCreate" == acc) {
			var jsonStr = JSON.stringify(msg);
			webSocket.send(jsonStr);
		}
	}
	window.onload = function() {
		$.ajax({
			url : '/main/searchBoard',
			method : 'post',
		}).done(function(msg) {
			var jArr = JSON.parse(msg);
			$.each(jArr, function(i) {
				var b_num = jArr[i].b_num;
				var div = document.createElement('div');
				var text = '';
				div.id = 'board' + b_num;
				div.className = 'board';

				var aTag = document.createElement('a');
				var createAText = document.createTextNode('프로젝트' + b_num);

				aTag.setAttribute('href', '/main/list?b_num=' + b_num);
				aTag.appendChild(createAText);
				div.appendChild(aTag);

				document.getElementById('viewBoard').appendChild(div);

			});

		});

	};

	function addBoard() {
		$.ajax({
			method : 'post',
			url : '/main/createBoard',
			data : {
				id : '${sessionScope.id}',
				title : 'testTitle'
			}

		}).done(function(msg) {

			var arrBoard = JSON.parse(msg);

			var div = document.createElement('div');
			div.id = 'board' + arrBoard.b_num;
			div.className = 'board';

			var aTag = document.createElement('a');
			var createAText = document.createTextNode('프로젝트' + arrBoard.b_num);

			aTag.setAttribute('href', '/main/list?b_num=' + arrBoard.b_num);
			aTag.appendChild(createAText);
			div.appendChild(aTag);

			
			
			document.getElementById('createBoard').appendChild(div);
			
			var boardHtml = $('#board' + arrBoard.b_num)[0].outerHTML;
			send(boardHtml, 'boardCreate', 'createBoard');
			
		});
	}
</script>
</head>
<body>
	<header id="header" class="clearfix">
		<a href="/main/board"><h1>PROJECT 321</h1></a> <a href="#"
			class="btn_board"><span>Boards</span></a>
		<form action="#" method="post" id="sch_main_wrap">
			<fieldset>
				<input type="text" name="sch_main" id="sch_main">
			</fieldset>
			<a href="#"><span class="btn_ico_sch"></span></a>
		</form>
	</header>
	<div style="position: fixed; height: 50px; margin-top: 50px;">dd</div>
	<div id="content">
		<div id="viewBoard"></div>
		<div id="createBoard"></div>
		<div id="addBoard" onclick="addBoard();">Create</div>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
</body>
</html>