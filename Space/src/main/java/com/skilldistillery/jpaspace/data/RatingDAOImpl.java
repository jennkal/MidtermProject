package com.skilldistillery.jpaspace.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaspace.entities.Encounter;
import com.skilldistillery.jpaspace.entities.Rating;
import com.skilldistillery.jpaspace.entities.RatingId;
import com.skilldistillery.jpaspace.entities.User;

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
	public List<Rating> ratingByEncounterId(int encounterId) {
		Encounter encounter = em.find(Encounter.class, encounterId);
		return encounter.getRatings();
	}
	
	@Override
	public Rating ratingByEncounterIdAndUserId(int encounterId, int userId) {
		RatingId id = new RatingId(userId, encounterId);
		Rating rating = null;
		try {
			rating = em.find(Rating.class, id);
		}
		catch (Exception e) {}
		return rating;
	}
	
	@Override
	public double averageRatingByEncounterId(int encounterId) {
		String jpql = "SELECT AVG(rating.ratingValue) FROM Rating rating WHERE rating.encounter.id = ?bindId";
		double averageRating = 0;
		try {
			averageRating = em.createQuery(jpql, double.class).setParameter("bindId", encounterId).getSingleResult();
		}
		catch (Exception e) {}
		return averageRating;
	}

	@Override
	public Rating findRatingById(int ratingId) {
		return em.find(Rating.class, ratingId);
	}

	@Override
	public Rating postRating( Rating rate, int encounterId, int userId) {
		RatingId id = new RatingId(userId, encounterId);
		rate.setEncounter(em.find(Encounter.class, encounterId));
		rate.setUser(em.find(User.class, userId));
		rate.setId(id);
			em.persist(rate);
		return rate;
	}

	@Override
	public Rating updateRatingById(Rating rate, int rateId) {
		Rating managedRating = em.find(Rating.class, rateId);

		managedRating.setRatingValue(rate.getRatingValue());
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
