package entities;

import entities.Personne;
import jakarta.persistence.Entity;

import java.io.Serializable;
import java.lang.String;


/**
 * Entity implementation class for Entity: Etudiant
 *
 */
@Entity
public class Etudiant extends Personne implements Serializable {

	
	private String cne;
	private static final long serialVersionUID = 1L;

	public Etudiant() {
		super();
	}   
	public String getCne() {
		return this.cne;
	}

	public void setCne(String cne) {
		this.cne = cne;
	}
   
}
