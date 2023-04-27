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
        <li><a href="/info">Info1</a></li>
        <li><a href="/info">Info2</a></li>
        <li><a href="/info">Info3</a></li>
        <li><a href="/info">Info4</a></li>
        <li><a href="/info">Info5</a></li>
        <li><a>${username}</a></li>
        <li><a href="/signout" id="signout">Signout</a></li>
    </ul>
    <p id="test" style="display: none">${accessToken}</p>
<script>
    localStorage.setItem("accessToken", document.getElementById("test").textContent);

    //click signout
    const signout = document.querySelector('#signout');
    signout.addEventListener('click', function (e) {
        localStorage.removeItem("accessToken");
    });
</script>
</body>
</html>