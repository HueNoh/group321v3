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
				chat(msg, id);

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
						var lnum = this.id;
						listSortable(lnum);
					});
				}
			} else if ("cardCreate" == access) {
				if (id != '${sessionScope.id}') {
					$('#mainList').html('');
					listSearch(b_num);
				}
			} else if ("connec" == access) {
				console.log('${member}');
				
				if (id != '${sessionScope.id}') {
					var div = document.createElement('div');
					div.id = id;
					div.className = 'user';

					var content = document.createElement('div');

					var contentText = document.createTextNode(msg);

					content.appendChild(contentText);

					div.append(content);
					$('#user').append(div);
				} else {
					var div = document.createElement('div');
					div.id = id;
					div.className = 'user';

					var content = document.createElement('div');

					var contentText = document.createTextNode(msg);

					content.appendChild(contentText);

					div.append(content);
					$('#user').append(div);
				}
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

	function chat(msg, id) {
		if (id == '${sessionScope.id}') {
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
		} else {
			var div = document.createElement('div');
			div.className = 'memberMsg';
			var proImg = document.createElement('img');
			proImg.className = 'profileImg';

			var content = document.createElement('div');
			var writer = document.createElement('div');

			var contentText = document.createTextNode(msg);
			var writerText = document.createTextNode(id);

			content.appendChild(contentText);
			writer.appendChild(writerText);

			content.appendChild(proImg);
			content.appendChild(contentText);
			writer.appendChild(writerText);

			div.appendChild(content);
			div.appendChild(writer);

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
				chat(data[i].content, data[i].m_id);
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
