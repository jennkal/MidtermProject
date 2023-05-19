package com.skilldistillery.jpaspace.entities;

import static org.junit.jupiter.api.Assertions.*;

import java.time.Month;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class EnounterCommentTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private EncounterComment comment;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPASpace");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		comment = em.find(EncounterComment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		comment = null;
	}
	
	@Test
	void encountercomment_mappeing() {
		assertNotNull(comment);
		assertEquals("Why hasn't anyone commented yet about how amazing my photo is?", comment.getBody());
		assertEquals(2023, comment.getCreatedAt().getYear());
	}
	
	@Test
	void encounter_user_encounter() {
		assertNotNull(comment);
		assertNotNull(comment.getUser());
		assertNotNull(comment.getEncounter());
		assertEquals(Month.MAY, comment.getUser().getUpdatedAt().getMonth());
		assertEquals("It was a glowing and colorful night. Who could resist some telescope time? Lucky idea since I captured this boss image.", comment.getEncounter().getDescription());
	}
	

}
