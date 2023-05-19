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

class ClassificationTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Classification clas;

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
		clas = em.find(Classification.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		clas = null;
	}
	
	@Test
	void clas_mapping() {
		assertNotNull(clas);
		assertEquals("Nebula", clas.getName());
		assertNotNull(clas.getCategories());
		assertEquals("Supernova Remnant",clas.getCategories().get(2).getName());
	}
}
