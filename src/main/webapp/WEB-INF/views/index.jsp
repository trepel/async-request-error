<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Welcome</title>
</head>
<body>
  <h1>Home Page</h1>
  <p>
    Anyone can view this page.
  </p>

  <sec:authorize access="authenticated" var="authenticated"/>
  <c:if test="${authenticated}">
    <p>You are currently authenticated</p>
    <dl>
      <dt>User Info:</dt>
      <dd><sec:authentication property="principal.username" /></dd>
      <dd><sec:authentication property="principal.authorities" /></dd>
      <dt>Authentication object:</dt>
      <dd><%=org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication()%></dd>
    </dl>
  </c:if>

  <ul>
    <li>
      <a id="async" href="<c:url value="/async"/>">AsyncContext.start(Runnable)</a>
        - will automatically transfer the current SecurityContext to the new Thread
    </li>
    <c:choose>
      <c:when test="${authenticated}">
        <li><a id="logout" href="<c:url value="/logout"/>">HttpServletRequest.logout()</a></li>
      </c:when>
      <c:otherwise>
        <li><a id="login" href="<c:url value="/customlogin"/>">Fill out log in form</a></li>
      </c:otherwise>
    </c:choose>
  </ul>
</body>
</html>
