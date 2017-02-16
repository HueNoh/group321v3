<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<title>List</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<script src="/resources/js/jquery-3.1.1.js"></script>
<link rel="stylesheet" href="/resources/css/slidebars.css">
<link rel="stylesheet" href="/resources/css/slidebars.atj.css">
<link rel="stylesheet" href="/resources/css/style.css">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/css/websocket.atj.css">
<!-- <link rel="stylesheet" href="/resources/css/jquery-ui.css"> -->
<style>
.listBorder, .addListBorder {
	width: 250px;
	height: 100%;
	margin: 5px;
	float: left;
}

.viewList, #addList {
	width: 250px;
	border: 1px solid black;
	float: left;
}

#cardReply {
	max-height: 150px;
	overflow-y: auto;
}

.list {
	width: 100%;
	max-height:; min-height : 10px;
	float: left;
	min-height: 10px; float : left;
	overflow-y: auto;
}

.list-card:hover {
	cursor: pointer;
}

.viewList .list_foot, .viewList .addCard, .viewList .list_title {
	width: 100%;
}

.list_title {
	font-weight: bold;
	text-indent: 1em;
	text-align: left;
}

#mainList {
	float: left;
}

.content {
	overflow: hidden;
}

#content, #mainList, .content {
	height: 100%;
	background-color: #257db1;
}

.g3-container {
	overflow-x: auto;
}

#content {
	height: 100%;
	padding-top: 100px;
}

.card-detail-main {
	float: left;
}

.card-detail-main>h1 {
	font-size: 50px;
	font-weight: bold;
}

.card-detail-main>h3 {
	font-size: 20px;
	font-weight: bold;
}

.card-detail-main>a:hover {
	text-decoration: underline;
	font-weight: bold;
}

.card-detail-sidebar {
	height: 600px;
	margin-top: 100px;
	float: right;
	margin-right: 10px;
}

.card-detail-sidebar>button {
	text-align: left;
	width: 200px;
	height: 40px;
	font-weight: bold;
	font-size: 20px;
	background-color: white;
	border-radius: 10px 10px;
	outline: 0;
}

.card-detail-sidebar>button>span {
	margin-left: 10px;
	margin-bottom: 3px;
	color: black;
}

.cardView {
	overflow: hidden;
}

.btn-label {
	margin-right: 15px;
	margin-bottom: 5px;
}

.btn-attachment {
	margin-right: 15px;
	margin-bottom: 4px;
}

.btn-delete {
	margin-right: 15px;
	margin-bottom: 4px;
}

.submenu_hidden {
	display: none;
}

.label_name {
	height: 40px;
	margin-top: 10px;
	display: block;
}

.submenu {
	position: relative;
	float: right;
	margin-top: 20px;
	border: 1px solid lightgray;
	box-shadow: 0px 0px 3px 3px lightslategrey;
	border-radius: 5px;
	background-color: white;
}

.submenu>li {
	margin: 0 7px 0 7px;
	border-radius: 5px;
	margin-bottom: 5px;
	width: 188px;
	height: 30px;
	cursor: pointer;
}

.submenu>li>span {
	font-size: 20px;
	font-weight: bold;
	color: black;
}

.submenu:first-child {
	text-align: center;
}
/* id=label_text */
#label_text {
	border-radius: 5px;
	margin-bottom: 5px;
	width: 188px;
	height: 30px;
}

.submenu>li:nth-child(3) {
	background-color: #CD3861;
}

.submenu>li:nth-child(4) {
	background-color: #E56D29;
}

.submenu>li:nth-child(5) {
	background-color: #FFE641;
}

.submenu>li:nth-child(6) {
	background-color: #68D168;
}

.submenu>li:nth-child(7) {
	background-color: #52E4DC;
}

.submenu>li:nth-child(8) {
	background-color: #3296FF;
}

.submenu>li:nth-child(9) {
	background-color: #6A5ACD;
}

.label_div>input {
	display: none;
	width: 40px;
	height: 20px;
	border-radius: 5px;
	border: 1px;
	box-shadow: 2px 2px 1px lightslategrey;
}

#invite {
	min-height: 50%;
	overflow-y: aute;
	background-color: #448cb7;
}

#searchUser {
	height: 5%;
	width: 100%;
}

#inUser, #resultUser {
	height: 40%;
	width: 100%;
	overflow-y: auto;
}

