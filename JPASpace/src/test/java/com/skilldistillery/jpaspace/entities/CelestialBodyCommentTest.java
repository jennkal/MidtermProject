package com.skilldistillery.jpaspace.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class CelestialBodyCommentTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private CelestialBodyComment comment;

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
		comment = em.find(CelestialBodyComment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		comment = null;
	}
	
	@Test
	void cbComment_mapping() {
		assertNotNull(comment);
		assertEquals(1, comment.getId());
	}
	@Test
	void cbComment_userandCB() {
		assertNotNull(comment);
		assertNotNull(comment.getUser());
		assertNotNull(comment.getCelestialBody());
		assertEquals("3%^bGD7cz", comment.getUser().getPassword());
		assertEquals("Open-cluster of stars in the constellation Serpens. Discovered in 1745. AKA Star Queen Nebula.", comment.getCelestialBody().getDescription());
		assertEquals("https://cdn.spacetelescope.org/archives/images/screen/opo9544b.jpg", comment.getCelestialBody().getImageUrl());
	}
}
