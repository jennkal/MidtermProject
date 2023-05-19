package com.skilldistillery.jpaspace.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class EncounterImageTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private EncounterImage image;

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
		image = em.find(EncounterImage.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		image = null;
	}
	
	@Test
	void encounterImage() {
		assertNotNull(image);
		assertEquals(1, image.getEncounter().getId());
	}
	

}
