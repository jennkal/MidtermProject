package com.skilldistillery.jpaspace.entities;

import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
public class Encounter {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String title;
	private String description;

	private String behavior;

	private Boolean enabled;

	@Column(name = "created_at")
	@CreationTimestamp
	private LocalDateTime createdAt;

	@Column(name = "updated_at")
	@UpdateTimestamp
	private LocalDateTime updatedAt;

	@Column(name = "encounter_date")
	private LocalDate encounterDate;

	@Column(name = "encounter_time")
	private LocalTime encounterTime;

	@Column(name = "capture_method")
	private String captureMethod;

	@ManyToOne
	@JoinColumn(name = "location_id")
	private Location location;

	@ManyToOne
	@JoinColumn(name = "celestial_body_id")
	private CelestialBody celestialBody;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

	@OneToMany(mappedBy = "encounter")
	private List<EncounterImage> images;

	@OneToMany(mappedBy = "encounter")
	private List<EncounterComment> comments;

	@OneToMany(mappedBy = "encounter")
	private List<Rating> ratings;

	@ManyToMany(mappedBy = "favoritedEncounters")
	private List<User> favoritedUsers;

	public Encounter() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getBehavior() {
		return behavior;
	}

	public void setBehavior(String behavior) {
		this.behavior = behavior;
	}

	public Boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}

	public LocalDate getEncounterDate() {
		return encounterDate;
	}

	public void setEncounterDate(LocalDate encounterDate) {
		this.encounterDate = encounterDate;
	}

	public LocalTime getEncounterTime() {
		return encounterTime;
	}

	public void setEncounterTime(LocalTime encounterTime) {
		this.encounterTime = encounterTime;
	}

	public String getCaptureMethod() {
		return captureMethod;
	}

	public void setCaptureMethod(String captureMethod) {
		this.captureMethod = captureMethod;
	}

	public Location getLocation() {
		return location;
	}

	public void setLocation(Location location) {
		this.location = location;
	}

	public CelestialBody getCelestialBody() {
		return celestialBody;
	}

	public void setCelestialBody(CelestialBody celestialBody) {
		this.celestialBody = celestialBody;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<EncounterImage> getImages() {
		return images;
	}

	public void setImages(List<EncounterImage> images) {
		this.images = images;
	}

	public void addImage(EncounterImage image) {
		if (images == null) {
			images = new ArrayList<>();
		}
		if (!images.contains(image)) {
			images.add(image);
			if (image.getEncounter() != null) {
				image.getEncounter().removeImage(image);
			}
			image.setEncounter(this);
		}
	}

	public void removeImage(EncounterImage image) {
		if (images != null && images.contains(image)) {
			images.remove(image);
			image.setEncounter(null);
		}
	}

	public List<EncounterComment> getComments() {
		return comments;
	}

	public void setComments(List<EncounterComment> comments) {
		this.comments = comments;
	}

	public void addComment(EncounterComment comment) {
		if (comments == null) {
			comments = new ArrayList<>();
		}
		if (!comments.contains(comment)) {
			comments.add(comment);
			if (comment.getEncounter() != null) {
				comment.getEncounter().removeComment(comment);
			}
			comment.setEncounter(this);
		}
	}

	public void removeComment(EncounterComment comment) {
		if (comments != null && comments.contains(comment)) {
			comments.remove(comment);
			comment.setEncounter(null);
		}
	}

	public List<Rating> getRatings() {
		return ratings;
	}

	public void setRatings(List<Rating> ratings) {
		this.ratings = ratings;
	}

	public void addRating(Rating rating) {
		if (ratings == null) {
			ratings = new ArrayList<>();
		}
		if (!ratings.contains(rating)) {
			ratings.add(rating);
			if (rating.getEncounter() != null) {
				rating.getEncounter().removeRating(rating);
			}
			rating.setEncounter(this);
		}
	}

	public void removeRating(Rating rating) {
		if (ratings != null && ratings.contains(rating)) {
			ratings.remove(rating);
			rating.setEncounter(null);
		}
	}

	public List<User> getFavoritedUsers() {
		return favoritedUsers;
	}

	public void setFavoritedUsers(List<User> favoritedUsers) {
		this.favoritedUsers = favoritedUsers;
	}

	public void addFavoritedUser(User favoritedUser) {
		if (favoritedUsers == null) {
			favoritedUsers = new ArrayList<>();
		}
		if (!favoritedUsers.contains(favoritedUser)) {
			favoritedUsers.add(favoritedUser);
			favoritedUser.addFavoritedEncounter(this);
		}
	}

	public void removeFavoritedUser(User favoritedUser) {
		if (favoritedUsers != null && favoritedUsers.contains(favoritedUser)) {
			favoritedUsers.remove(favoritedUser);
			favoritedUser.setFavoritedEncounters(null);
		}

	}

	@Override
	public String toString() {
		return "Encounter [id=" + id + ", title=" + title + ", description=" + description + ", behavior=" + behavior
				+ ", enabled=" + enabled + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", encounterDate="
				+ encounterDate + ", encounterTime=" + encounterTime + ", captureMethod=" + captureMethod
				+ ", location=" + location + ", celestialBody=" + celestialBody + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Encounter other = (Encounter) obj;
		return id == other.id;
	}

}
