package com.skilldistillery.jpaspace.data;

import java.util.List;

import com.skilldistillery.jpaspace.entities.Encounter;

public interface EncounterDAO {
	
	List<Encounter> findall();
	
	Encounter findEncounterById(int encounterId);   
	
	List<Encounter> searchByKeyword(String keyword);
	
	Encounter postEncounter(Encounter encounter, int userId, int bodyId,
			String imageUrl1, String imageUrl2, String imageUrl3, String imageUrl4, String imageUrl5);
	
	Encounter updateEncounter(Encounter encounter, int encounterId);
	
	boolean removeencounter(int encountertId);

}
