<!DOCTYPE html>
<head>
    <title>Spring Boot Security Hello</title>
</head>
<body>
<h2>Spring Boot Security Login with AppAuthen+</h2>
<a href="http://localhost:8081/oauth/authorize?client_id=mobile&response_type=code&redirect_uri=http://localhost:8080/oauth/callback&scope=WRITE">Login With AuthenServer</a>

<br/>
<form name='login-form' action="/j_spring_security_login" method='POST'>
    <table>
        <tr>
            <td>Username:</td>
            <td><input type='text' name='username' value=''></td>
        </tr>
        <tr>
            <td>Password:</td>
            <td><input type='password' name='password' /></td>
        </tr>
        <tr>
            <td><input name="submit" type="submit" value="submit" /></td>
        </tr>
    </table>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
</body>
</html>