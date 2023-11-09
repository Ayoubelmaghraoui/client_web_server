package controller;
 
import jakarta.ejb.EJB;

import jakarta.servlet.RequestDispatcher;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;

import jakarta.servlet.http.HttpServletRequest;

import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import java.sql.SQLException;

import java.util.List;
 
import dao.FiliereIDAO;
import dao.RoleIDAO;
import dao.EtudiantIDAO;

import entities.Filiere;
import entities.Role;
import entities.Etudiant;

@WebServlet("/FiliereController")
public class EtudiantController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@EJB
	FiliereIDAO fdao;

	@EJB
	EtudiantIDAO sdao;
	
	@EJB
	RoleIDAO rdao;

    public EtudiantController() {
        super();
    }
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		List<Etudiant> EtudiantList = sdao.findAll();
		List<Filiere> FiliereList = fdao.findAll();
		List<Role> RolesList = rdao.findAll();
		System.out.println("liste : "+RolesList);
		request.setAttribute("Etudiants", EtudiantList);
		request.setAttribute("filieres", FiliereList);
		request.setAttribute("Roles", RolesList);
		request.getRequestDispatcher("/ListEtudiants.jsp").forward(request, response);
	}	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    
		String action = request.getParameter("action");
		if ("delete".equals(action)) {
		    int EtudiantId = Integer.parseInt(request.getParameter("id"));
		    if(sdao.findById(EtudiantId)!=null) {
		    	Etudiant Etudiantdelete =  sdao.findById(EtudiantId);
		        
		        boolean updated = sdao.update(Etudiantdelete);
		        if (updated) {
		            sdao.delete(Etudiantdelete);
		            boolean deleted = true;
		            if (deleted) {
		                response.sendRedirect(request.getContextPath() + "/EtudiantController");
		            } else {
		                response.sendRedirect(request.getContextPath() + "/EtudiantController?deleteFailed=true");
		            }
		        }
		    }
		}

		else if("edit".equals(action)) {
	        int id = Integer.parseInt(request.getParameter("id"));
	        String login = request.getParameter("login");
			String Fname = request.getParameter("firstName");
			String Lname = request.getParameter("lastName");
			String tele = request.getParameter("telephone");
	        Etudiant EtudiantToEdit = sdao.findById(id);
	        if (EtudiantToEdit != null) {
	        	EtudiantToEdit.setLogin(login);
	        	EtudiantToEdit.setFirstName(Fname);
	        	EtudiantToEdit.setLastName(Lname);
	        	EtudiantToEdit.setTelephone(tele);
	            sdao.update(EtudiantToEdit);
	        }
	        response.sendRedirect(request.getContextPath() + "/EtudiantController");
	    }
		else if("addRole".equals(action)) {
			int etdId = Integer.parseInt(request.getParameter("studentId"));
			int roleId = Integer.parseInt(request.getParameter("role"));
			Etudiant etd = sdao.findById(etdId);
			Role role = rdao.findById(roleId);
			System.out.println(etd);
			System.out.println(role);
			
			etd.getRoles().add(role);
			sdao.update(etd);
			response.sendRedirect(request.getContextPath() + "/EtudiantController");
		}
		else if("filterByFiliere".equals(action)) {
			int filiereId = Integer.parseInt(request.getParameter("filterFiliere"));
			
			if (filiereId == 0) {
				List<Etudiant> EtudiantList = sdao.findAll();
				request.setAttribute("Etudiants", EtudiantList);
			}else {
				Filiere filiere = fdao.findById(filiereId);
				String filiereName = filiere.getName();
				List<Etudiant> EtudiantList = sdao.findByFiliere(filiereName);
				request.setAttribute("Etudiants", EtudiantList);
			}
			
			List<Filiere> FiliereList = fdao.findAll();
			List<Role> RolesList = rdao.findAll();
			request.setAttribute("filieres", FiliereList);
			request.setAttribute("Roles", RolesList);
			request.getRequestDispatcher("/ListEtudiants.jsp").forward(request, response);
		}
		else {
			String login = request.getParameter("login");
			String Fname = request.getParameter("firstName");
			String Lname = request.getParameter("lastName");
			String tele = request.getParameter("telephone");
			int filiereId = Integer.parseInt(request.getParameter("filiere"));
			Filiere f = fdao.findById(filiereId);
			Etudiant newEtudiant = new Etudiant(login,"", Fname, Lname, tele, f);
		    if (sdao.create(newEtudiant)) {
		    	List<Etudiant> EtudiantList = sdao.findAll();
				List<Filiere> FiliereList = fdao.findAll();
				List<Role> RolesList = rdao.findAll();
				System.out.println("liste : "+EtudiantList);
				request.setAttribute("Etudiants", EtudiantList);
				request.setAttribute("filieres", FiliereList);
				request.setAttribute("Roles", RolesList);
				request.getRequestDispatcher("/ListEtudiants.jsp").forward(request, response);
		    } else {
		    	System.out.println("Failure: Etudiant not created.");
		    }
	    }
	}
	
}
