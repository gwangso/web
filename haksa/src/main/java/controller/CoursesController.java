package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.google.gson.Gson;

import java.util.*;
import model.*;

@WebServlet(value={"/cou/list", "/cou/list.json", "/cou/total", "/cou/insert", "/cou/update"})
public class CoursesController extends HttpServlet {
	CoursesDAO dao = new CoursesDAO();
	ProfessorsDAO pdao = new ProfessorsDAO();
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		
		switch(request.getServletPath()) {
		case "/cou/list":
			request.setAttribute("parray", pdao.allList());
			request.setAttribute("pageName", "/cou/list.jsp");
			dis.forward(request, response);
			break;
		case "/cou/list.json": // /cou/list.json?key=pname&query=이&page=1
			int page = request.getParameter("page")==null ?
					1:Integer.parseInt(request.getParameter("page"));
			String query = request.getParameter("query")==null?
					"":request.getParameter("query");
			String key = request.getParameter("key")==null?
					"lname":request.getParameter("key");
			
			Gson gson =new Gson();
			
			out.println(gson.toJson(dao.list(page, query, key)));
			
			break;
		case "/cou/total": // /cou/total?key=pname&query=이
			query = request.getParameter("query")==null?
					"":request.getParameter("query");
			key = request.getParameter("key")==null?
					"lname":request.getParameter("key");
			out.println(dao.getTotal(query, key));
			break;
		case "/cou/update":
			System.out.println(dao.read(request.getParameter("lcode")).toString());
			request.setAttribute("lvo", dao.read(request.getParameter("lcode")));
			request.setAttribute("parray", pdao.allList());
			request.setAttribute("pageName", "/cou/update.jsp");
			dis.forward(request, response);
			break;
		}
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		switch (request.getServletPath()) {
		case "/cou/insert":
			CoursesVO cvo = new CoursesVO();
			cvo.setLname(request.getParameter("lname"));
			cvo.setInstructor(request.getParameter("instructor"));
			cvo.setRoom(request.getParameter("room"));
			cvo.setHours(Integer.parseInt(request.getParameter("hours")));
			cvo.setCapacity(Integer.parseInt(request.getParameter("capacity")));
			cvo.setPersons(Integer.parseInt(request.getParameter("persons")));
			dao.insert(cvo);
			response.sendRedirect("/cou/list");
			break;
		case "/cou/update":
			cvo = new CoursesVO();
			cvo.setLcode(request.getParameter("lcode"));
			cvo.setLname(request.getParameter("lname"));
			cvo.setInstructor(request.getParameter("instructor"));
			cvo.setRoom(request.getParameter("room"));
			cvo.setHours(Integer.parseInt(request.getParameter("hours")));
			cvo.setCapacity(Integer.parseInt(request.getParameter("capacity")));
			cvo.setPersons(Integer.parseInt(request.getParameter("persons")));
			System.out.println(cvo.toString());
			dao.update(cvo);
			response.sendRedirect("/cou/list");
			break;
		}
	}
}
