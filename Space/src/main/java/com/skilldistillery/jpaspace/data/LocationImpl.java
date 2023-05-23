package com.skilldistillery.jpaspace.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaspace.entities.Location;

@Service
@Transactional
public class LocationImpl implements LocationDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public List<Location> findall() {
		String query = "SELECT locate FROM Location locate ";
		List<Location> queryResults = em.createQuery(query, Location.class).getResultList();
		return queryResults;
	}

	@Override
	public Location findLocationById(int locationId) {
		return em.find(Location.class, locationId);
	}

	@Override
	public Location postLocation(Location location) {	
		 em.persist(location);
		 return location;
	}

	@Override
	public Location updateLocation(Location location, int locationId) {
		Location managedLocation = em.find(Location.class, locationId);

		managedLocation.setName(location.getName());
		managedLocation.setAddress(location.getAddress());
		managedLocation.setCity(location.getCity());
		managedLocation.setState(location.getState());
		managedLocation.setCountry(location.getCountry());
		managedLocation.setZipCode(location.getZipCode());
		managedLocation.setEncounters(location.getEncounters());

		return managedLocation;
	}

	@Override
	public boolean removeLocation(int locationId) {
		if (locationId != 0) {
			Location managedLocation = em.find(Location.class, locationId);
			em.remove(managedLocation);
			return true;
		} else {
			System.out.println("No such work exist");
			return false;
		}
	}

}
