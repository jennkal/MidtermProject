package com.skilldistillery.jpaspace.data;

import java.util.List;

import com.skilldistillery.jpaspace.entities.EncounterImage;

public interface EncounterImageDAO {
	
	List<EncounterImage> findall();

	EncounterImage findImageId(int imageId);

	EncounterImage postImage(EncounterImage image);

	EncounterImage updateImage(EncounterImage image, int imageId);

	boolean removeImage(int imageId);

}
