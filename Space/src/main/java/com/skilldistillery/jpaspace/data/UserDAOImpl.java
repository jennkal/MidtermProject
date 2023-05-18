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
		User user = null;
		String jpql = "SELECT u FROM User u WHERE u.username =:un AND u.password = :pw AND u.enabled = true";
		try {
			user = em.createQuery(jpql, User.class).setParameter("un", username).setParameter("pw", password).getSingleResult();
		} catch (Exception e) {
			System.err.println("Invalid login");
		}
		return user;

	}

}
