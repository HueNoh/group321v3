<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=utf-8"%>
<script>
	function inUsers() {
		$.ajax({
			url : "/main/inUsers",
			method : "post",
			dataType : "json",
			data : {
				b_num : b_num
			}
		}).done(function(msg) {
			$.each(msg, function(i) {

				var userDiv = document.createElement('div');
				userDiv.className = 'user-inUsers';

				var div = document.createElement('div');
				div.className = 'inUsers';

				var aTag = document.createElement('a');
				var content = document.createTextNode(msg[i].m_id);

				aTag.setAttribute('onclick', 'profile(\''+msg[i].m_id+'\')');
				aTag.setAttribute('style', 'color: white; font-size: 20px');

				aTag.appendChild(content);
				div.appendChild(aTag);
				userDiv.append(div);

				if ('${sessionScope.id}' == msg[i].m_id) {
					var buttonDiv = document.createElement('div');
					buttonDiv.className = 'inUsersButton';
					var button = document.createElement('input');
					button.type = 'button';
					button.value = '나가기';
					button.onclick = function() {

						var choice = confirm("나가시겠습니까?");

						if (choice) {
							boardOut(msg[i].m_id);
						} else {
							console.log('취소');
						}

					};

					userDiv.append(button);
				}
				$('#inUser').append(userDiv);
			})
		});

	}
	function searchUser() {
		var result = '%' + $('#userSearch').val() + '%';
		var id = '';
		if ($('#userSearch').val() == '') {
			$('#resultUser').empty();
			id = '<p>검색결과가 없습니다.</p>';
			$('#resultUser').append(id);
		} else {

			$.ajax({
				url : "/main/searchUser",
				method : "post",
				dataType : "json",
				data : {
					b_num : b_num,
					result : result
				}
			}).done(
					function(msg) {
						$('#resultUser').empty();
						console.log(msg);
						if (0 == msg.length) {
							$('#resultUser').empty();
							id = '<p>검색결과가 없습니다.</p>';
							$('#resultUser').append(id);
						} else {

							$.each(msg, function(i) {
								var userDiv = document.createElement('div');
								userDiv.className = 'user-searchUsers';

								var div = document.createElement('div');
								div.className = 'searchUsers';

								var aTag = document.createElement('a');
								var content = document
										.createTextNode(msg[i].m_id);

								aTag.setAttribute('onclick', 'profile(\''+msg[i].m_id+'\')');
								aTag.setAttribute('style',
										'color: white; font-size: 20px');

								aTag.appendChild(content);
								div.appendChild(aTag);

								var buttonDiv = document.createElement('div');
								buttonDiv.className = 'inviteButton';
								var button = document.createElement('input');
								button.type = 'button';
								button.value = '초대';
								button.onclick = function() {

									var choice = confirm(msg[i].m_id
											+ "님을 초대하시겠습니까?")

									if (choice) {
										invite(msg[i].m_id);
									} else {
										console.log('취소');
									}

								};

								buttonDiv.append(button);

								userDiv.append(div);
								userDiv.append(buttonDiv);

								$('#resultUser').append(userDiv);

							});
						}
						$('#userSearch').val('');
					});
		}
	}
	function invite(id) {
		$.ajax({
			url : "/main/inviteUser",
			method : "post",
			dataType : "json",
			data : {
				b_num : b_num,
				id : id
			}
		}).done(function(msg) {
			if (0 == msg) {
				alert(id + '님을 추가하였습니다.')

			} else {
				alert(id + '님을 초대에 실패하였습니다.')
			}
		});
	}

	function boardOut(id) {
		$.ajax({
			url : "/main/boardOut",
			method : "post",
			dataType : "json",
			data : {
				b_num : b_num,
				id : id
			}
		}).done(function(msg) {
			if (0 == msg) {
				location.href = '/main/board';

			} else {
				alert('나가기 실패');
			}
		});
	}
</script>
<p>유저 검색</p>
<div id="searchUser">
	<input type="text" id="userSearch" /> <input type="button"
		onclick="searchUser();" value="검색">
</div>
<p>프로젝트 멤버</p>
<div id="inUser"></div>

<p>검색 결과</p>
<div id="resultUser"></div>