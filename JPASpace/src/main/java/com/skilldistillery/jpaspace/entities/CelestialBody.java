package com.skilldistillery.jpaspace.entities;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
public class CelestialBody {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	private Boolean enabled;
	
	private String discription;
	
	@Column(name = "created_at")
	@CreationTimestamp
	private LocalDateTime createdAt;
	
	@Column(name = "updated_at")
	@UpdateTimestamp
	private LocalDateTime updatedAt;
	
	@Column(name = "tracking_url")
	private String trackingUrl;
	
	@ManyToOne
	@JoinColumn(name = "category_id")
	private Category category;
	
	@ManyToOne
	@JoinColumn(name = "parent_celestial_body_id")
	private CelestialBody parent;
	
	@OneToMany(mappedBy = "parent")
	private List<CelestialBody> children;
	
	@OneToMany(mappedBy = "celestialBody")
	private List<CelestialBodyComment> comments;

	@OneToMany(mappedBy = "celestialBody")
	private List<Encounter> encounters;

	public CelestialBody() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}

	public String getDiscription() {
		return discription;
	}

	public void setDiscription(String discription) {
		this.discription = discription;
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

	public String getTrackingUrl() {
		return trackingUrl;
	}

	public void setTrackingUrl(String trackingUrl) {
		this.trackingUrl = trackingUrl;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public CelestialBody getParent() {
		return parent;
	}

	public void setParent(CelestialBody parent) {
		this.parent = parent;
	}

	public List<CelestialBody> getChildren() {
		return children;
	}

	public void setChildren(List<CelestialBody> children) {
		this.children = children;
	}
	public List<CelestialBodyComment> getComments() {
		return comments;
	}
	
	public void setComments(List<CelestialBodyComment> comments) {
		this.comments = comments;
	}

	public List<Encounter> getEncounters() {
		return encounters;
	}

	public void setEncounters(List<Encounter> encounters) {
		this.encounters = encounters;
	}

	@Override
	public String toString() {
		return "CelestialBody [id=" + id + ", name=" + name + ", enabled=" + enabled + ", discription=" + discription
				+ ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", trackingUrl=" + trackingUrl
				+ ", category=" + category + ", parent=" + parent + ", children=" + children + "]";
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
		CelestialBody other = (CelestialBody) obj;
		return id == other.id;
	}



}
