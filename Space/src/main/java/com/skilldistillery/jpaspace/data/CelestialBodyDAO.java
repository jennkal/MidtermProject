package com.skilldistillery.jpaspace.data;

import java.util.List;

import com.skilldistillery.jpaspace.entities.CelestialBody;

public interface CelestialBodyDAO {

	CelestialBody findCelestialBodyById(int bodyId);
	
	List<CelestialBody> searchByKeyword(String keyword);

	CelestialBody postCelestialBody(CelestialBody body);

	CelestialBody updateCelestialBodyById(CelestialBody body, int bodyId);

	boolean removeCelestialBodyId(int bodyId);

}
