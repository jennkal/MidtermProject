package com.skilldistillery.jpaspace.data;

import java.util.List;

import com.skilldistillery.jpaspace.entities.Rating;

public interface RatingDAO {
	
	List<Rating> findAll();
	
	Rating findRatingById(int ratingId);
	
	Rating ratingByEncounterIdAndUserId(int encounterId, int userId);
	
	double averageRatingByEncounterId(int encounterId);
	
	Rating postRating( Rating rate, int encounterId, int userId);

	Rating updateRatingById(Rating rate, int rateId);

	boolean removeRatingId(int ratingId);

	List<Rating> ratingByEncounterId(int encounterId);


}
