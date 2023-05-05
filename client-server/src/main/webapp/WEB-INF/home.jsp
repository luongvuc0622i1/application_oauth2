<%--
  Created by IntelliJ IDEA.
  User: gialuong
  Date: 26/04/2023
  Time: 9:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
    <style>
        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background-color: #333;
        }

        li {
            float: left;
        }

        li a {
            display: block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }

        li a:hover {
            background-color: #111;
        }
    </style>
</head>
<body>
<ul>
    <li><a href="/user">User</a></li>
    <li><a href="/admin">Admin</a></li>
    <li><a id="getUsername">${object.getUsername()}</a></li>
    <li>
        <form action="/logout" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input type="submit" value="Logout" />
        </form>
    </li>
</ul>
</body>
</html>