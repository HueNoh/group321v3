<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=utf-8"%>

<script type="text/javascript">
	function onMessage(event) {

		var data = event.data.split("::");
		console.log(data);
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

				$('#' + id).html(msg);

				$.each($('#' + id)[0].childNodes, function(i) {
					var cardSortId = "list" + this.id;
					var lnum = this.id;
					console.log("aewf: " + cardSortId);

					$('#' + cardSortId).sortable({
						connectWith : '.list',
						update : function(ev, ui) {

							send(ev.target.innerHTML, 'cardMove', cardSortId, '${sessionScope.b_num}', '0', '0');

							var result1 = $('#' + cardSortId).sortable('toArray');
							var targetId = ev.target.id;
							var parentId = ev.toElement.parentElement.id;
							var cardArr = '';
							if (targetId == parentId) {

								console.log(ev.target.innerHTML);
								for (var i = 0; i < result1.length; i++) {
									if (i < (result1.length - 1)) {
										cardArr += result1[i] + ',';
									} else {
										cardArr += result1[i];
									}

								}

								console.log(lnum);

								$.ajax({
									url : '/main/moveCard',
									method : 'post',
									data : {

										bnum : '${b_num}',
										lnum : lnum,
										cnum : ev.toElement.id,
										msg : cardArr,
										length : result1.length
									}

								}).done();
							}
						}
					});
				});
			} else if ("cardMove" == access) {
				$('#' + id).html(msg);
			} else if ('listCreate' == access) {
				$('#' + id).html(msg);
				$.each($('#' + id)[0].childNodes, function(i) {
					var cardSortId = "list" + this.id;
					var lnum = this.id;
					console.log("aewf: " + cardSortId);

					$('#' + cardSortId).sortable({
						connectWith : '.list',
						update : function(ev, ui) {

							send(ev.target.innerHTML, 'cardMove', cardSortId, '${sessionScope.b_num}','0','0');

							var result1 = $('#' + cardSortId).sortable('toArray');
							var targetId = ev.target.id;
							var parentId = ev.toElement.parentElement.id;
							var cardArr = '';
							if (targetId == parentId) {

								console.log(ev.target.innerHTML);
								for (var i = 0; i < result1.length; i++) {
									if (i < (result1.length - 1)) {
										cardArr += result1[i] + ',';
									} else {
										cardArr += result1[i];
									}

								}

								console.log(lnum);

								$.ajax({
									url : '/main/moveCard',
									method : 'post',
									data : {

										bnum : '${b_num}',
										lnum : lnum,
										cnum : ev.toElement.id,
										msg : cardArr,
										length : result1.length
									}

								}).done();
							}
						}
					});
				});
			} else if ("cardCreate" == access) {
				$('#' + id).html(msg);
			} else if ("reply" == access) {
				$('#cardReply').empty();
				$('#cardReply').html(msg);
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
	
	function viewMsg(){
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
</script>
