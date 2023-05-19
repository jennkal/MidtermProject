package com.skilldistillery.jpaspace.data;

import com.skilldistillery.jpaspace.entities.Location;

public interface LocationDAO {
	
	Location findLocationById(int locationId);
	
	Location postLocation(Location location);
	
	Location updateLocation(Location location, int locationId);
	
	boolean removeLocation(int locationId);

}
