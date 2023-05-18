package com.skilldistillery.jpaspace.data;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaspace.entities.User;

@Service
@Transactional
public class UserDAOImpl implements UserDAO {
	//NO transaction begin/commit
	//NO em.close()
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public User findByUsernameAndPassword(String username, String password) {
		// TODO Auto-generated method stub
		return null;
	}

}
