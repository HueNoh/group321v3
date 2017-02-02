<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>Home</title>
<script src="/resources/js/jquery-3.1.1.js"></script>
<link rel="stylesheet" href="/resources/css/style_hs.css">
<script>
	
</script>
</head>
<body>
	<div id="g3-container">
		<div id="g3-main">
			<div id="g3-header">header</div>
			<div id="g3-content">
				<div class="login-layout">
					<form action="/login" method="post">
						<table id="login-tbl">
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
				</div>
				${err}

			</div>
			<div id="g3-footer">copyright by grouop321</div>
		</div>

	</div>



</body>
</html>
