package com.skilldistillery.jpaspace.data;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaspace.entities.CelestialBody;
import com.skilldistillery.jpaspace.entities.Encounter;
import com.skilldistillery.jpaspace.entities.EncounterImage;
import com.skilldistillery.jpaspace.entities.Rating;
import com.skilldistillery.jpaspace.entities.RatingId;
import com.skilldistillery.jpaspace.entities.User;

@Service
@Transactional
public class EncounterImpl implements EncounterDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public List<Encounter> findall() {
		List<Encounter> allEncounters = new ArrayList<>();
		String jpql = "SELECT encounter FROM Encounter encounter";
		allEncounters = em.createQuery(jpql, Encounter.class).getResultList();
		return allEncounters;
	}

	@Override
	public Encounter findEncounterById(int encounterId) {
		Encounter encounter = em.find(Encounter.class, encounterId);
		return encounter;
	}
	
	@Override
	public List<Encounter> findEncountersByBodyId(int bodyId) {
		CelestialBody body = em.find(CelestialBody.class, bodyId);
		List<Encounter> bodyEncounters = body.getEncounters();
		return bodyEncounters;
	}

	@Override
	public List<Encounter> searchByKeyword(String keyword) {
		List<Encounter> keywordEncounters = new ArrayList<>();
		String jpql = "SELECT encounter FROM Encounter encounter WHERE encounter.title LIKE :bindKeyword "
				+ "OR encounter.description LIKE :bindKeyword OR encounter.behavior LIKE :bindKeyword";
		keywordEncounters = em.createQuery(jpql, Encounter.class).setParameter("bindKeyword", "%" + keyword + "%").getResultList();
		return keywordEncounters;
	}

	@Override
	public Encounter postEncounter(Encounter encounter, int userId, int bodyId,
			String imageUrl1, String imageUrl2, String imageUrl3, String imageUrl4, String imageUrl5) {
		
		encounter.setUser(em.find(User.class, userId));
		encounter.setCelestialBody(em.find(CelestialBody.class, bodyId));
		encounter.setEnabled(true);
				
		Encounter newEncounter = null;
		em.persist(encounter);
		newEncounter = em.find(Encounter.class, encounter.getId());
		
		List<String> imageUrls = new ArrayList<>();
		List<EncounterImage> images = new ArrayList<>();
		if (imageUrl1 != null && !imageUrl1.equals("")) {
			imageUrls.add(imageUrl1);
		}
		if (imageUrl2 != null && !imageUrl2.equals("")) {
			imageUrls.add(imageUrl2);
		}
		if (imageUrl3 != null && !imageUrl3.equals("")) {
			imageUrls.add(imageUrl3);
		}
		if (imageUrl4 != null && !imageUrl4.equals("")) {
			imageUrls.add(imageUrl4);
		}
		if (imageUrl5 != null && !imageUrl5.equals("")) {
			imageUrls.add(imageUrl5);
		}
		if (imageUrls.size() > 0) {
			for (String urlString : imageUrls) {
				EncounterImage newImage = new EncounterImage();
				newImage.setEncounter(newEncounter);
				newImage.setImageUrl(urlString);
				em.persist(newImage);
				images.add(newImage);
			}
		}
		
		if (images.size() > 0) {
		newEncounter.setImages(images);
		}
		
		return newEncounter;
	}

	@Override
	public Encounter updateEncounter(Encounter encounter, int encounterId) {
		Encounter managedEncounter = em.find(Encounter.class, encounterId);
		managedEncounter.setTitle(encounter.getTitle());
		managedEncounter.setDescription(encounter.getDescription());
		managedEncounter.setBehavior(encounter.getBehavior());
		managedEncounter.setUpdatedAt(encounter.getUpdatedAt());
		managedEncounter.setEncounterDate(encounter.getEncounterDate());
		managedEncounter.setEncounterTime(encounter.getEncounterTime());
		managedEncounter.setCaptureMethod(encounter.getCaptureMethod());
		return managedEncounter;
	}

	@Override
	public boolean removeEncounter(int encounterId) {
		boolean removedEncounter;
		Encounter managedEncounter = em.find(Encounter.class, encounterId);
		User user = em.find(User.class, managedEncounter.getUser().getId());
		user.removeEncounter(managedEncounter);
		CelestialBody body = em.find(CelestialBody.class, managedEncounter.getCelestialBody().getId());
		body.removeEncounter(managedEncounter);
		List<EncounterImage> images = managedEncounter.getImages();
		for (EncounterImage encounterImage : images) {
			EncounterImage managedImage = em.find(EncounterImage.class, encounterImage.getId());
			em.remove(encounterImage);
		}
		List<Rating> ratings = managedEncounter.getRatings();
		for (Rating rating : ratings) {
			RatingId id = new RatingId(rating.getUser().getId(), rating.getEncounter().getId());
			Rating managedRating = em.find(Rating.class, id);
			em.remove(managedRating);
		}
		try {
			em.remove(managedEncounter);
			removedEncounter = true;
		}
		catch (Exception e) {
			removedEncounter = false;
		}
		return removedEncounter;
	}

}
