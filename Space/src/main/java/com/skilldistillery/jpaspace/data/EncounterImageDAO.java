package com.skilldistillery.jpaspace.data;

import com.skilldistillery.jpaspace.entities.EncounterImage;

public interface EncounterImageDAO {

	EncounterImage findImageId(int imageId);

	EncounterImage postImage(EncounterImage image);

	EncounterImage updateImage(EncounterImage image, int imageId);

	boolean removeImage(int imageId);

}
