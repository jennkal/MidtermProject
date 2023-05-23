package com.skilldistillery.jpaspace.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaspace.entities.CelestialBody;
import com.skilldistillery.jpaspace.entities.CelestialBodyComment;

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
	public CelestialBodyComment postComment(CelestialBodyComment comment) {
		
		
		em.persist(comment);
		
		return comment;
	}

	@Override
	public CelestialBodyComment updateCommentById(CelestialBodyComment comment, int commentId) {
		
		  CelestialBodyComment managed = em.find(CelestialBodyComment.class, commentId);
		  
		  managed.setBody(comment.getBody());
		  managed.setEnabled(comment.getEnabled());
		  managed.setCreatedAt(comment.getCreatedAt());
		  managed.setUpdatedAt(comment.getUpdatedAt());
		  managed.setReply(comment.getReply());
		  managed.setReplies(comment.getReplies());
		  managed.setUser(comment.getUser());
		  managed.setCelestialBody(comment.getCelestialBody());
	
		return managed;
	}

	@Override
	public boolean removeCommentById(int commentId) {
		
		
		if (commentId != 0) {
			CelestialBodyComment comment = em.find(CelestialBodyComment.class, commentId);
			em.remove(comment);
			return true;
		} else {
		
		System.out.println("comment doesn't exist");
		return false;
		}
	}
}
