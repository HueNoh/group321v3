<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=utf-8"%>

<script type="text/javascript">
	function onMessage(event) {

		var data = event.data.split("::");
		var id = data[0];
		var msg = data[1];
		var access = data[2];
		var b_num = data[3];
		var l_num = data[4];
		var c_num = data[5];
		if (b_num == '${sessionScope.b_num}') {

			if ("message" == access) {
				if (chatOnOff) {
					var date = new Date();
					var amPm = '';
					var h = '';
					var m = date.getMinutes();
					if (12 > date.getHours()) {
						amPm = '오전';
						h = date.getHours();
					} else if (12 < date.getHours()) {
						amPm = '오후';
						h = date.getHours() - 12;
					} else {
						amPm = '오후';
						h = date.getHours();
					}

					var regDate = amPm + ' ' + h + ':' + m;
					chat(msg, id, regDate);
				} else {

					$('#message').empty();
					var div = document.createElement('div');
					div.id = 'offMsg';
					div.className = 'offMsg';

					var content = document.createElement('div');

					var contentText = document.createTextNode(msg);

					content.appendChild(contentText);
					$('#message').append(content);

					openMsg();

					setInterval(closeMsg, 5000);
				}

				$('.display').scrollTop($('.display')[0].scrollHeight);

			} else if ("open" == access) {

			} else if ("close" == access) {

			} else if ('listMove' == access) {
				if (id != '${sessionScope.id}') {

					$('#' + msg).html('');
					listSearch(b_num);
				}

			} else if ("cardMove" == access) {
				if (id != '${sessionScope.id}') {
					$('#mainList').html('');
					listSearch(b_num);
				}
			} else if ('listCreate' == access) {
				if (id != '${sessionScope.id}') {

					$('#mainList').html('');
					listSearch(b_num);
					$.each($('#' + msg)[0].childNodes, function(i) {
						var l_num = this.id;
						listSortable(l_num);
					});
				}
			} else if ("cardCreate" == access) {
				if (id != '${sessionScope.id}') {
					$('#list'+msg).html('');
					cardSearch(b_num, l_num, msg);
				}
			} else if ("connec" == access) {

				var div = document.createElement('div');
				div.id = id;
				div.className = 'user';

				var aTag = document.createElement('a');
				var contentText = document.createTextNode(msg);

				aTag.setAttribute('onclick', 'profile(\'' + id + '\')');
				aTag.setAttribute('style', 'color: white; font-size: 20px');

				aTag.append(contentText);
				div.append(aTag);
				$('#user').append(div);

			} else if ("unConnec" == access) {
				$('#' + id).remove();
			}
			/* else if ("reply" == access) {
								if (id != '${sessionScope.id}'

								&& c_num == '${sessionScope.c_num}') {
									console.log(c_num);
									console.log('ok');
									$('#cardReply').empty();
									$('#cardReply').html(msg);

								}
							}  */
		}
	}

	function onOpen(event) {
		send('${sessionScope.id}', 'connec', '${sessionScope.id}',
				'${sessionScope.b_num}', '0', '0');
	}

	function onError(event) {
		// 		alert(event.data);
	}

	function onClose() {
	}

	function send(message, acc, id, b_num, l_num, c_num) {
		var msg = {
			"userId" : id,
			"msg" : message,
			"access" : acc,
			"b_num" : b_num,
			"l_num" : l_num,
			"c_num" : c_num
		}

		if ('message' == acc) {
			$('#inputMessage').val('');
			chatMsg(message);
			var jsonStr = JSON.stringify(msg);
			webSocket.send(jsonStr);
		} else if ('listMove' == acc) {
			var jsonStr = JSON.stringify(msg);
			webSocket.send(jsonStr);
		} else if ('cardMove' == acc) {
			var jsonStr = JSON.stringify(msg);
			webSocket.send(jsonStr);
		} else if ('close' == acc) {
			webSocket.send(jsonStr);
		} else if ("boardCreate" == acc) {
			var jsonStr = JSON.stringify(msg);
			webSocket.send(jsonStr);
		} else if ('listCreate' == acc) {
			var jsonStr = JSON.stringify(msg);
			webSocket.send(jsonStr);
		} else if ('cardCreate' == acc) {
			var jsonStr = JSON.stringify(msg);
			webSocket.send(jsonStr);
		} else if ('reply' == acc) {
			var jsonStr = JSON.stringify(msg);
			webSocket.send(jsonStr);
		} else if ('connec' == acc) {
			var jsonStr = JSON.stringify(msg);
			webSocket.send(jsonStr);
		} else if ('unConnec' == acc) {
			var jsonStr = JSON.stringify(msg);
			webSocket.send(jsonStr);
		}

	}

	function chat(msg, id, regdate) {
		if (id == '${sessionScope.id}') {

			var div = document.createElement('div');
			div.className = 'myMsg';

			var content = document.createElement('div');
			content.className = "myContent";

			var date = document.createElement('div');
			date.className = "myDate";

			var b = document.createElement('div');
			b.className = 'b';

			var contentText = document.createTextNode(msg);
			var dateText = document.createTextNode(regdate);

			content.appendChild(contentText);

			date.appendChild(dateText);

			div.append(b);
			div.append(content);
			div.append(date);

			$('.display').append(div);
		} else {
			var box = document.createElement('div');
			box.className = 'box';

			var div = document.createElement('div');
			div.className = 'memberMsg';

			var proImg = document.createElement('IMG');
			proImg.className = 'profileImg';

			var content = document.createElement('div');
			content.className = "memberContent";

			var writer = document.createElement('div');
			writer.className = "memberWriter";

			var date = document.createElement('div');
			date.className = "memberDate";

			var b = document.createElement('div');
			b.className = 'm';

			var contentText = document.createTextNode(msg);
			var writerText = document.createTextNode(id);
			var dateText = document.createTextNode(regdate);

			content.appendChild(contentText);
			writer.appendChild(writerText);
			date.appendChild(dateText);

			box.append(writer);
			box.append(b);
			box.append(content);
			box.append(date);

			div.append(box);

			$('.display').append(div);
		}

		$('.display').scrollTop($('.display')[0].scrollHeight);

	}

	function viewMsg() {
		$.ajax({
			method : 'post',
			url : '/chat/viewMsg',
			data : {
				b_num : '${sessionScope.b_num}',
				userId : '${sessionScope.id}'
			}
		}).done(function(msg) {

			var data = JSON.parse(msg);
			$.each(data, function(i) {
				var regdate = data[i].date;
				chat(data[i].content, data[i].m_id, regdate);
			});

			$('.display').scrollTop($('.display')[0].scrollHeight);

		});
	}

	function chatMsg(content) {
		$.ajax({
			method : 'post',
			url : '/chat/chatMsg',
			data : {
				content : content,
				b_num : '${sessionScope.b_num}',
				m_id : '${sessionScope.id}'
			}
		});
	}

	function userView(msg) {
		var div = document.createElement('div');
		div.className = 'myMsg';

		var content = document.createElement('div');
		var writer = document.createElement('div');

		var contentText = document.createTextNode(msg);
		var writerText = document.createTextNode(id);

		content.appendChild(contentText);
		writer.appendChild(writerText);

		div.append(content);
		div.append(writer);
		$('.display').append(div);
	}
</script>
