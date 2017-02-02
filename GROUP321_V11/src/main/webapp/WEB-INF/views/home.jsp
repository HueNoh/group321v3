<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>Home</title>
<script src="/resources/js/jquery-3.1.1.js"></script>
<script>
	
</script>
</head>
<body>
	<h1>Hello world!</h1>

	<P>The time on the server is ${serverTime}.</P>
	<p>Login</p>
	<form action="/login" method="post">
		<table>
			<tr>
				<td>id</td>
				<td><input type="text" name="id" /></td>
			</tr>
			<tr>
				<td>pw</td>
				<td><input type="password" name="pw" /></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="login" />
			</tr>
		</table>
	</form>
	${err}
	<br>


</body>
</html>
