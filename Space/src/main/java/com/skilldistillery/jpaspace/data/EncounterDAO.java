package com.skilldistillery.jpaspace.data;

import java.util.List;

import com.skilldistillery.jpaspace.entities.Encounter;

public interface EncounterDAO {
	
	Encounter findEncounterById(int encounterId);   
	
	List<Encounter> searchByKeyword(String keyword);
	
	Encounter postEncounter(Encounter encounter);
	
	Encounter updateEncounter(Encounter encounter, int encounterId);
	
	boolean removeencounter(int encountertId);

}
