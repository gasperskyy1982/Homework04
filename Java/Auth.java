package ua.itea.homework3;

public class Auth {

	public String login;
	public String password;
	public boolean checkAccess;

	public Auth() {
		super();
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean checkAccess(String login, String password) {
		if (login.equals("admin") && password.equals("123")) {
			return true;
		} else
			return false;
	}

	public String getLogin() {
		return login;
	}

	public String getPassword() {
		return password;
	}

}
