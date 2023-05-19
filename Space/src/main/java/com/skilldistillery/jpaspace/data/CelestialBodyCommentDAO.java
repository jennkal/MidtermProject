package com.skilldistillery.jpaspace.data;

import com.skilldistillery.jpaspace.entities.CelestialBodyComment;

public interface CelestialBodyCommentDAO {
	
	
	CelestialBodyComment findCommentById(int commentId);
	
	CelestialBodyComment postComment(CelestialBodyComment comment);
	
	CelestialBodyComment updateCommentById(CelestialBodyComment comment, int commentId);
	
	boolean removeCommentById(int commentId);

}
