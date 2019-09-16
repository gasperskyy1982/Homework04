<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ include file = "includes/header.jsp" %>
<%@ page import = "controller.RegistrationController" %>
<%@ page import = "controller.DBRegistrationController" %>

<%
RegistrationController controller = new RegistrationController();
DBRegistrationController logControl = new DBRegistrationController();
boolean isError = false;
boolean showForm = true;
StringBuilder error_Text = new StringBuilder();
String login = request.getParameter("Login");
String password = request.getParameter("Password");
String re_password = request.getParameter("Re_Password");
String name = request.getParameter("Name");
String region = request.getParameter("Region");
String gender = request.getParameter("Gender");
Boolean gender_out;
String comment = request.getParameter("Comment");
String agree = request.getParameter("Agree");

if (login == null && password == null && re_password == null && name == null && region == null && 
	gender == null && comment == null && agree == null) {}

	else {

		if (login != null && login.length() == 0) {
			isError = true;
			error_Text.append("<li style = 'color:red'> Login is empty </li>");
		}  else {
			isError = true;
		
		}
		if (login != null && login.length() != 0) {
			if (!controller.isLoginCorrect(login)) {
			isError = true;
			error_Text.append("<li style = 'color:red'> Incorrect Login </li>");
			}else {
			isError = true;
			}
		}
		
		if (login != null && login.length() != 0) {
			if (!logControl.getUniqueLogin(login)) {
				isError = true;
				error_Text.append("<li style = 'color:red'> This Login is busy </li>");
				}  else {
					isError = false;
				}
		}
		
		if (password != null && password.length() == 0) {
			isError = true;
			error_Text.append("<li style = 'color:red'> Password is empty </li>");
		}	else { if (!controller.isPasswordCorrect(password)) {
			isError = true;
			error_Text.append("<li style = 'color:red'> Incorrect Password </li>");
			} else {
					isError = false;
				}
		}
		if (re_password != null && re_password.length() == 0) {
			isError = true;
			error_Text.append("<li style = 'color:red'> Re_Password is empty </li>");
		} else {
			isError = false;
		}
		
		if (password!= null && password.length() != 0 && re_password !=null && re_password.length() != 0) {
			 isError = true;
			 if (!controller.isRe_PasswordCorrect(password, re_password)) {
				 error_Text.append("<li style = 'color:red'> Re_type Password </li>");
			 } else {
			 isError = false;
			}		 
		}
		
		if (name != null && name.length() == 0) {
			isError = true;
			error_Text.append("<li style = 'color:red'> Name is empty </li>");
		}else {
			isError = false;
		}
		if (region != null && region.length() == 0) {
			isError = true;
			error_Text.append("<li style = 'color:red'> Region is empty </li>");
		}else {
			isError = false;
		}
		if (gender == null) {
			isError = true;
			error_Text.append("<li style = 'color:red'> Gender is empty </li>");
		}else {
			isError = false;
		}
		if (comment != null && comment.length() == 0) {
			isError = true;
			error_Text.append("<li style = 'color:red'> Comment is empty </li>");
		}else {
			isError = false;
		}
		if (agree == null) {
			isError = true;
			error_Text.append("<li style = 'color:red'> Agree is empty </li>");
		}else {
			isError = false;
		}
		if (!isError) {
		showForm = false;
		if (gender.equals("Male")) {
			gender_out = true; 
		} else { gender_out = false;
			}
		logControl.setUser(login,password,name,region,gender_out,comment);
		out.write("<h1 style = 'color:green'> Your are registered! </h1>"); 
		}
	}
%>

<% if (showForm) {%>
<form id="registerForm" action = "checked.jsp" method = "post">
	<table border = "0" align = "center">
		<tr>
		<td> 
			<table>
			
			<div class="field">
				<label>Login</label>
				<div class="input"><input type="text" name="Login" placeholder = "Enter your login" title = "name@adress" required = "required" 
									value = "<%= (login!=null?(controller.isLoginCorrect(login)?
									(logControl.getUniqueLogin(login)?login:""):""):"")%>" id = "Login"/></div>
			</div>			

			<div class="field">
				<label>Password</label>
				<div class="input"><input type="password" name="Password" placeholder = "min 8 symbols" required = "required" 
									value = "<%= (password!=null?(controller.isPasswordCorrect(password)?password:""):"")%>" id="Password" /></div>
			</div>
			
			
			<div class="field">
				<label>Re-type Password</label>
				<div class="input"><input type="password" name="Re_Password" placeholder = "min 8 symbols" required = "required" 
									value = "<%= (re_password!=null?(controller.isRe_PasswordCorrect(password, re_password)?re_password: ""):"")%>"
									id="Re_Password"/></div>
			</div>
			
			<div class="field">
				<label>Name</label>
				<div class="input"><input type="text" name="Name" value = "<%= (name!=null?name:"")%>" id = "Name"/></div>
			</div>
			
			
			<div class="field">
			<label>Region</label>
			<div class="input">
				<select name = "Region"/>
						<option value ="DNR" <%= (region!=null?(region.equals("DNR")?"selected":""):"")%> > DNR </option>
						<option value ="LNR" <%= (region!=null?(region.equals("LNR")?"selected":""):"")%> > LNR </option>
						<option value ="Crimea" <%= (region!=null?(region.equals("Crimea")?"selected":""):"")%> > Crimea </option>
				  </select>
				  </div>
			</div>
			

			<div class="gender">
			<label>Gender</label>
				<div>
					<label id = "gender"> Male <input type = "radio" width = "10px" name = "Gender" value = "Male" 
					<%=(gender!=null?(gender.equals("Male")?"checked":""):"")%>/></label>
					<label id = "gender"> Female <input type = "radio" name = "Gender" value = "Female"
					<%=(gender!=null?(gender.equals("Female")?"checked":""):"")%>/></label>
				</div>
			</div>			

			
			<div class="field">
				<label>Comment</label>
				<div class="input">
				<textarea name = "Comment" cols = "35" raws = "20" value = "<%= (comment!=null?comment:"")%>" ></textarea> 
				</div>
			</div>
			
			<div class="submit">
				<button type="submit" value = "Register"/>Register</button>
				<label id = "agree"> I agree <input name = "Agree" input type = "checkbox" <% if (agree !=null)%> checked /></label>
			</div>
			
			
			</table>
		</td>
	
	<td align = left> <%if(isError) out.write(String.valueOf(error_Text));%> </td>
	
	</tr>	
	</table>
</form>


<% } %>	