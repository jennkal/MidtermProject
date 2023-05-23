package com.skilldistillery.jpaspace.data;

import java.util.List;

import com.skilldistillery.jpaspace.entities.User;

public interface UserDAO {
	
	List<User> findall();

	User findById(int userId);

	User findByUsernameAndPassword(String username, String password);

	User addUser(User user);

	boolean removeUser(int userId);

	User updateUser(int userId, User user);
	
	List<User> searchByKeyword(String keyword);

	User findByUsername(String username);

	

}
