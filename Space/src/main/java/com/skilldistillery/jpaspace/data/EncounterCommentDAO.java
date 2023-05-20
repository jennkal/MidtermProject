package com.skilldistillery.jpaspace.data;

import java.util.List;

import com.skilldistillery.jpaspace.entities.EncounterComment;

public interface EncounterCommentDAO {
	
	List<EncounterComment> findall();
	
	EncounterComment findCommentById(int commentId);
	
	EncounterComment postComment(EncounterComment comment);
	
	EncounterComment updateComment(EncounterComment comment, int commentId);
	
	boolean removeComment(int commentId);

}
