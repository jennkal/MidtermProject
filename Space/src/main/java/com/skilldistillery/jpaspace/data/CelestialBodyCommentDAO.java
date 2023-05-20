package com.skilldistillery.jpaspace.data;

import java.util.List;

import com.skilldistillery.jpaspace.entities.CelestialBodyComment;

public interface CelestialBodyCommentDAO {
	
	List<CelestialBodyComment> findall();
	
	CelestialBodyComment findCommentById(int commentId);
	
	CelestialBodyComment postComment(CelestialBodyComment comment);
	
	CelestialBodyComment updateCommentById(CelestialBodyComment comment, int commentId);
	
	boolean removeCommentById(int commentId);

}
