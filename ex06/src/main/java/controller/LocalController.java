package controller;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet(value ={"/local/list","/local/list.json","/local/total"})
public class LocalController extends HttpServlet {
	
	LocalDAO ldao= new LocalDAO();
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		switch(request.getServletPath()) {
		case "/local/list":
			request.setAttribute("pageName", "/local/list.jsp");
			dis.forward(request, response);
			break;
		case "/local/list.json":
			int page = Integer.parseInt(request.getParameter("page"));
			String query = request.getParameter("query");
			
			ArrayList<LocalVO> array = ldao.list(page, query);
			
			JSONArray jArray = new JSONArray();
			for(LocalVO vo : array) {
				JSONObject JObject = new JSONObject();
				JObject.put("id", vo.getId());
				JObject.put("lid", vo.getLid());
				JObject.put("lname", vo.getLname());
				JObject.put("laddress", vo.getLaddress());
				JObject.put("lphone", vo.getLphone());
				jArray.add(JObject);
			}
			out.println(jArray);
			break;
		case "/local/total":
			String query1 = request.getParameter("query");
			out.print(ldao.total(query1));
			
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
