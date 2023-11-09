import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import dao.IDao;
import entities.Employe;

public class TestEmploye {
	
	public static IDao<Employe> lookUpEmployeRemote() throws NamingException {
		final Hashtable jndiProperties = new Hashtable();
		jndiProperties.put(Context.INITIAL_CONTEXT_FACTORY, "org.wildfly.naming.client.WildFlyInitialContextFactory");
		jndiProperties.put(Context.PROVIDER_URL, "http-remoting://localhost:8080");
		final Context context = new InitialContext(jndiProperties);

		return (IDao<Employe>) context.lookup("ejb:/G3Serveur/EmployeService!dao.IDao");

	}

	public static void main(String[] args) {
		
		try {
			IDao<Employe> dao = lookUpEmployeRemote();
			dao.create(new Employe("rami", "hamid", 7000));
			dao.create(new Employe("safi", "imane", 8000));
			//dao.delete(dao.findById(1));
			
			for(Employe e : dao.findAll())
				System.out.println(e);
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
