package com.skilldistillery.jpaspace.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.jpaspace.entities.Category;

@Service
@Transactional
public class CategoryDAOImpl implements CategoryDAO {
	
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public List<Category> findClassId(int clasId) {
		String jpql = "SELECT cat FROM Category cat WHERE cat.classification = :bindId";
		List<Category> clas = em.createQuery(jpql, Category.class).setParameter("bindId", clasId).getResultList();
		return clas;
	}

}
