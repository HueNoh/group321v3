<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=utf-8"%>
<script>
	
</script>
<div class="chatBoard">
	<div id="user"></div>
	<div id="dis">
		<div class="dis display"></div>
		<div class="dis inputMsg">
			<textarea id="inputMessage" style="width: 100%; height: 100%;"
				type="text"></textarea>
		</div>
		<div class="dis sub">
			<input type="button" style="width: 100%; height: 100%;" value="send"
				onclick="send(inputMessage.value,'message','${sessionScope.id}','${sessionScope.b_num}', '0', '0')" />
		</div>
	</div>
</div>
