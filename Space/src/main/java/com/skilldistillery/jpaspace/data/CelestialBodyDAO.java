package com.skilldistillery.jpaspace.data;

import java.util.List;

import com.skilldistillery.jpaspace.entities.CelestialBody;
import com.skilldistillery.jpaspace.entities.CelestialBodyComment;

public interface CelestialBodyDAO {
	
	List<CelestialBody> findall();

	CelestialBody findCelestialBodyById(int bodyId);
	
	List<CelestialBody> searchByKeyword(String keyword);

	CelestialBody postCelestialBody(CelestialBody body);

	CelestialBody updateCelestialBodyById(CelestialBody body, int bodyId);

	boolean removeCelestialBodyId(int bodyId);

}
