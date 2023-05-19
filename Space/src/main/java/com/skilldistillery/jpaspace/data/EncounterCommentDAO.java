package com.skilldistillery.jpaspace.data;

import com.skilldistillery.jpaspace.entities.EncounterComment;

public interface EncounterCommentDAO {
	
	EncounterComment findCommentById(int commentId);
	
	EncounterComment postComment(EncounterComment comment);
	
	EncounterComment updateComment(EncounterComment comment, int commentId);
	
	boolean removeComment(int commentId);

}
