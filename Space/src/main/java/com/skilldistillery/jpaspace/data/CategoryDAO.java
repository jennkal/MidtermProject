package com.skilldistillery.jpaspace.data;

import java.util.List;

import com.skilldistillery.jpaspace.entities.Category;

public interface CategoryDAO {
	
	List<Category> findClassId(int clasId);
	

}
