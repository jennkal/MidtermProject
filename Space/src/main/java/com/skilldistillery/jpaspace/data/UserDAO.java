package com.skilldistillery.jpaspace.data;

import com.skilldistillery.jpaspace.entities.User;

public interface UserDAO {

	User findById(int userId);

	User findByUsernameAndPassword(String username, String password);

	User addUser(User user);

	boolean removeUser(int userId, User user);

	User updateUser(int userId, User user);

}
