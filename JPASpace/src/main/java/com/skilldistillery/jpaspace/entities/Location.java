package com.skilldistillery.jpaspace.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Location {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	private String address;
	
	private String city;
	
	private String state;
	
	private String country;
	
	@Column(name = "zip_code")
	private String zipCode;
	
	@OneToMany(mappedBy = "location")
	private List<Encounter> encounters;

	public Location() {
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
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
			if (encounter.getLocation() != null) {
				encounter.getLocation().removeEncounter(encounter);
			}
			encounter.setLocation(this);
		}
	}

	public void removeEncounter(Encounter encounter) {
		if (encounters != null && encounters.contains(encounter)) {
			encounters.remove(encounter);
			encounter.setLocation(null);
		}
	}


	@Override
	public String toString() {
		return "Location [id=" + id + ", name=" + name + ", address=" + address + ", city=" + city + ", state=" + state
				+ ", country=" + country + ", zipCode=" + zipCode + "]";
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
		Location other = (Location) obj;
		return id == other.id;
	}
	
	

}
