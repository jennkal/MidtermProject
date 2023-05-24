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

class EncounterTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Encounter encounter;

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
		encounter = em.find(Encounter.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		encounter = null;
	}
	
	@Test
	void encounter_mapping() {
		assertNotNull(encounter);
		assertEquals(true, encounter.getEnabled());
	}
	
	@Test
	void encounter_list() {
		assertNotNull(encounter);
		assertNotNull(encounter.getImages());
		assertNotNull(encounter.getComments());
		assertNotNull(encounter.getRatings());
		
		assertEquals("http://cs.astronomy.com/cfs-file.ashx/__key/telligent-evolution-components-attachments/13-59-00-00-00-49-12-35/M16-_2D00_-SHO_2D00_RGB.jpg", encounter.getImages().get(0).getImageUrl());
		assertEquals(1, encounter.getComments().get(0).getId());
		assertEquals(5, encounter.getRatings().get(0).getRatingValue());
		
	}

}
