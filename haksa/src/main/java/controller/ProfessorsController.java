package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.*;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import model.*;

@WebServlet(value={"/pro/list", "/pro/list.json", "/pro/total", "/pro/insert", "/pro/update"})
public class ProfessorsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ProfessorsDAO dao = new ProfessorsDAO();
	SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
	DecimalFormat df = new DecimalFormat("#,###원");
			
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		PrintWriter out = response.getWriter();
		switch(request.getServletPath()) {
		case "/pro/list":
			request.setAttribute("pageName", "/pro/list.jsp");
			dis.forward(request, response);
			break;
		case "/pro/list.json":
			int page = request.getParameter("page")==null ?
					1 : Integer.parseInt(request.getParameter("page"));
			String query = request.getParameter("query")==null ?
					"": request.getParameter("query");
			String key = request.getParameter("key");
			
			ArrayList<ProfessorsVO> array = dao.list(page, query, key);
			
			JSONArray jArray = new JSONArray();
			
			for (ProfessorsVO vo : array) {
				JSONObject obj = new JSONObject();
				obj.put("pcode", vo.getPcode());
				obj.put("pname", vo.getPname());
				obj.put("dept", vo.getDept());
				obj.put("hiredate", vo.getHiredate());
				obj.put("title", vo.getTitle());
				obj.put("salary", df.format(vo.getSalary()));
				jArray.add(obj);
			}
			out.println(jArray);
			break;
		case "/pro/total": // /pro/total?query=이&key=pname
			query = request.getParameter("query")==null ?
					"": request.getParameter("query");
			key = request.getParameter("key");
			out.print(dao.getTotal(query,key));
			break;
		case "/pro/update":
			String pcode = request.getParameter("pcode");
			request.setAttribute("up", dao.read(pcode));
			request.setAttribute("pageName", "/pro/update.jsp");
			dis.forward(request, response);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		switch (request.getServletPath()) {
		case "/pro/insert":
			ProfessorsVO vo = new ProfessorsVO();
			
			vo.setPname(request.getParameter("pname"));
			vo.setDept(request.getParameter("dept"));
			vo.setTitle(request.getParameter("title"));
			vo.setSalary(Integer.parseInt(request.getParameter("salary")));
			vo.setHiredate(request.getParameter("hiredate"));
			
			System.out.println(vo.toString());
			dao.insert(vo);
			break;
		case "/pro/update":
			ProfessorsVO uvo = new ProfessorsVO();
			
			uvo.setPcode(request.getParameter("pcode"));
			uvo.setPname(request.getParameter("pname"));
			uvo.setDept(request.getParameter("dept"));
			uvo.setTitle(request.getParameter("title"));
			uvo.setSalary(Integer.parseInt(request.getParameter("salary")));
			uvo.setHiredate(request.getParameter("hiredate"));
			dao.update(uvo);
			response.sendRedirect("/pro/list");
			break;
			

		}
	}
}
