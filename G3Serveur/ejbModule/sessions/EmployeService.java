package sessions;

import java.util.List;

import dao.IDao;
import entities.Employe;
import entities.Etudiant;
import jakarta.annotation.security.PermitAll;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;


@Stateless
public class EmployeService implements IDao<Employe> {

	@PersistenceContext
	private EntityManager em;
	
	
	@Override
	@PermitAll
	public boolean create(Employe o) {
		em.persist(o);
		return true;
	}

	@Override
	public boolean update(Employe o) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean delete(Employe o) {
		em.remove(o);
		return true;
	}

	@Override
	public Employe findById(int id) {
		return em.find(Employe.class, id);
	}

	@Override
	@PermitAll
	public List<Employe> findAll() {
		jakarta.persistence.Query query = em.createQuery("select e from Employe e");
		return query.getResultList();		
	}
	
	

}
