package services;

import models.User;

public interface UserInterface {
	
	public String registerUser(String userName, Long mobileNo, String emailId, String address, int pinCode,
			String password);

	public String registerUser(User user);

	public boolean isRegistered(String emailId);

	public String isValidCredential(String emailId, String password);

	public User getUserDetails(String emailId, String password);

	public String getFName(String emailId);

	public String getUserAddr(String userId);
}
