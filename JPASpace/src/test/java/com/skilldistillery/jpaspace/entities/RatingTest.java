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

class RatingTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Rating rate;

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
		RatingId id = new RatingId();
		id.setUserId(1);
		id.setEncounterId(1);
		em = emf.createEntityManager();
		rate = em.find(Rating.class, id);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		rate = null;
	}
	
	@Test
	void rating_mapping() {
		assertNotNull(rate);
		assertNotNull(rate.getRatingValue());
		assertEquals(5, rate.getRatingValue());
	}
	
	@Test 
	void rating_user() {
		assertNotNull(rate);
		assertNotNull(rate.getUser());
		assertEquals("ADMIN", rate.getUser().getRole());
	}
	@Test 
	void rating_encouter() {
		assertNotNull(rate);
		assertNotNull(rate.getEncounter());
		assertEquals("QHY 5III585C Planetary Camera and Guider",rate.getEncounter().getCaptureMethod());
	}

}
