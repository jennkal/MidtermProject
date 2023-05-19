package com.skilldistillery.jpaspace.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class RatingId implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name = "user_id")
	private int userId;

	@Column(name = "encounter_id")
	private int encounterId;

	public RatingId() {
		super();
	}

	public RatingId(int userId, int encounterId) {
		super();
		this.userId = userId;
		this.encounterId = encounterId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getEncounterId() {
		return encounterId;
	}

	public void setEncounterId(int encounterId) {
		this.encounterId = encounterId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "RatingId [userId=" + userId + ", encounterId=" + encounterId + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(encounterId, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		RatingId other = (RatingId) obj;
		return encounterId == other.encounterId && userId == other.userId;
	}

}
