package controller;

import java.io.*;
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

@WebServlet(value = {"/pro/list", "/pro/list.json", "/pro/insert", "/pro/delete", "/pro/update"})
public class ProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ProductDAO pdao = new ProductDAO();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	DecimalFormat df = new DecimalFormat("#,###원");
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		PrintWriter out = response.getWriter(); //json 데이터를 출력하기위해 브라우저를 생성
		switch (request.getServletPath()) {
		case "/pro/list":
			request.setAttribute("pageName", "/pro/list.jsp");
			dis.forward(request, response);
			break;
		case "/pro/list.json":
			int page = request.getParameter("page")==null ? 1:
				Integer.parseInt(request.getParameter("page"));
			
			String query = request.getParameter("query")==null ? "":
				request.getParameter("query");
			
			ArrayList<ProductVO> array = pdao.list(page, query);
			
			//ArrayList를 JSONArray로 변환
			JSONArray jArray = new JSONArray();
			for(ProductVO vo : array) {
				JSONObject obj = new JSONObject();
				obj.put("pcode", vo.getPcode());
				obj.put("pname", vo.getPname());
				obj.put("pprice", vo.getPprice());
				obj.put("fpprice", df.format((vo.getPprice())));
				obj.put("fpdate", sdf.format(vo.getPdate()));
				jArray.add(obj);
			}
			JSONObject jObject = new JSONObject();
			jObject.put("total", pdao.total(query));
			jObject.put("items", jArray);
			out.println(jObject);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		switch (request.getServletPath()) {
		case "/pro/insert":
			ProductVO vo = new ProductVO();
			vo.setPname(request.getParameter("pname"));
			vo.setPprice(Integer.parseInt(request.getParameter("pprice")));
			pdao.insert(vo);
			break;
		case "/pro/delete":
			int code = Integer.parseInt(request.getParameter("pcode"));
			pdao.delete(code);
			break;
		case "/pro/update":
			ProductVO uvo = new ProductVO();
			uvo.setPname(request.getParameter("pname"));
			uvo.setPprice(Integer.parseInt(request.getParameter("pprice")));
			uvo.setPcode(Integer.parseInt(request.getParameter("pcode")));
			pdao.update(uvo);
			break;
		}
	}
}