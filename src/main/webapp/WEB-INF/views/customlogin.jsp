<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Please Log In</title>
</head>
<body>
  <h1>Please Log In</h1>
  <p>Credentials: <b>user/password</b> or <b>admin/password</b></p>
  <form:form action="./customlogin" method="post" modelAttribute="loginForm">
    <form:errors/>
    <p>
      <label for="username">Username</label>
      <form:input id="username" path="username"/>
    </p>
    <p>
      <label for="password">Password</label>
      <form:password id="password" path="password"/>
    </p>
    <p>
      <input id="submit" type="submit" value="Log In"/>
    </p>
  </form:form>
</body>
</html>
