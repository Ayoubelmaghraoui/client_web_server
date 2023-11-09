package entities;

import java.io.Serializable;

import jakarta.persistence.Entity;

@Entity
public class Employe extends Personne implements Serializable{

	private double salaire;

	public Employe() {
		super();
	}

	
	public Employe(String nom, String prenom, double salaire) {
		super(nom, prenom);
		this.salaire = salaire;
	}


	public double getSalaire() {
		return salaire;
	}

	public void setSalaire(double salaire) {
		this.salaire = salaire;
	}

	@Override
	public String toString() {
		return super.toString() + " " + salaire;
	}

}
