package com.skilldistillery.jpaspace.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaspace.entities.Category;
import com.skilldistillery.jpaspace.entities.Classification;

@Service
@Transactional
public class CategoryDAOImpl implements CategoryDAO {
	
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public List<Category> findByClassificationId(int clasId) {
		Classification classification = em.find(Classification.class, clasId);
		return classification.getCategories();
	}

}
