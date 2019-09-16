package controller;

import java.util.regex.Pattern;

public class RegistrationController {

	public RegistrationController() {
		super();
	}

	public boolean isLoginCorrect (String login) {
		if (Pattern.matches(".+@.+", login)) {
			return true;
		} else {
			return false;
		}
	}
	
	public boolean isPasswordCorrect(String password_1) {
		if (Pattern.matches("(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}", password_1)) {
			return true;
		} else {
			return false;
		}
	}
	
	public boolean isRe_PasswordCorrect(String password_1, String password_2) {
		if (password_1.equals(password_2)) {
			return true;
		} else {
			return false;
		}
	}
}
