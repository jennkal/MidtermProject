package com.skilldistillery.jpaspace.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaspace.entities.CelestialBody;
import com.skilldistillery.jpaspace.entities.CelestialBodyComment;
import com.skilldistillery.jpaspace.entities.User;

@Service
@Transactional
public class CelestialBodyCommentImpl implements CelestialBodyCommentDAO {

	@PersistenceContext
	public EntityManager em;

	@Override
	public List<CelestialBodyComment> findall(CelestialBody cbid) {
		List<CelestialBodyComment> comments = cbid.getComments();
		return comments;
	}

	@Override
	public CelestialBodyComment findCommentById(int commentId) {
		return em.find(CelestialBodyComment.class, commentId);
	}

	@Override
	public CelestialBodyComment postComment(CelestialBodyComment comment, int userId, int bodyId) {

		comment.setUser(em.find(User.class, userId));
		comment.setCelestialBody(em.find(CelestialBody.class, bodyId));
		comment.setEnabled(true);
		em.persist(comment);

		return comment;
	}

	@Override
	public CelestialBodyComment updateCommentById(CelestialBodyComment comment, int userId, int commentId) {
		System.out.println(comment + "this is a comment");
		CelestialBodyComment managed = em.find(CelestialBodyComment.class, commentId);
		System.out.println(managed);
		if (managed != null) {
			managed.setBody(comment.getBody());
		}
		return managed;
	}

	@Override
	public boolean removeCommentById(int commentId) {

		if (commentId != 0) {
			CelestialBodyComment comment = em.find(CelestialBodyComment.class, commentId);

			User user = em.find(User.class, comment.getUser().getId());
			user.removeComment(comment);
			CelestialBody body = em.find(CelestialBody.class, comment.getCelestialBody().getId());
			body.removeComment(comment);

			em.remove(comment);
			return true;
		} else {

			System.out.println("comment doesn't exist");
			return false;
		}
	}
}
