<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ include file = "includes/header.jsp" %>

<jsp:useBean id ="auth" class = "controller.DBAuthController" />

<c:set var="showForm" value="true"/>
<c:set var="login" value="${param['Login']}"/>
<c:set var="password" value="${param['Password']}"/>

<c:choose>

	<c:when test="${login == null && password == null}">
	</c:when>

	<c:when test="${auth.getAuth(login,password) == 'true'}">
		<tr> <td> <h1 style = 'color:green;'> Hello! </h1> </td>
			 <td> <h1> ${login} </h1> </td>
		</tr>
	<c:set var = "showForm" value="false"/>
	</c:when>
	
	<c:otherwise>
		<h1 style = 'color:red;'> Incorrect login or password </h1>
	</c:otherwise>
		
</c:choose>


<c:if test="${showForm == 'true'}">

<form id="loginForm" action="auth.jsp" method="post">

	<div class="field">
		<label>Enter your login:</label>
		<div class="input"><input type="text" name="Login" value="" id="Login" /></div>
	</div>

	<div class="field">
		<a href="#" id="forgot">Forgot your password?</a>
		<label>Enter your password:</label>
		<div class="input"><input type="password" name="Password" value="" id="Password" /></div>
	</div>

	<div class="submit">
		<button type="submit">Enter</button>
		<label id="remember"><input name="" type="checkbox" value="" /> Remember me</label>
	</div>

</form>

</c:if>	