package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(value= {"/galaxies/prosandcons","/galaxies/list"})
public class GalaxiesController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public GalaxiesController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis = null;
		switch (request.getServletPath()) {
		case "/galaxies/prosandcons":
			dis = request.getRequestDispatcher("prosandcons.jsp");
			break;
		case "/galaxies/list":
			dis = request.getRequestDispatcher("list.jsp");
			break;
		}
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
