package com.skilldistillery.jpaspace.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaspace.entities.Encounter;
import com.skilldistillery.jpaspace.entities.EncounterImage;

@Service
@Transactional
public class EncounterImageImpl implements EncounterImageDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public List<EncounterImage> findall() {
		String query = "SELECT image FROM EncounterImage image ";
		List<EncounterImage> queryResults = em.createQuery(query, EncounterImage.class).getResultList();
		return queryResults;
	}

	@Override
	public EncounterImage findImageId(int imageId) {
		return em.find(EncounterImage.class, imageId);
	}

	@Override
	public EncounterImage postImage(EncounterImage image) {
		 em.persist(image);
		 return image;
	}

	@Override
	public EncounterImage updateImage(EncounterImage image, int imageId) {
		EncounterImage managedImage = em.find(EncounterImage.class, imageId);

		managedImage.setImageUrl(image.getImageUrl());
		managedImage.setEncounter(image.getEncounter());
		

		return managedImage;
	}

	@Override
	public boolean removeImage(int imageId) {
		if (imageId != 0) {
			EncounterImage managedImage = em.find(EncounterImage.class, imageId);
			em.remove(managedImage);
			return true;
		} else {
			System.out.println("No such work exist");
			return false;
		}
	}

	@Override
	public List<EncounterImage> findImageByEncouterId(int encounterId) {
		Encounter encounter = em.find(Encounter.class, encounterId);
		return encounter.getImages();
	}

}
