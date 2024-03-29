package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.*;


@WebServlet(value={"/pro/list", "/pro/insert"})
public class ProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ProductDAO pdao = new ProductDAO();
	
       
    public ProductController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		switch (request.getServletPath()) { //주소 정보 = request.
		case "/pro/list":
			request.setAttribute("array", pdao.list()); // array에 pdao.list()를 넣음
			request.setAttribute("pageName", "/pro/list.jsp"); //pageName에 /pro/list.jsp를 집어넣음
			break;
		case "/pro/insert":
			request.setAttribute("pageName", "/pro/insert.jsp");
			break;
		}
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		dis.forward(request, response);
	}

	//form에서 메소드를 Post라 주었을 때만 작동
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
}
