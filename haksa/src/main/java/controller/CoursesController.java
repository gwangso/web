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

@WebServlet(value={"/cou/list", "/cou/list.json", "/cou/total", "/cou/insert", "/cou/update", "/cou/all.json", "/cou/grade", "/cou/grade.json", "/grade/update"})
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
			request.setAttribute("lvo", dao.read(request.getParameter("lcode")));
			request.setAttribute("parray", pdao.allList());
			request.setAttribute("pageName", "/cou/update.jsp");
			dis.forward(request, response);
			break;
		case "/cou/all.json":
			ArrayList<CoursesVO> carray = dao.all();
			
			JSONArray jArray = new JSONArray();
			for(CoursesVO vo : carray) {
				JSONObject obj = new JSONObject();
				obj.put("lcode", vo.getLcode());
				obj.put("lname", vo.getLname());
				obj.put("hours", vo.getHours());
				obj.put("room", vo.getRoom());
				obj.put("pname", vo.getPname());
				obj.put("instructor", vo.getInstructor());
				obj.put("capacity", vo.getCapacity());
				obj.put("persons", vo.getPersons());
				jArray.add(obj);
			}
			out.println(jArray);
			break;
		case "/cou/grade":
			String lcode=request.getParameter("lcode");
			request.setAttribute("cvo", dao.read(lcode));
			request.setAttribute("pageName", "/cou/grade.jsp");
			dis.forward(request, response);
			break;
		case "/cou/grade.json":
			lcode = request.getParameter("lcode");
			ArrayList<GradeVO> array=dao.list(lcode);
			
			jArray = new JSONArray();
			for (GradeVO vo : array) {
				JSONObject obj = new JSONObject();
				obj.put("scode", vo.getScode());
				obj.put("sname", vo.getSname());
				obj.put("edate", vo.getEdate().substring(0,10));
				obj.put("grade", vo.getGrade());
				obj.put("dept", vo.getDept());
				jArray.add(obj);
			}
			out.println(jArray);
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
		case "/grade/update":
			GradeVO gvo = new GradeVO();
			gvo.setLcode(request.getParameter("lcode"));
			gvo.setScode(request.getParameter("scode"));
			gvo.setGrade(Integer.parseInt(request.getParameter("grade")));
			dao.update(gvo);
			response.sendRedirect("/cou/grade");
		}
	}
}
