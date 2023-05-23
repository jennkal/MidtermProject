package com.skilldistillery.jpaspace.data;

import java.util.List;

import com.skilldistillery.jpaspace.entities.Rating;

public interface RatingDAO {
	
	List<Rating> findAll();
	
	Rating findRatingById(int ratingId);
	
	int postRating(int rateId);

	Rating updateRatingById(Rating rate, int rateId);

	boolean removeRatingId(int ratingId);

	List<Rating> ratingByEncounterId(int encounterId);


}
