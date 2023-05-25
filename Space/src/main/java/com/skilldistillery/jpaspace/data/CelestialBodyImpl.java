package com.skilldistillery.jpaspace.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaspace.entities.Category;
import com.skilldistillery.jpaspace.entities.CelestialBody;
import com.skilldistillery.jpaspace.entities.User;

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
	public CelestialBody findBodyByName(String name) {
		CelestialBody body = null;
		String jpql = "SELECT b FROM CelestialBody b WHERE b.name =:n AND b.enabled = true";
		try {
			body = em.createQuery(jpql, CelestialBody.class).setParameter("n", name)
					.getSingleResult();
		} catch (Exception e) {
			System.err.println("Invalid login");
		}
		return body;
	}

	@Override
	public List<CelestialBody> searchByKeyword(String keyword) {
		String queryString = "SELECT body FROM CelestialBody body WHERE body.name LIKE :keyword "
				+ "OR body.description LIKE :keyword";
		List<CelestialBody> bodyList = em.createQuery(queryString, CelestialBody.class)
				.setParameter("keyword", "%" + keyword + "%").getResultList();
		return bodyList;
	}

	@Override
	public CelestialBody postCelestialBody(CelestialBody body, int categoryId) {
		body.setEnabled(true);
		body.setCategory(em.find(Category.class, categoryId));
		String jpql = "SELECT cb FROM CelestialBody cb WHERE cb.name LIKE :bindName"; 
		List<CelestialBody> duplicate = em.createQuery(jpql, CelestialBody.class).
				setParameter("bindName", body.getName()).getResultList();
		CelestialBody managedBody = null;
		if (duplicate.size() == 0 || duplicate.get(0) == null) {
			em.persist(body);
			managedBody = em.find(CelestialBody.class, body.getId());
	}
		return managedBody;
	}

	@Override
	public CelestialBody updateCelestialBodyById(CelestialBody body, int bodyId) {
		CelestialBody managedBody = em.find(CelestialBody.class, bodyId);

		managedBody.setName(body.getName());
		managedBody.setUpdatedAt(body.getUpdatedAt());
		managedBody.setImageUrl(body.getImageUrl());
		managedBody.setDescription(body.getDescription());
		managedBody.setTrackingUrl(body.getTrackingUrl());

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
