package com.skilldistillery.jpaspace.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaspace.entities.CelestialBody;


@Service
@Transactional
public class CelestialBodyImpl implements CelestialBodyDAO {
	
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public List<CelestialBody> findall() {
		String query = "SELECT body FROM CelestialBody body ";
		List<CelestialBody> queryResults = em.createQuery(query, CelestialBody.class).getResultList();	
		return queryResults;
	}

	@Override
	public CelestialBody findCelestialBodyById(int bodyId) {
		return em.find(CelestialBody.class, bodyId);
	}

	@Override
	public List<CelestialBody> searchByKeyword(String keyword) {
		String queryString = "SELECT body FROM CelestialBody body WHERE body.name LIKE :keyword "
				+ "OR body.description LIKE :keyword";
		List<CelestialBody> bodyList = em.createQuery(queryString, CelestialBody.class)
				 .setParameter("keyword","%" + keyword + "%")
				.getResultList();
		return bodyList;
	}

	@Override
	public CelestialBody postCelestialBody(CelestialBody body) {
			em.persist(body);
		return body;
	}

	@Override
	public CelestialBody updateCelestialBodyById(CelestialBody body, int bodyId) {
		CelestialBody managedBody = em.find(CelestialBody.class, bodyId);

		managedBody.setName(body.getName());
		managedBody.setEnabled(body.getEnabled());
		managedBody.setCreatedAt(body.getCreatedAt());
		managedBody.setUpdatedAt(body.getUpdatedAt());
		managedBody.setImageUrl(body.getImageUrl());
		managedBody.setDescription(body.getDescription());
		managedBody.setComments(body.getComments());
		managedBody.setEncounters(body.getEncounters());
		managedBody.setTrackingUrl(body.getTrackingUrl());
		managedBody.setCategory(body.getCategory());
		managedBody.setParent(body.getParent());
		managedBody.setChildren(body.getChildren());

		return managedBody;
	}

	@Override
	public boolean removeCelestialBodyId(int bodyId) {
		if (bodyId != 0) {
			CelestialBody managedBody = em.find(CelestialBody.class, bodyId);
			em.remove(managedBody);
			return true;
		} else {
			System.out.println("No such work exist");
			return false;
		}
	}

}
