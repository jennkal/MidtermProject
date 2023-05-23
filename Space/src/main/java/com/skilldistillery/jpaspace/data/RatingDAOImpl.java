package com.skilldistillery.jpaspace.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaspace.entities.Rating;

@Service
@Transactional
public class RatingDAOImpl implements RatingDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public List<Rating> findAll() {
		String query = "SELECT rate FROM Rating rate ";
		List<Rating> queryResults = em.createQuery(query, Rating.class).getResultList();
		return queryResults;
	}

	@Override
	public Rating findRatingById(int ratingId) {
		return em.find(Rating.class, ratingId);
	}

	@Override
	public Rating postRating(Rating rate, int encounterId) {
		em.persist(rate);
		 return rate;
	}

	@Override
	public Rating updateRatingById(Rating rate, int encounterId) {
		Rating managedRating = em.find(Rating.class, encounterId);

		managedRating.setRating(rate.getRating());
		managedRating.setUser(rate.getUser());
		managedRating.setCreatedAt(rate.getCreatedAt());
		managedRating.setUpdatedAt(rate.getUpdatedAt());
		managedRating.setEncounter(rate.getEncounter());
		
		return managedRating;
	}

	@Override
	public boolean removeRatingId(int ratingId) {
		if (ratingId != 0) {
			Rating managedRating = em.find(Rating.class, ratingId);
			em.remove(managedRating);
			return true;
		} else {
			System.out.println("No such work exist");
			return false;
		}
	}

}
