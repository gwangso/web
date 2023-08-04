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

@WebServlet(value={"/stu/list", "/stu/list.json", "/stu/total", "/stu/insert", "/stu/update", "/stu/enroll", "/stu/enroll.json", "/enroll/insert", "/enroll/delete"})
public class StudentsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	StudentsDAO dao = new StudentsDAO();
	ProfessorsDAO pdao = new ProfessorsDAO();   
	CoursesDAO cdao = new CoursesDAO();   
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df = new DecimalFormat("#학년");
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		PrintWriter out = response.getWriter();
		switch(request.getServletPath()) {
		case "/stu/list":
			request.setAttribute("parray", pdao.allList());
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
				obj.put("birthday", vo.getBirthday());
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
		case "/stu/update":
			request.setAttribute("svo", dao.read(request.getParameter("scode")));
			request.setAttribute("parray", pdao.allList());
			request.setAttribute("pageName", "/stu/update.jsp");
			dis.forward(request, response);
			break;
		case "/stu/enroll":
			String scode = request.getParameter("scode");
			request.setAttribute("svo", dao.read(scode));
			request.setAttribute("carray", cdao.all());
			request.setAttribute("pageName", "/stu/enroll.jsp");
			dis.forward(request, response);
			break;
		case "/stu/enroll.json":
			ArrayList<EnrollVO> earray = dao.list(request.getParameter("scode"));
			
			jArray = new JSONArray();
			for (EnrollVO vo : earray) {
				JSONObject job = new JSONObject();
				job.put("lcode", vo.getLcode());
				job.put("scode", vo.getScode());
				job.put("edate", vo.getEdate());
				job.put("grade", vo.getGrade());
				job.put("lname", vo.getLname());
				job.put("pname", vo.getPname());
				job.put("hours", vo.getHours());
				job.put("room", vo.getRoom());
				job.put("capacity", vo.getCapacity());
				job.put("persons", vo.getPersons());
				jArray.add(job);
			}
			out.println(jArray);
			break;
		case "/enroll/insert":
			String lcode = request.getParameter("lcode");
			scode= request.getParameter("scode");
			out.print(dao.insert(scode,lcode));
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		switch(request.getServletPath()) {
		case "/stu/insert":
			StudentsVO vo = new StudentsVO();
			vo.setSname(request.getParameter("sname"));
			vo.setDept(request.getParameter("dept"));
			vo.setBirthday(request.getParameter("birthday"));
			vo.setYear(Integer.parseInt(request.getParameter("year")));
			vo.setAdvisor(request.getParameter("advisor"));
			dao.insert(vo);
			response.sendRedirect("/stu/list");
			break;
		case "/stu/update":
			StudentsVO uvo = new StudentsVO();
			uvo.setScode(request.getParameter("scode"));
			uvo.setSname(request.getParameter("sname"));
			uvo.setDept(request.getParameter("dept"));
			uvo.setBirthday(request.getParameter("birthday"));
			uvo.setYear(Integer.parseInt(request.getParameter("year")));
			uvo.setAdvisor(request.getParameter("advisor"));
			dao.update(uvo);
			response.sendRedirect("/stu/list");
			break;
		case "/enroll/delete":
			String scode = request.getParameter("scode");
			String lcode = request.getParameter("lcode");
			dao.delete(scode, lcode);
			break;
		}
	}
}