.user-inUsers, .user-searchUsers {
	height: 30px;
	width: calc(100% -20px);
	margin-left: 20px;
}

.searchUsers, .inUsers {
	float: left;
	width: 80%;
	float: left;
}

.inviteButton, .inUsersButton {
	float: right;
	width: 20%;
}

.list>.list-card>div {
	display: none;
	float: left;
	width: 18px;
	height: 3px;
	margin-right: 4px;
}

#popup_layer {
	width: 400px;
	height: 100px;
	padding: 2em;
	margin-bottom: 30px;
	background: #fff;
	border: solid 1px #ccc;
	position: absolute;
	top: 260px;
	left: 50%;
	margin-left: -200px;
	box-shadow: 0px 1px 20px #333;
	z-index: 999;
	display: none;
}

#attachLink {
	height: 10em;
	overflow-y: scroll;
	border: 2px solid grey;
	width: 90%;
}

.addCardContainer {
	display: none;
}

.ListDelBtn {
	display: block;
	position: absolute;
	top: 1px;
	right: 5px;
	font-weight: bold;
}
</style>
<script>
	document.onkeydown = refl;
	function refl() {
		if (event.keyCode == 116) {
			unConnect();
			location.href = '/main/board';
			return false;
		}
	}

	history.pushState(null, null, location.href);
	window.onpopstate = function(event) {
		history.go(1);
	}

	var chatOnOff = false;

	var b_num = '${b_num}';
	var webSocket = new WebSocket('ws://211.183.8.20/list');

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

	var numOfList = 0; // 전체 리스트 갯수
	var cardl_num = 0;
	var cardId = 0;
	window.onload = function() {
		var users = ${users};

		userConnection(users);
		$('#mainList').sortable(
				{
					update : function(ev, ui) {
						var result = $('#mainList').sortable('toArray');
						send('mainList', 'listMove', '${sessionScope.id}',
								'${sessionScope.b_num}', '0', '0');
						var moveData = new Object();
						var msg = '';
						for (var i = 0; i < result.length; i++) {
							if (i < (result.length - 1)) {
								msg += result[i] + ',';
							} else {
								msg += result[i];
							}

						}

						moveData = result;

						var data = JSON.stringify(moveData);
						$.ajax({
							url : '/main/moveList',
							method : 'post',
							data : {
								data : msg,
								length : result.length,
								b_num : b_num
							}
						}).done();
					}
				});

		listSearch(b_num);

		viewMsg();
		inUsers();

	};

	function setWidthOnload(num) {

		var margin = $(".listBorder").css("margin").replace('px', '');
		var borderWidth = $('.listBorder').css("borderWidth").replace('px', '');
		var listWidth = $('.listBorder').width() + margin * 2 + borderWidth * 2;
		
		var mainWidth = num * listWidth;
		var addListBorderWidth = $('.addListBorder').width() + 10;
		var contentWidth = mainWidth + addListBorderWidth;

		$('#mainList').css('width', mainWidth);
		$('.content').css('width', contentWidth);
		$('.g3-container').css('width', contentWidth);
	}

	function setWidthAddList(num) {
		var currentWidth = $('.g3-container').width();
		var margin = $(".listBorder").css("margin").replace('px', '');
		var borderWidth = $('.listBorder').css("borderWidth").replace('px', '');
		var listWidth = $('.listBorder').width() + margin * 2 + borderWidth * 2;
		var afterWidth = currentWidth + listWidth;

		var mainWidth = num * listWidth;

		$('#mainList').css('width', mainWidth);

		if (((num + 1) * listWidth) > currentWidth) {
			$('.content').css('width', afterWidth);
			$('.g3-container').css('width', afterWidth);
		}

	}

	function addList(title) {
		$.ajax({
			method : 'post',
			url : '/main/createList',
			data : {
				id : '${sessionScope.id}',
				title : title,
				b_num : b_num

			}

		}).done(
				function(msg) {

					var arrList = JSON.parse(msg);
					var id = arrList.l_num;
					//nhs
					var l_title = arrList.title;

					listView(id, l_title, arrList.l_num);

					numOfList = $('.viewList').length;
					setWidthAddList(numOfList);

					/* 각 리스트들의 카드들을 쇼터블 하는 function */
					listSortable(id);

					var listHtml = $('#mainList')[0].innerHTML;
					send('mainList', 'listCreate', '${sessionScope.id}',
							'${sessionScope.b_num}', '0', '0');

				});

	}

	function addCard(l_num, id) {
		$('#addCardContainer' + id).toggle();
		$('#addCardTitle' + id).focus();
		$('#addCardTitle' + id).val('');
		cardId = id;
		cardl_num = l_num;

	}

	function addCardDetail() {
		if ($('#addCardTitle' + cardId).val()) {
			var title = $('#addCardTitle' + cardId).val();
			$.ajax({
				method : 'post',
				url : '/main/createCard',
				data : {
					id : '${sessionScope.id}',
					title : title,
					b_num : b_num,
					l_num : cardl_num

				}
			}).done(function(msg) {
				var cardArr = JSON.parse(msg);

				var newCard = document.createElement('div');
				var c_num = cardArr.c_num;

				newCard.id = c_num;
				newCard.className = 'list-card';
				newCard.onclick = function() {
					cardView(b_num, cardl_num, c_num);

				};
				// 카드 내부의 label div 생성!!!
				for (var j = 1; j <= 7; j++) {
					var labelDiv = document.createElement('div');
					labelDiv.id = 'labelDiv' + c_num + '_' + j;
					newCard.append(labelDiv);
				}

				var createCardText = document
						.createTextNode(cardArr.title);

				newCard.appendChild(createCardText);
				document.getElementById('list' + cardId).appendChild(
						newCard);

				var cardHtml = $('#list' + cardId)[0].innerHTML;
				send('cardCreate', 'cardCreate', '${sessionScope.id}',
						'${sessionScope.b_num}', '0', '0');
				$('#addCardContainer' + cardId).toggle();
				$('#addCardTitle' + cardId).val('');
			});
		}
	}

	function cardView(b_num, l_num, c_num) {
		$('#cardReply').empty();
		$('#commentArea').val('');
		$.ajax({
			method : 'post',
			url : '/main/selectCardDetail',
			data : {
				b_num : b_num,
				l_num : l_num,
				c_num : c_num
			}
		}).done(function(msg) {
			var detail = JSON.parse(msg);

			var cardInfo = detail[0];
			var cardReply = detail[1];
			//hs
			var cardLink = detail[2];

			handelDesc(0); // description textarea 숨기기
			var content = cardInfo.content;

			var label = cardInfo.label;

			labelShow(label);

			if (null != content) {
				$('.content_div').text(content);
			} else {
				$('.content_div').text('');
			}

			$.each(cardReply, function(i) {

				createReplyDiv(cardReply[i].seq, cardReply[i].content,
						cardReply[i].m_id);

			});

			//hs
			$('#attachLink').children().empty();
			$.each(cardLink, function(i) {
				var node = document.createElement('div');
				var textNode = document
						.createTextNode(cardLink[i].content);
				var aTag = document.createElement('a');
				aTag.href = cardLink[i].content;
				aTag.appendChild(textNode);
				aTag.target = '_blank';
				node.appendChild(aTag);

				$('#attachLink').append(node);
			});

			document.getElementById('cardNum').value = c_num;

			cardModal.style.display = "block";
		});

	}

	function labelShow(label) {
		if (null == label) {
			label = "0,0,0,0,0,0,0";
		}

		var labelArr = label.split(',');

		for (var i = 1; i <= 7; i++) {
			$('#selected_label' + i).hide();
			if ('0' != labelArr[i - 1]) {
				$('#selected_label' + i).css('background-color',
						rgb2hex($('#label' + i).css("background-color")));
				$('#selected_label' + i).show();
			}
		}
	}

	function comment() {
		$.ajax({
			method : 'post',
			url : '/main/addCardReply',
			data : {

				c_key : $('#cardNum')[0].value,
				m_id : '${sessionScope.id}',
				content : $('#commentArea')[0].value
			}
		}).done(function(msg) {

			var replyInfo = JSON.parse(msg);

			createReplyDiv(replyInfo.seq, replyInfo.content, replyInfo.m_id);

			$('#commentArea').val('');

		});

	}

	function handelDesc(num) {

		$('.content_textarea').val('');

		if (num == 1) {
			$('.content_tag').hide();
			$('.content_area').show();
			$('.content_div').hide();
		} else {
			$('.content_tag').show();
			$('.content_area').hide();
		}
	}

	function sendDesc() {
		$('.content_tag').show();
		$('.content_div').show();
		$('.content_area').hide();

		var content = $('.content_textarea').val();

		$.ajax({
			method : 'post',
			url : '/main/updateContent',
			data : {
				c_key : $('#cardNum')[0].value,
				content : $('.content_textarea')[0].value
			}
		}).done(function(msg) {

			// 			if(msg == 0) {
			$('.content_div').text(content);
			// 			} else {
			// 				$('.content_div').text('');
			// 			}

		});

	}

	function createReplyDiv(seq, cnt, m_id) {

		var reply = document.createElement('div');

		reply.id = 'reply_' + seq;
		reply.className = 'card_reply';

		var content = document.createElement('div');
		var writer = document.createElement('div');

		var contentText = document.createTextNode(cnt);
		var writerText = document.createTextNode(m_id);

		content.appendChild(contentText);
		writer.appendChild(writerText);

		reply.appendChild(content);
		reply.appendChild(writer);

		$('#cardReply').prepend(reply);

	}

	function labelView() {
		// 		console.log('inside');
		// 		$('.btn_label_toggle').next("div").toggleClass('submenu_hidden');
		if ($('.btn-label-view').next("div").hasClass('submenu_hidden')) {
			$('.btn-label-view').next("div").removeClass('submenu_hidden');
			// 			$('.btn_label_toggle').next("div").show();
		} else {
			$('.btn-label-view').next("div").addClass('submenu_hidden');
			// 			$('.btn_label_toggle').next("div").hide();
		}

	}

	function getHistory() {
		$.ajax({
			method : 'post',
			url : '/main/selectHistory',
			data : {
				b_num : b_num,
				id : '${sessionScope.id}'
			}
		}).done(function(msg) {
			var history = JSON.parse(msg);
			/* 
			console.log(test11.length);
			console.log(test11);
			console.log(test11[0].content + test11[0].regdate);
			 */
			var msg = '';
			for (i = 0; i < history.length; i++) {
				msg += history[i].content + ' ' + history[i].regdate + '<br>'
				$('#selectHistory').html(msg);
			}

		});
	}

	function listView(id, l_title, l_num) {
		var div = document.createElement('div');
		div.id = 'list' + id;
		div.className = 'list';
		
		var addCardArea = document.createElement('div');
		addCardArea.className = 'addCardArea';

		var viewList = document.createElement('div');
		viewList.id = 'viewList' + id;
		viewList.className = 'viewList';

		var listBorder = document.createElement('div');
		listBorder.id = id;
		listBorder.className = 'listBorder';

		//nhs
		var list_title = document.createElement('div');
		list_title.className = 'list_title';
		list_title.innerHTML = l_title;

		var list_foot = document.createElement('div');
		list_foot.className = 'list_foot';

		var addCardDiv = document.createElement('div');
		addCardDiv.className = 'addCard';

		var addCardContainer = document.createElement('div');
		addCardContainer.id = 'addCardContainer' + id;
		addCardContainer.className = 'addCardContainer';

		var addCardTextarea = document.createElement('textarea');
		addCardTextarea.id = 'addCardTitle' + id;
		addCardTextarea.className = 'addCardTitle';
		addCardTextarea.setAttribute('style', 'width: 95%;');

		var addCardSubmit = document.createElement('input');
		addCardSubmit.id = 'addCardSubmit' + id;
		addCardSubmit.className = 'addCardSubmit';
		addCardSubmit.setAttribute('type', 'button');
		addCardSubmit.setAttribute('value', '저장');
		addCardSubmit.setAttribute('onclick', 'addCardDetail()');

		var aTag = document.createElement('a');
		var createAText = document.createTextNode('addCard');
		aTag.setAttribute('onClick', 'addCard(' + l_num + ',\'' + id + '\')');

		aTag.appendChild(createAText);

		addCardContainer.append(addCardTextarea);
		addCardContainer.append(addCardSubmit);

		addCardDiv.appendChild(aTag);
		addCardArea.append(addCardContainer);
		list_foot.append(addCardArea);
		list_foot.appendChild(addCardDiv);
		
		//리스트 삭제 버튼
		var aTagDelListBtn = document.createElement('a');
		aTagDelListBtn.className = 'ListDelBtn';
		var aTagDelListText = document.createTextNode('x');
		aTagDelListBtn.appendChild(aTagDelListText);
		aTagDelListBtn.setAttribute('href','#');
		aTagDelListBtn.setAttribute('onclick','deleteList('+b_num+','+l_num+')');
		viewList.appendChild(aTagDelListBtn);

		//nhs
		viewList.appendChild(list_title);

		viewList.appendChild(div);

		viewList.appendChild(list_foot);

		listBorder.append(viewList);

		document.getElementById('mainList').appendChild(listBorder);

		$('.list').css('max-height', $('.listBorder').height() * 0.8);
	}

	function listSearch(b_num) {
		$.ajax({
			url : '/main/searchList',
			method : 'post',
			data : {
				b_num : b_num
			}
		}).done(function(msg) {

			var listArr = JSON.parse(msg);
			$.each(listArr, function(i) {

				var l_num = listArr[i].l_num;
				var id = l_num;
				//nhs
				var l_title = listArr[i].title;

				listView(id, l_title, l_num);

				/*
				cardSearch >> 데이터베이스에 있는 해당리스트의 카드들을 불러온다.
				 */
				cardSearch(b_num, l_num, id);

			});

			numOfList = $('.listBorder').length; // 전체 viewList의 갯수 획득


			setWidthOnload(numOfList); // Onload 시 전체 width 설정

		});

	}

	function labelSet(b_num, l_num, c_num) {
		$.ajax({
			method : 'post',
			url : '/main/selectCardDetail',
			data : {
				b_num : b_num,
				l_num : l_num,
				c_num : c_num
			}
		}).done(function(msg) {

			var detail = JSON.parse(msg);
			var cardInfo = detail[0];
			var cardReply = detail[1];

			var label = cardInfo.label;

			if (label == null) {
				label = "0,0,0,0,0,0,0";
			}

			var labelArr = label.split(',');


			for (var i = 1; i <= 7; i++) {
				if ('0' != labelArr[i - 1]) {
					$('#labelDiv' + c_num + '_' + i).css(
							'background-color',
							rgb2hex($('#label' + i).css(
									"background-color")));
					$('#labelDiv' + c_num + '_' + i).show();
				}
			}
		});

	}

	function cardSearch(b_num, l_num, id) {
		
		$.ajax({
			url : '/main/searchCard',
			method : 'post',
			data : {
				b_num : b_num,
				l_num : l_num
			}
		}).done(function(msg) {
			var cardArr = JSON.parse(msg);

			$.each(cardArr, function(i) {
				var cardDiv = document.createElement('div');
				var c_num = cardArr[i].c_num;
				
				cardDiv.id = c_num;
				cardDiv.className = 'list-card';
				cardDiv.onclick = function() {
					cardView(b_num, l_num, c_num);
				};

				labelSet(b_num, l_num, c_num);

				// 카드 내부의 label div 생성!!!
				for (var j = 1; j <= 7; j++) {
					var labelDiv = document.createElement('div');
					labelDiv.id = 'labelDiv' + c_num + '_' + j;
					cardDiv.append(labelDiv);
				}

				var createCardText = document.createTextNode(cardArr[i].title);

				cardDiv.appendChild(createCardText);

				$('#list' + id).append(cardDiv);

			});
			listSortable(id);

		});

	}
	function listSortable(id) {

		$('#list' + id).sortable({
			connectWith : '.list',
			update : function(ev, ui) {
				var result1 = $('#list' + id).sortable('toArray');
				var targetId = ev.target.id;
				var parentId = ev.toElement.parentElement.id;
				var cardArr = '';

				if (targetId == parentId) {
					send('cardMove', 'cardMove', '${sessionScope.id}',
							'${sessionScope.b_num}', '0', '0');

					for (var i = 0; i < result1.length; i++) {
						if (i < (result1.length - 1)) {
							cardArr += result1[i] + ',';
						} else {
							cardArr += result1[i];
						}

					}

					$.ajax({
						url : '/main/moveCard',
						method : 'post',
						dataType : 'json',
						data : {

							b_num : b_num,
							l_num : id,
							c_num : ev.toElement.id,
							msg : cardArr,
							length : result1.length
						}

					}).done();
				}
			}
		});
	}
	function openChat() {
		chatOnOff = true;
		document.getElementById("mySidenavChat").style.width = "600px";
		closeMsg();
	}

	function closeChat() {
		chatOnOff = false;
		document.getElementById("mySidenavChat").style.width = "0";
	}

	function unConnect() {
		$.ajax({
			url : '/chat/ucConnection',
			method : 'post',
			dataType : 'json',
			data : {
				b_num : '${sessionScope.b_num}'
			}

		}).done(function(msg) {
			send('${sessionScope.id}', 'unConnec',
					'${sessionScope.id}', '${sessionScope.b_num}', '0',
					'0');
		});

	}

	//hs
	$(function() {
		//리스트 타이틀
		$('#CBContainer').css('display', 'none');
		$('#addList').click(function() {
			$('#CBContainer').toggle();
			$('#CBTitle').focus();
			$('#CBTitle').val('');
		});
		$('#CBSubmit').click(function() {
			if ($('#CBTitle').val()) {
				addList($('#CBTitle').val());
			}
		});

		//링크 등록
		$('#insertLink').click(function() {
			$('#popup_layer, #overlay_t').toggle();
			$('#insertLinkInput').focus();
			$('#insertLinkInput').val('');
			$('#popup_layer').css("top", "40%");
		});
		$('#overlay_t, .close').click(function() {
			$('#popup_layer, #overlay_t').hide();
		});
		$('#linkSubmit').click(function() {
			if ($('#insertLinkInput').val()) {
				$.ajax({
					method : 'post',
					url : '/main/insertLink',
					data : {
						c_key : $('#cardNum')[0].value,
						content : $('#insertLinkInput').val()
					}
				}).done(function(msg) {
					$('#popup_layer, #overlay_t').hide();
					var insertLink = JSON.parse(msg);

					var node = document.createElement('div');
					var textNode = document.createTextNode(insertLink.content);
					var aTag = document.createElement('a');
					aTag.href = insertLink.content;
					aTag.appendChild(textNode);
					aTag.target = '_blank';
					node.appendChild(aTag);

					$('#attachLink').prepend(node);

				});
			} else {
				$('#popup_layer, #overlay_t').hide();
			}
		});

	});
	
	//리스트삭제
	function deleteList(b_num, l_num){
		$.ajax({
			method : 'post',
			url : '/main/deleteList',
			data : {
				b_num : b_num,
				l_num : l_num
			}
		}).done(function(msg){
			var tmp = '#'+l_num+'.listBorder';
			var mainListWidth = $('#mainList').width();
			var viewListWidth = $('.viewList').width();
			if(msg==0){
				//리스트 요소 삭제
				$(tmp).remove();
				//배경 너비 삭제
				$('#mainList').css('width',mainListWidth-viewListWidth);
			}
		});
	}

	function userConnection(users) {
		$.each(users, function(i) {
			var div = document.createElement('div');
			div.id = users[i];
			div.className = 'user';

			var aTag = document.createElement('a');
			var contentText = document.createTextNode(users[i]);

			aTag.setAttribute('onclick', 'profile(\'' + users[i] + '\')');
			aTag.setAttribute('style', 'color: white; font-size: 20px');

			aTag.append(contentText);

			div.append(aTag);
			$('#user').append(div);
		});
	}

	function label(num) {
		var backgroundColor = rgb2hex($('#label' + num).css("background-color"));
		$('#selected_label' + num).css('background-color', backgroundColor);

		var labelText = $('#label_text').val();

		// 		$('#label'+num).value(labelText);
		$('#label' + num).children('span').text(labelText);

		var isNone = $('#selected_label' + num).css('display');

		$.ajax({
			method : 'post',
			url : '/main/selectLabel',
			data : {
				c_key : $('#cardNum')[0].value
			}
		}).done(function(msg) {
			var detail = JSON.parse(msg);

			var label = detail.label;

			var c_num = $('#cardNum')[0].value;

			var labelArr;
			$('#labelDiv' + c_num + '_' + num).css('background-color',
					backgroundColor);
			if ('none' != isNone) {
				labelArr = makeLabelArr(label, num, 'del');
				$('#selected_label' + num).hide();
				$('#labelDiv' + c_num + '_' + num).hide();
			} else {
				labelArr = makeLabelArr(label, num, 'ins');
				$('#selected_label' + num).show();
				$('#labelDiv' + c_num + '_' + num).show();
			}

			var tempArr = labelArr.toString();

			$.ajax({
				method : 'post',
				url : '/main/updateLabel',
				data : {
					c_key : $('#cardNum')[0].value,
					label : tempArr
				}
			}).done(function(msg) {

			});

		});
	}
	function makeLabelArr(label, num, action) {
		var backgroundColor = rgb2hex($('#label' + num).css("background-color"));

		var labelArr = label.split(',');

		if ('ins' == action) {
			labelArr[num - 1] = backgroundColor;
		} else if ('del' == action) {
			labelArr[num - 1] = 0;
		}
		return labelArr;
	}

	function rgb2hex(orig) {
		var rgb = orig.replace(/\s/g, '').match(/^rgba?\((\d+),(\d+),(\d+)/i);
		return (rgb && rgb.length === 4) ? "#"
				+ ("0" + parseInt(rgb[1], 10).toString(16)).slice(-2)
				+ ("0" + parseInt(rgb[2], 10).toString(16)).slice(-2)
				+ ("0" + parseInt(rgb[3], 10).toString(16)).slice(-2) : orig;
	}

	function openMsg() {
		var bodyHeight = document.body.offsetHeight - 150;

		document.getElementById("msgOff").style.top = bodyHeight + "px";

	}

	function closeMsg() {
		document.getElementById("msgOff").style.top = "100%";
	}
	function inviteMember() {
		document.getElementById("invite").style.width = "300px";
	}
	function closeInviteMember() {
		document.getElementById("invite").style.width = "0px";

	}

	function profile(id) {
		window.open('profile?profileId=' + id, '',
				'width=400, height=300, left=500, top=400');
	}
</script>
<jsp:include page="listWebSocket.jsp" flush="false"></jsp:include>
</head>
<body>

	<div id="msgOff" class="msgSide">
		<a href="javascript:void(0)" class="closeMsg" onclick="closeMsg();">&times;</a>
		<div id="message" onclick="openChat();"></div>
	</div>


	<header id="header" class="clearfix">
		<a href="/main/board"><h1 style="top: -10px;" onclick="unConnect();">PROJECT 321</h1></a> <a href="#" class="btn_board"> <span>Boards</span>
		</a>
		<form action="#" method="post" id="sch_main_wrap">
			<fieldset>
				<input type="text" name="sch_main" id="sch_main">
			</fieldset>
			<a href="#"><span class="btn_ico_sch"></span></a>
		</form>
		<!-- 		<button id="testDatepicker" style="width: 80px; height: 20px;"></button> -->
		<a href="#" class="js-toggle-right-slidebar">☰</a>
	</header>
	<div style="position: fixed; height: 50px; margin-top: 50px; font-size: 40px;">${title}</div>
	<div id="content">
		<div class="g3-container" canvas="container" align="right">
			<div class="content">
				<div id="mainList" class="mainList"></div>
				<div class="addListBorder">
					<div id="addList">
						<div>Create</div>
						<div id="CBContainer">
							<textarea id="CBTitle" style="width: 95%;"></textarea>
							<button id="CBSubmit">SAVE</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div off-canvas="slidebar-2 right shift" style="z-index: 9999;">
			<ul class="menu">
				<a class="menu-icon" href="#"><i class="icon-reorder"></i></a>
				<ul class="side-menu">
					<h2 class="title">Menu</h2>
					<li class="link"><a href="#" class="link_tag1">Filter</a></li>
					<li class="link" onclick="getHistory();"><a href="#" class="link_tag2" id="myBtn">History</a></li>
					<li class="link"><a href="#" onclick="openChat();" class="link_tag3 js-close-right-slidebar">Chatting</a></li>
					<li class="link"><a href="#" class="link_tag4">File</a></li>
					<li class="link"><a href="#" onclick="inviteMember()" class="link_tag5 js-close-right-slidebar">Members</a></li>
				</ul>
			</ul>
		</div>
		<div id="myModal" class="modal">
			<div class="modal-content">
				<span id="hisClose" class="close">&times;</span>
				<p id="selectHistory"></p>
			</div>
		</div>
		<div id="mySidenavChat" class="sidenav-chat" style="margin-top: 50px;">
			<jsp:include page="chat.jsp" flush="false"></jsp:include>
		</div>

		<div id="invite" class="side-invite">
			<jsp:include page="invite.jsp" flush="false"></jsp:include>
		</div>


		<div id="cardModal" class="card-modal">
			<div class="modal-content">
				<p>
					<span id="cardClose" class="close">&times;</span>
				</p>
				<div id="cardView" class="cardView">
					<div class="card-detail-main">

						<input type="hidden" id="cardNum">

						<h1>card title</h1>
						<div class="label_div">
							<input id="selected_label1" type="button" onclick="label('1')"> <input id="selected_label2" type="button" onclick="label('2')"> <input id="selected_label3" type="button" onclick="label('3')"> <input id="selected_label4" type="button" onclick="label('4')"> <input id="selected_label5" type="button" onclick="label('5')"> <input id="selected_label6" type="button" onclick="label('6')"> <input id="selected_label7" type="button" onclick="label('7')">
						</div>

						<div id="contentId">
							<!-- 					<div class="card-desc"> -->
							<!-- 							<a href="#" class="	 glyphicon-pencil content_tag"	onclick="createDescriptionDiv();">&nbsp;description...</a> -->
							<a href="#" class="	 glyphicon-pencil content_tag" onclick="handelDesc(1);">&nbsp;content...</a>
							<div class="content_div"></div>
							<div class="content_area" id="content_area">
								<div class="content_text">
									<textarea rows="10" cols="80" class="content_textarea"></textarea>
								</div>
								<div>
									<button value="SAVE" style="width: 40px; height: 30px;" onclick="sendDesc();">
										<img alt="send" src="/resources/images/btn_send.png">
									</button>
									<button value="X" style="width: 40px; height: 30px;" onclick="handelDesc(0);">
										<img alt="send" src="/resources/images/btn_cancel.png">
									</button>
								</div>
							</div>
						</div>
						<h3>Add Comment</h3>
						<textarea rows="10" cols="80" id="commentArea" required="required"></textarea>
						<input type="button" value="SAVE" onclick="comment();">
						<div id="attachLink"></div>
						<div id="cardReply"></div>
					</div>

					<div class="card-detail-sidebar">
						<button onclick="labelView();" class="btn-label-view dropdown">
							<!-- 						<input type="button" onclick="labelView();" class="btn-label-view dropdown"> -->
							<span class="btn_label_toggle"><img alt="label" src="/resources/images/btn_label.png" width="20px" height="20px" class="btn-label">&nbsp;Label</span>
						</button>
						<div class="submenu_hidden">
							<ul class="submenu">
								<span class="label_name">Labels</span>
								<input type="text" id="label_text">
								<li id="label1" onclick="label('1');">&nbsp; <span></span>
								</li>
								<li id="label2" onclick="label('2');">&nbsp; <span></span>
								</li>
								<li id="label3" onclick="label('3');">&nbsp; <span></span>
								</li>
								<li id="label4" onclick="label('4');">&nbsp; <span></span>
								</li>
								<li id="label5" onclick="label('5');">&nbsp; <span></span>
								</li>
								<li id="label6" onclick="label('6');">&nbsp; <span></span>
								</li>
								<li id="label7" onclick="label('7');">&nbsp; <span></span>
								</li>
								<!-- 									<a href="#" style="display: none;">add color...</a> -->
							</ul>
						</div>




						<br> <br>
						<!-- <button>
							<span><img alt="label"
								src="/resources/images/btn_attachment.png" width="20px"
								height="20px" class="btn-attachment">&nbsp;Attachment</span>
						</button> -->
						<button id="insertLink">
							<span><img alt="label" src="/resources/images/btn_attachment.png" width="20px" height="20px" class="btn-attachment">&nbsp;Attachment</span>
							<div id="overlay_t"></div>
							<div id="popup_layer">
								<input type="text" id="insertLinkInput" placeholder="attach link"> <input type="button" id="linkSubmit" class="close" value="save">
								<!-- <button id="linkSubmit">SAVE</button> -->
							</div>
						</button>
						<br> <br>
						<button>
							<span><img alt="label" src="/resources/images/btn_delete.png" width="20px" height="20px" class="btn-delete">&nbsp;Delete</span>
						</button>
						<br> <br>
						<!-- 						<input type="text" id="date_picker"> -->
						<button>
							<span><img alt="label" src="/resources/images/btn_calendar.png" width="20px" height="20px" class="btn-calendar">&nbsp;&nbsp;&nbsp;Calendar</span>
						</button>
						<br> <br>
						<button>
							<span><img alt="label" src="/resources/images/btn_delete.png" width="20px" height="20px" class="btn-delete">&nbsp;empty2</span>
						</button>
						<br> <br>
					</div>
				</div>

			</div>
		</div>



	</div>

</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script src="/resources/js/jquery-ui.js"></script>
<script src="/resources/js/slidebars.js"></script>
<script src="/resources/js/scripts.js"></script>

</html>