package com.skilldistillery.jpaspace.data;

import java.util.List;

import com.skilldistillery.jpaspace.entities.CelestialBody;

public interface CelestialBodyDAO {
	
	List<CelestialBody> findall();

	CelestialBody findCelestialBodyById(int bodyId);
	
	List<CelestialBody> searchByKeyword(String keyword);

	CelestialBody postCelestialBody(CelestialBody body, int categoryId);

	CelestialBody updateCelestialBodyById(CelestialBody body, int bodyId);

	boolean removeCelestialBodyId(int bodyId);
	
	CelestialBody findBodyByName(String name);

}
