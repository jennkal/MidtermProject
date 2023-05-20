package com.skilldistillery.jpaspace.data;

import java.util.List;

import com.skilldistillery.jpaspace.entities.Location;

public interface LocationDAO {
	
	List<Location> findall();
	
	Location findLocationById(int locationId);
	
	Location postLocation(Location location);
	
	Location updateLocation(Location location, int locationId);
	
	boolean removeLocation(int locationId);

}
