package com.skilldistillery.jpaspace.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String username;
	private String password;
	private Boolean enabled;
	private String role;

	@Column(name = "created_at")
	@CreationTimestamp
	private LocalDateTime createdAt;

	@Column(name = "updated_at")
	@UpdateTimestamp
	private LocalDateTime updatedAt;

	@Column(name = "image_url")
	private String imageUrl;

	private String about;

	@OneToMany(mappedBy = "user")
	private List<CelestialBodyComment> comments;

	@OneToMany(mappedBy = "user")
	private List<Encounter> encounters;

	@OneToMany(mappedBy = "user")
	private List<EncounterComment> encounterComments;

	@OneToMany(mappedBy = "user")
	private List<Rating> ratings;

	@ManyToMany
	@JoinTable(name = "user_favorited_encounter", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "encounter_id"))
	private List<Encounter> favoritedEncounters;

	public User() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(Boolean enable) {
		this.enabled = enable;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
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

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getAbout() {
		return about;
	}

	public void setAbout(String about) {
		this.about = about;
	}

	public List<CelestialBodyComment> getComments() {
		return comments;
	}

	public void setComments(List<CelestialBodyComment> comments) {
		this.comments = comments;
	}
	
	public void addComment(CelestialBodyComment comment) {
		if (comments == null) {
			comments = new ArrayList<>();
		}
		if (!comments.contains(comment)) {
			comments.add(comment);
			if (comment.getUser() != null) {
				comment.getUser().removeComment(comment);
			}
			comment.setUser(this);
		}
	}

	public void removeComment(CelestialBodyComment comment) {
		if (comments != null && comments.contains(comment)) {
			comments.remove(comment);
			comment.setUser(null);
		}
	}

	public List<Encounter> getEncounters() {
		return encounters;
	}

	public void setEncounters(List<Encounter> encounters) {
		this.encounters = encounters;
	}

	public void addEncounter(Encounter encounter) {
		if (encounters == null) {
			encounters = new ArrayList<>();
		}
		if (!encounters.contains(encounter)) {
			encounters.add(encounter);
			if (encounter.getUser() != null) {
				encounter.getUser().removeEncounter(encounter);
			}
			encounter.setUser(this);
		}
	}

	public void removeEncounter(Encounter encounter) {
		if (encounters != null && encounters.contains(encounter)) {
			encounters.remove(encounter);
			encounter.setUser(null);
		}
	}

	
	public List<EncounterComment> getEncounterComments() {
		return encounterComments;
	}

	public void setEncounterComments(List<EncounterComment> encounterComments) {
		this.encounterComments = encounterComments;
	}
	
	public void addEncounterComment(EncounterComment comment) {
		if (encounterComments == null) {
			encounterComments = new ArrayList<>();
		}
		if (!encounterComments.contains(comment)) {
			encounterComments.add(comment);
			if (comment.getUser() != null) {
				comment.getUser().removeEncounterComment(comment);
			}
			comment.setUser(this);
		}
	}

	public void removeEncounterComment(EncounterComment comment) {
		if (encounterComments != null && encounterComments.contains(comment)) {
			encounterComments.remove(comment);
			comment.setUser(null);
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
			if (rating.getUser() != null) {
				rating.getUser().removeRating(rating);
			}
			rating.setUser(this);
		}
	}

	public void removeRating(Rating rating) {
		if (ratings != null && ratings.contains(rating)) {
			ratings.remove(rating);
			rating.setUser(null);
		}
	}

	public List<Encounter> getFavoritedEncounters() {
		return favoritedEncounters;
	}

	public void setFavoritedEncounters(List<Encounter> favoritedEncounters) {
		this.favoritedEncounters = favoritedEncounters;
	}

	public void addFavoritedEncounter(Encounter favoritedEncounter) {
		if (favoritedEncounters == null) {
			favoritedEncounters = new ArrayList<>();
		}
		if (!favoritedEncounters.contains(favoritedEncounter)) {
			favoritedEncounters.add(favoritedEncounter);
			favoritedEncounter.addFavoritedUser(this);
		}
	}

	public void removeFavoritedEncounter(Encounter favoritedEncounter) {
		if (favoritedEncounters != null && favoritedEncounters.contains(favoritedEncounter)) {
			favoritedEncounters.remove(favoritedEncounter);
			favoritedEncounter.setFavoritedUsers(null);
		}
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", enabled=" + enabled
				+ ", role=" + role + "]";
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
		User other = (User) obj;
		return id == other.id;
	}

}
