<%--
  Created by IntelliJ IDEA.
  User: gialuong
  Date: 19/04/2023
  Time: 20:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Account</title>
  <!--  Icon social-->
  <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
  <!--  Icon eye-->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
  <style>
    @import url('https://fonts.googleapis.com/css?family=Montserrat:400,800');

    * {
      box-sizing: border-box;
    }

    body {
      background: #f6f5f7;
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      font-family: 'Montserrat', sans-serif;
      height: 100vh;
      margin: -20px 0 50px;
    }

    h1 {
      font-weight: bold;
      margin: 0;
    }

    h2 {
      text-align: center;
    }

    p {
      font-size: 14px;
      font-weight: 100;
      line-height: 20px;
      letter-spacing: 0.5px;
      margin: 20px 0 30px;
    }

    span {
      font-size: 12px;
    }

    a {
      color: #333;
      font-size: 14px;
      text-decoration: none;
      margin: 15px 0;
    }

    button {
      border-radius: 20px;
      border: 1px solid #FF4B2B;
      background-color: #FF4B2B;
      color: #FFFFFF;
      font-size: 12px;
      font-weight: bold;
      padding: 12px 45px;
      letter-spacing: 1px;
      text-transform: uppercase;
      transition: transform 80ms ease-in;
    }

    button:active {
      transform: scale(0.95);
    }

    button:focus {
      outline: none;
    }

    button.ghost {
      background-color: transparent;
      border-color: #FFFFFF;
    }

    form {
      background-color: #FFFFFF;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-direction: column;
      padding: 0 50px;
      height: 100%;
      text-align: center;
    }

    input {
      background-color: #eee;
      border: none;
      padding: 12px 15px;
      margin: 8px 0;
      width: 100%;
    }

    .container {
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 14px 28px rgba(0,0,0,0.25),
      0 10px 10px rgba(0,0,0,0.22);
      position: relative;
      overflow: hidden;
      width: 768px;
      max-width: 100%;
      min-height: 480px;
    }

    .form-container {
      position: absolute;
      top: 0;
      height: 100%;
      transition: all 0.6s ease-in-out;
    }

    .sign-in-container {
      left: 0;
      width: 50%;
      z-index: 2;
    }

    .forgot-mail-container .forgot-pass-container {
      left: 0;
      width: 100%;
      z-index: 2;
    }

    .container.right-panel-active .sign-in-container {
      transform: translateX(100%);
    }

    .sign-up-container {
      left: 0;
      width: 50%;
      opacity: 0;
      z-index: 1;
    }

    .container.right-panel-active .sign-up-container {
      transform: translateX(100%);
      opacity: 1;
      z-index: 5;
      animation: show 0.6s;
    }

    @keyframes show {
      0%, 49.99% {
        opacity: 0;
        z-index: 1;
      }

      50%, 100% {
        opacity: 1;
        z-index: 5;
      }
    }

    .overlay-container {
      position: absolute;
      top: 0;
      left: 50%;
      width: 50%;
      height: 100%;
      overflow: hidden;
      transition: transform 0.6s ease-in-out;
      z-index: 100;
    }

    .container.right-panel-active .overlay-container{
      transform: translateX(-100%);
    }

    .overlay {
      background: #FF416C;
      background: -webkit-linear-gradient(to right, #FF4B2B, #FF416C);
      background: linear-gradient(to right, #FF4B2B, #FF416C);
      background-repeat: no-repeat;
      background-size: cover;
      background-position: 0 0;
      color: #FFFFFF;
      position: relative;
      left: -100%;
      height: 100%;
      width: 200%;
      transform: translateX(0);
      transition: transform 0.6s ease-in-out;
    }

    .container.right-panel-active .overlay {
      transform: translateX(50%);
    }

    .overlay-panel {
      position: absolute;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-direction: column;
      padding: 0 40px;
      text-align: center;
      top: 0;
      height: 100%;
      width: 50%;
      transform: translateX(0);
      transition: transform 0.6s ease-in-out;
    }

    .overlay-left {
      transform: translateX(-20%);
    }

    .container.right-panel-active .overlay-left {
      transform: translateX(0);
    }

    .overlay-right {
      right: 0;
      transform: translateX(0);
    }

    .container.right-panel-active .overlay-right {
      transform: translateX(20%);
    }

    .social-container {
      margin: 20px 0;
    }

    .social-container a {
      border: 1px solid #DDDDDD;
      border-radius: 50%;
      display: inline-flex;
      justify-content: center;
      align-items: center;
      margin: 0 5px;
      height: 40px;
      width: 40px;
    }
  </style>
</head>
<body>
<div class="container" id="container">
  <div class="form-container sign-up-container" id="sign-up-container">
    <form action="/register?action=submit" method="post" onsubmit="return ValidateFormRegister()" >
      <h1>Create Account</h1>
      <div class="social-container">
        <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
        <a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
        <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
      </div>
      <span>or use your email for registration</span>
      <span id="new-username-validation-message" style="color: red"></span>
      <input type="text" placeholder="Username" id="newUsername" name="newUsername" />
      <span id="email-validation-message" style="color: red"></span>
      <input type="email" placeholder="Email" id="email" name="email" />
      <span id="new-password-validation-message" style="color: red"></span>
      <input type="password" placeholder="Password" name="newPassword" id="id_password1" />
      <i class="far fa-eye" id="togglePassword1" style="margin-left: 240px; cursor: pointer; margin-top: -36px"></i><br>
      <span id="confirm-password-validation-message" ></span>
      <input type="password" placeholder="Confirm Password" name="confirmPassword" id="id_password2" />
      <i class="far fa-eye" id="togglePassword2" style="margin-left: 240px; cursor: pointer; margin-top: -36px"></i><br><br>
      <div>
        <button type="reset" style="float: left; width: 140px; background-color: white; color: #FF4B2B; margin-right: 4px">Reset</button>
        <button type="submit" style="float: right; width: 140px">SignUp</button>
      </div>
    </form>
  </div>
  <div class="form-container sign-in-container" id="sign-in-container">
    <form action="/account?action=submit" method="post" onsubmit="return ValidateFormLogin()" >
      <h1>Sign in</h1>
      <div class="social-container">
        <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
        <a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
        <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
      </div>
      <span>or use your account</span>
      <span id="username-validation-message" style="color: red"></span>
      <input type="text" placeholder="Username" id="username" name="username"/>
      <span id="password-validation-message" style="color: red"></span>
      <input type="password" placeholder="Password" name="password" autocomplete="current-password" required="" id="id_password" />
      <i class="far fa-eye" id="togglePassword" style="margin-left: 240px; cursor: pointer; margin-top: -36px"></i><br>
      <a id="forgot-password" href="">Forgot your password?</a>
      <button type="submit">Sign In</button>
    </form>
  </div>
  <div class="overlay-container" id="overlay-container">
    <div class="overlay">
      <div class="overlay-panel overlay-left">
        <h1>Welcome Back!</h1>
        <p>To keep connected with us please login with your personal info</p>
        <button class="ghost" id="signIn">Sign In</button>
      </div>
      <div class="overlay-panel overlay-right">
        <h1>Hello, Friend!</h1>
        <p>Enter your personal details and start journey with us</p>
        <button class="ghost" id="signUp">Sign Up</button>
      </div>
    </div>
  </div>
  <div class="form-container forgot-mail-container" id="forgot-mail-container" style="display: none">
    <form action="/forgot?action=submit" method="post" >
      <h1>Forgot Password</h1>
      <div class="social-container" style="height: 40px"></div>
      <span>Please</span>
      <input type="text" placeholder="Username" id="forgot-username" name="username"/>
      <input type="email" placeholder="Email" id="forgot-email" name="email"/>
      <div style="height: 20px"></div>
      <button type="submit">Send email</button>
    </form>
  </div>
  <div class="form-container forgot-pass-container" id="forgot-pass-container" style="display: none">
    <form action="/changePassword?action=submit" method="post" >
      <h1>Forgot Password</h1>
      <div class="social-container" style="height: 40px"></div>
      <span>Enter your new password below.</span>
      <input type="password" placeholder="Password" name="newPassword" id="id_password3" />
      <i class="far fa-eye" id="togglePassword3" style="margin-left: 240px; cursor: pointer; margin-top: -36px"></i><br>
      <input type="password" placeholder="Confirm Password" name="confirmPassword" id="id_password4" />
      <i class="far fa-eye" id="togglePassword4" style="margin-left: 240px; cursor: pointer; margin-top: -36px"></i><br><br>
      <input type="hidden" name="email" value="<%= session.getAttribute("email") %>"/>
      <div style="height: 20px"></div>
      <button type="submit">Save</button>
    </form>
  </div>
</div>
<script>
  const signUpButton = document.getElementById('signUp');
  const signInButton = document.getElementById('signIn');
  const container = document.getElementById('container');

  signUpButton.addEventListener('click', () => {
    container.classList.add("right-panel-active");
  });

  signInButton.addEventListener('click', () => {
    container.classList.remove("right-panel-active");
  });

  // Show password click eye
  const togglePassword = document.querySelector('#togglePassword');
  const password = document.querySelector('#id_password');
  togglePassword.addEventListener('click', function (e) {
    // toggle the type attribute
    const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
    password.setAttribute('type', type);
    // toggle the eye slash icon
    this.classList.toggle('fa-eye-slash');
  });

  // Show new password click eye
  const togglePassword1 = document.querySelector('#togglePassword1');
  const password1 = document.querySelector('#id_password1');
  togglePassword1.addEventListener('click', function (e) {
    // toggle the type attribute
    const type1 = password1.getAttribute('type') === 'password' ? 'text' : 'password';
    password1.setAttribute('type', type1);
    // toggle the eye slash icon
    this.classList.toggle('fa-eye-slash');
  });

  // Show confirm password click eye
  const togglePassword2 = document.querySelector('#togglePassword2');
  const password2 = document.querySelector('#id_password2');
  togglePassword2.addEventListener('click', function (e) {
    // toggle the type attribute
    const type2 = password2.getAttribute('type') === 'password' ? 'text' : 'password';
    password2.setAttribute('type', type2);
    // toggle the eye slash icon
    this.classList.toggle('fa-eye-slash');
  });

  //Validate form login
  function ValidateFormLogin() {
    let username = document.getElementById("username").value;
    let password = document.getElementById("id_password").value;
    if(username.length < 3 || password.length < 6) {
      if(username.length < 3) document.getElementById("username-validation-message").innerHTML = "Username must be at least 3 characters";
      if(password.length < 6) document.getElementById("password-validation-message").innerHTML = "Password must be at least 6 characters";
      return false;
    }
    return true;
  };

  //Validate form register
  function ValidateFormRegister() {
    let username = document.getElementById("newUsername").value;
    let email = document.getElementById("email").value;
    let password = document.getElementById("id_password1").value;
    let confirmPassword = document.getElementById("id_password2").value;
    if(username.length < 3 || email.length < 6 || password.length < 6 || password !== confirmPassword) {
      if(username.length < 3) document.getElementById("new-username-validation-message").innerHTML = "Username must be at least 3 characters";
      if(password.length < 6) document.getElementById("email-validation-message").innerHTML = "Email must be at least 6 characters";
      if(password.length < 6) document.getElementById("new-password-validation-message").innerHTML = "Password must be at least 6 characters";
      if(password !== confirmPassword) document.getElementById("confirm-password-validation-message").innerHTML = "Confirm password not matching";
      return false;
    }
    return true;
  };

  //click forgot password
  const forgotPassword = document.querySelector('#forgot-password');
  forgotPassword.addEventListener('click', function (e) {
    e.preventDefault();
    document.getElementById("container").style.width = "384px";
    document.getElementById("sign-up-container").remove();
    document.getElementById("sign-in-container").remove();
    document.getElementById("overlay-container").remove();
    document.getElementById("forgot-mail-container").style.display = "block";
  });

  //show form input new password
  let target = '<%= session.getAttribute("target") %>';
  if (target == 4) {
    document.getElementById("container").style.width = "384px";
    document.getElementById("sign-up-container").remove();
    document.getElementById("sign-in-container").remove();
    document.getElementById("overlay-container").remove();
    document.getElementById("forgot-mail-container").remove();
    document.getElementById("forgot-pass-container").style.display = "block";
  }
</script>
</body>
</html>
