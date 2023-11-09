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

import dao.EtudiantIDAO;

import entities.Filiere;

import entities.Etudiant;

@WebServlet("/FiliereController")
public class FiliereController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@EJB
	FiliereIDAO fdao;

	@EJB
	EtudiantIDAO sdao;

    public FiliereController() {
        super();
    }
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		List<Filiere> fieldList = fdao.findAll();	
		System.out.println("liste : "+fieldList);
		request.setAttribute("Filieres", fieldList);
		request.getRequestDispatcher("/ListFilieres.jsp").forward(request, response);
	}	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    
		String action = request.getParameter("action");
		if ("delete".equals(action)) {
		    int fieldId = Integer.parseInt(request.getParameter("id"));
		    if(fdao.findById(fieldId)!=null) {
		        Filiere filieredelete =  fdao.findById(fieldId);
		        
		        boolean updated = fdao.update(filieredelete);
		        if (updated) {
		            fdao.delete(filieredelete);
		            boolean deleted = true;
		            if (deleted) {
		                response.sendRedirect(request.getContextPath() + "/FiliereController");
		            } else {
		                response.sendRedirect(request.getContextPath() + "/FiliereController?deleteFailed=true");
		            }
		        }
		    }
		}

 

		else if("edit".equals(action)) {
	        int id = Integer.parseInt(request.getParameter("id"));
	        System.out.println("idddddd: "+id);
	        String name = request.getParameter("Name");
	        String code = request.getParameter("Code");
	        Filiere fieldToEdit = fdao.findById(id);
	        if (fieldToEdit != null) {
	            fieldToEdit.setName(name);
	            fieldToEdit.setCode(code);
	            fdao.update(fieldToEdit);
	        }
	        response.sendRedirect(request.getContextPath() + "/FiliereController");
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
	    String code = request.getParameter("Code");
	    Filiere newField = new Filiere(name, code);
		    if (fdao.create(newField)) {
		        List<Filiere> Filieres = fdao.findAll();
	            System.out.println(fdao.findAll());
		        request.setAttribute("Filieres", Filieres);
		        request.getRequestDispatcher("/ListFilieres.jsp").forward(request, response);
		    } else {
		    	System.out.println("Failure: Field not created.");
		    }
	    }
	}
	
	
	private void showlist(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException{
	
		int id = Integer.parseInt(request.getParameter("id"));
	
		List<Etudiant> liste= sdao.findByFiliere(fdao.findById(id).getName());
		RequestDispatcher dispatcher = request.getRequestDispatcher("studentsfield.jsp");
		request.setAttribute("students", liste);
		request.setAttribute("filiere", fdao.findById(id).getName());
		dispatcher.forward(request, response);		
		}
	 
	private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Filiere existingField = fdao.findById(id);
		RequestDispatcher dispatcher = request.getRequestDispatcher("editField.jsp");
		request.setAttribute("field", existingField);
		dispatcher.forward(request, response);
	
	}
}
