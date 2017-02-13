<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<script>
	function userList() {
		$.ajax({
			url : '/main/userList',
			method : 'post',
			dataType : 'json'

		}).done(function(msg) {

		});
	}
</script>
