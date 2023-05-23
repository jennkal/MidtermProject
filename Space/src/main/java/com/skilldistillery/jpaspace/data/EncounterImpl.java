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
import com.skilldistillery.jpaspace.entities.User;

@Service
@Transactional
public class EncounterImpl implements EncounterDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public List<Encounter> findall() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Encounter findEncounterById(int encounterId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Encounter> searchByKeyword(String keyword) {
		// TODO Auto-generated method stub
		return null;
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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean removeencounter(int encountertId) {
		// TODO Auto-generated method stub
		return false;
	}

}
