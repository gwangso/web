package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(value= {"/iphones/prosandcons","/iphones/list"})
public class IphonesController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public IphonesController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis = null;
		switch (request.getServletPath()) {
		case "/iphones/prosandcons":
			dis = request.getRequestDispatcher("prosandcons.jsp");
			break;
		case "/iphones/list":
			dis = request.getRequestDispatcher("list.jsp");
		}
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
