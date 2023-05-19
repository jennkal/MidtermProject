package com.skilldistillery.jpaspace.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class CelestialBodyTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private CelestialBody body;

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
		body = em.find(CelestialBody.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		body = null;
	}
	
	@Test
	void cb_mapping() {
		assertNotNull(body);
		assertEquals("Messier-16 (Eagle)", body.getName());
		assertNull(body.getTrackingUrl());
	}
	
	@Test
	void cb_list() {
		assertNotNull(body);
		assertNotNull(body.getComments());
		assertNotNull(body.getEncounters());	
		assertEquals("I hope you'll like this super neat picture I found!",body.getComments().get(0).getBody());
		assertEquals(1 ,body.getEncounters().get(0).getUser().getId());
	}

}
