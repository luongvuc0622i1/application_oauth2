<!DOCTYPE html>
<html>
<head>
    <title>Spring Boot Security Hello</title>
</head>
<body>
<h2>User Page</h2>
<h3>
    Welcome :
</h3>

<a href="/admin">Admin Page</a>

<br/><br/>
<form action="/logout" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <input type="submit" value="Logout" />
</form>
</body>
</html>