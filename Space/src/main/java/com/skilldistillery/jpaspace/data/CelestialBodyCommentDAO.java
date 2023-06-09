package com.skilldistillery.jpaspace.data;

import java.util.List;

import com.skilldistillery.jpaspace.entities.CelestialBody;
import com.skilldistillery.jpaspace.entities.CelestialBodyComment;

public interface CelestialBodyCommentDAO {
	
	CelestialBodyComment findCommentById(int commentId);
	
	CelestialBodyComment postComment(CelestialBodyComment comment, int userId, int bodyId);
	
	boolean removeCommentById(int commentId);

	List<CelestialBodyComment> findall(CelestialBody cbid);

	CelestialBodyComment updateCommentById(CelestialBodyComment comment, int userId, int bodyId);

}
