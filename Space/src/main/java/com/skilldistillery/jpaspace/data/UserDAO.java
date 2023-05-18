package com.skilldistillery.jpaspace.data;

import com.skilldistillery.jpaspace.entities.User;

public interface UserDAO {
	
	User findByUsernameAndPassword(String username, String password);

}
