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

class UserTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;

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
		user = em.find(User.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user = null;
	}

	@Test
	void test() {
		assertNotNull(user);
		assertEquals("admin", user.getUsername());
	}
	
	@Test
	void user_mapping_rating() {
		assertNotNull(user);
		assertNotNull(user.getRatings());
		assertEquals(5, user.getRatings().get(0).getRatingValue());
	}
	
	@Test
	void user_comments() {
		assertNotNull(user);
		assertNotNull(user.getComments());
		assertNotNull(user.getEncounterComments());
		assertEquals("I hope you'll like this super neat picture I found!", user.getComments().get(0).getBody());
		assertEquals("Why hasn't anyone commented yet about how amazing my photo is?", user.getEncounterComments().get(0).getBody());
	}

	@Test
	void user_encounter() {
		assertNotNull(user);
		assertNotNull(user.getEncounters());
		assertEquals("Eagle Sighting!", user.getEncounters().get(0).getTitle());
	}
}
