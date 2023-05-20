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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name="celestial_body_comment")
public class CelestialBodyComment {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String body;

	private Boolean enabled;

	@Column(name = "created_at")
	@CreationTimestamp
	private LocalDateTime createdAt;

	@Column(name = "updated_at")
	@UpdateTimestamp
	private LocalDateTime updatedAt;

	@ManyToOne
	@JoinColumn(name = "in_reply_to_id")
	private CelestialBodyComment reply;
	
	@OneToMany(mappedBy = "reply")
	private List<CelestialBodyComment> replies;
	
	@ManyToOne
	@JoinColumn (name = "user_id")
	private User user;
	
	@ManyToOne
	@JoinColumn(name = "celestial_body_id")
	private CelestialBody celestialBody;
	
	

	public CelestialBodyComment() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
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

	public CelestialBodyComment getReply() {
		return reply;
	}

	public void setReply(CelestialBodyComment reply) {
		this.reply = reply;
	}

	public List<CelestialBodyComment> getReplies() {
		return replies;
	}

	public void setReplies(List<CelestialBodyComment> replies) {
		this.replies = replies;
	}
	
	public void addReply(CelestialBodyComment reply) {
		if (replies == null) {
			replies = new ArrayList<>();
		}
		if (!replies.contains(reply)) {
			replies.add(reply);
			if (reply.getReply() != null) {
				reply.getReply().removeReply(reply);
			}
			reply.setReply(this);
		}
	}

	public void removeReply(CelestialBodyComment reply) {
		if (replies != null && replies.contains(reply)) {
			replies.remove(reply);
			reply.setReply(null);
		}
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public CelestialBody getCelestialBody() {
		return celestialBody;
	}

	public void setCelestialBody(CelestialBody celestialBody) {
		this.celestialBody = celestialBody;
	}

	@Override
	public String toString() {
		return "CelestialBodyComment [id=" + id + ", body=" + body + ", enabled=" + enabled + ", createdAt=" + createdAt
				+ ", updatedAt=" + updatedAt + ", reply=" + reply + ", replies=" + replies + ", user=" + user
				+ ", celestialBody=" + celestialBody + "]";
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
		CelestialBodyComment other = (CelestialBodyComment) obj;
		return id == other.id;
	}
	
}
