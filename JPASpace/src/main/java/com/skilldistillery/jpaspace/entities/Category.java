package com.skilldistillery.jpaspace.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Category {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;

	@ManyToOne
	@JoinColumn(name = "classification_id")
	private Classification classification;

	@OneToMany(mappedBy = "category")
	private List<CelestialBody> bodies;

	public Category() {
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

	public Classification getClassification() {
		return classification;
	}

	public void setClassification(Classification classification) {
		this.classification = classification;
	}

	public List<CelestialBody> getBodies() {
		return bodies;
	}

	public void setBodies(List<CelestialBody> bodies) {
		this.bodies = bodies;
	}

	public void addBody(CelestialBody body) {
		if (bodies == null) {
			bodies = new ArrayList<>();
		}
		if (!bodies.contains(body)) {
			bodies.add(body);
			if (body.getCategory() != null) {
				body.getCategory().removeBody(body);
			}
			body.setCategory(this);
		}
	}

	public void removeBody(CelestialBody body) {
		if (bodies != null && bodies.contains(body)) {
			bodies.remove(body);
			body.setCategory(null);
		}
	}

	@Override
	public String toString() {
		return "Category: name = " + name;
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
		Category other = (Category) obj;
		return id == other.id;
	}

}
