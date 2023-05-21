package com.skilldistillery.jpaspace.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaspace.entities.User;

@Service
@Transactional
public class UserDAOImpl implements UserDAO {
	// NO transaction begin/commit
	// NO em.close()

	@PersistenceContext
	private EntityManager em;

	@Override
	public User findByUsernameAndPassword(String username, String password) {
		User user = null;
		String jpql = "SELECT u FROM User u WHERE u.username =:un AND u.password = :pw AND u.enabled = true";
		try {
			user = em.createQuery(jpql, User.class).setParameter("un", username).setParameter("pw", password)
					.getSingleResult();
		} catch (Exception e) {
			System.err.println("Invalid login");
		}
		return user;

	}


	@Override
	public User findById(int userId) {
		return em.find(User.class, userId);
	}

	@Override
	public User addUser(User user) {
		String jpql = "SELECT u FROM User u WHERE u.username LIKE :bindName"; 
		List<User> duplicate = em.createQuery(jpql, User.class).
				setParameter("bindName", user.getUsername()).getResultList();
		User newUser = null;
		if (duplicate.size() == 0 || duplicate.get(0) == null) {
				em.persist(user);
				newUser = em.find(User.class, user.getId());
		}
		return newUser;
	}

	@Override
	public boolean removeUser(int userId) {
		if (userId != 0) {
			User managedUser = em.find(User.class, userId);
			em.remove(managedUser);
			return true;
		} else {
			System.out.println("No such work exist");
			return false;
		}
	}

	@Override
	public User updateUser(int userId, User user) {
		User managedUser = em.find(User.class, userId);

		managedUser.setUsername(user.getUsername());
		managedUser.setPassword(user.getPassword());
		managedUser.setEnabled(user.getEnabled());
		managedUser.setRole(user.getRole());
		managedUser.setCreatedAt(user.getCreatedAt());
		managedUser.setUpdatedAt(user.getUpdatedAt());
		managedUser.setImageUrl(user.getImageUrl());
		managedUser.setAbout(user.getAbout());
		managedUser.setComments(user.getComments());
		managedUser.setEncounters(user.getEncounters());
		managedUser.setEncounterComments(user.getEncounterComments());
		managedUser.setRatings(user.getRatings());
		managedUser.setFavoritedEncounters(user.getFavoritedEncounters());

		return managedUser;
	}

	@Override
	public List<User> findall() {
		String query = "SELECT user FROM User user ";
		List<User> queryResults = em.createQuery(query, User.class).getResultList();
		return queryResults;
	}

	@Override
	public List<User> searchByKeyword(String keyword) {
		String queryString = "SELECT user FROM User user WHERE user.username LIKE :keyword "
				+ "OR user.about LIKE :keyword";
		List<User> userList = em.createQuery(queryString, User.class)
				 .setParameter("keyword","%" + keyword + "%")
				.getResultList();
		return userList;
	}

}
