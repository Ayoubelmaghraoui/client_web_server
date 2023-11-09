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

import dao.IdaoLocal;
import dao.RoleIDAO;
import dao.EtudiantIDAO;

import entities.Filiere;
import entities.Role;
import entities.Etudiant;

@WebServlet("/FiliereController")
public class RoleController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@EJB
	RoleIDAO rdao;

	@EJB
	EtudiantIDAO sdao;

    public RoleController() {
        super();
    }
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		List<Role> RoleList = rdao.findAll();	
		System.out.println("=====> liste : "+RoleList);
		request.setAttribute("Roles", RoleList);
		request.getRequestDispatcher("/ListRoles.jsp").forward(request, response);
	}	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    
		String action = request.getParameter("action");
		if ("delete".equals(action)) {
		    int RoleId = Integer.parseInt(request.getParameter("id"));
		    if(rdao.findById(RoleId)!=null) {
		    	Role Roledelete =  rdao.findById(RoleId);
		        boolean updated = rdao.update(Roledelete);
		        if (updated) {
		            rdao.delete(Roledelete);
		            boolean deleted = true;
		            if (deleted) {
		            	List<Role> RoleList = rdao.findAll();	
						System.out.println("====> liste : "+RoleList);
						request.setAttribute("Roles", RoleList);
						request.getRequestDispatcher("/ListRoles.jsp").forward(request, response);
		            } else {
		                response.sendRedirect(request.getContextPath() + "/RoleController?deleteFailed=true");
		            }
		        }
		    }
		}

		else if("edit".equals(action)) {
	        int id = Integer.parseInt(request.getParameter("id"));
	        String name = request.getParameter("Name");
	        Role RoleToEdit = rdao.findById(id);
	        if (RoleToEdit != null) {
	        	RoleToEdit.setName(name);
	            rdao.update(RoleToEdit);
	        }
	        response.sendRedirect(request.getContextPath() + "/RoleController");
	    }
		else if("showform".equals(action)) {
			try {
				showEditForm(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (ServletException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		else if("showlist".equals(action)) {
			try {
				showlist(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (ServletException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		else {
	    String name = request.getParameter("Name");
	    Role newRole = new Role(name);
		    if (rdao.create(newRole)) {
		    	List<Role> RoleList = rdao.findAll();	
				System.out.println("====> liste : "+RoleList);
				request.setAttribute("Roles", RoleList);
				request.getRequestDispatcher("/ListRoles.jsp").forward(request, response);
		    } else {
		    	System.out.println("Failure: Role not created.");
		    }
	    }
	}
	
	private void showlist(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException{
	
		int id = Integer.parseInt(request.getParameter("id"));
	
		List<Etudiant> liste= sdao.findByFiliere(rdao.findById(id).getName());
		RequestDispatcher dispatcher = request.getRequestDispatcher("studentsfield.jsp");
		request.setAttribute("students", liste);
		request.setAttribute("Role", rdao.findById(id).getName());
		dispatcher.forward(request, response);		
		}
	 
	private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Role existingRole = rdao.findById(id);
		RequestDispatcher dispatcher = request.getRequestDispatcher("editField.jsp");
		request.setAttribute("Role", existingRole);
		dispatcher.forward(request, response);
	
	}
}
