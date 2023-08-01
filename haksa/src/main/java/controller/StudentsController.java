package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
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

@WebServlet(value={"/stu/list", "/stu/list.json", "/stu/total"})
public class StudentsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	StudentsDAO dao = new StudentsDAO();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df = new DecimalFormat("#학년");
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		PrintWriter out = response.getWriter();
		switch(request.getServletPath()) {
		case "/stu/list":
			request.setAttribute("pageName", "/stu/list.jsp");
			dis.forward(request, response);
			break;
		case "/stu/list.json":
			int page = request.getParameter("page")==null ?
					1 : Integer.parseInt(request.getParameter("page")) ;
			String query = request.getParameter("query")==null ?
					"" : request.getParameter("query");
			String key = request.getParameter("key");
			ArrayList<StudentsVO> array = dao.list(page, query, key);
			
			JSONArray jArray = new JSONArray();
			for (StudentsVO vo : array) {
				JSONObject obj = new JSONObject();
				obj.put("scode", vo.getScode());
				obj.put("sname", vo.getSname());
				obj.put("dept", vo.getDept());
				obj.put("year", df.format(vo.getYear()));
				obj.put("birthday", sdf.format(vo.getBirthday()));
				obj.put("advisor", vo.getAdvisor());
				obj.put("pname", vo.getPname());
				jArray.add(obj);
			}
			out.println(jArray);
			break;
		case "/stu/total":
			query = request.getParameter("query")==null ?
					"" : request.getParameter("query");
			key = request.getParameter("key");
			out.println(dao.getTotal(query, key));
			break;
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
