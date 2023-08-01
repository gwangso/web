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

@WebServlet(value = {"/pro/list", "/pro/list.json", "/pro/total", "/pro/insert", "/pro/delete", "/pro/update"})
public class ProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ProductDAO pdao = new ProductDAO();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	DecimalFormat df = new DecimalFormat("#,###원");
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		
		PrintWriter out = response.getWriter();
		switch (request.getServletPath()) {
		case "/pro/list":
			request.setAttribute("pageName", "/pro/list.jsp");
			dis.forward(request, response);
			break;
		case "/pro/list.json": // /pro/list.json?page=1&query=냉장고
			int page = Integer.parseInt(request.getParameter("page"));
			String query = request.getParameter("query");
			
			ArrayList<ProductVO> array = pdao.list(page, query);
			JSONArray jArray = new JSONArray();
			for(ProductVO vo : array) {
				JSONObject obj = new JSONObject(); //JSON의 VO같은역할
				obj.put("pcode", vo.getPcode());
				obj.put("pname", vo.getPname());
				obj.put("pprice", vo.getPprice());
				obj.put("fprice", df.format(vo.getPprice()));
//				obj.put("pdate", vo.getPdate()) // Date타입의 포멧은 JSON에 넣으면 오류발생
				obj.put("fdate", sdf.format(vo.getPdate()));
				jArray.add(obj);
			}
			out.println(jArray);
			break;
		case "/pro/total":
			String query1 = request.getParameter("query");
			out.print(pdao.getTotal(query1));
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		switch (request.getServletPath()){
		case "/pro/insert":
			ProductVO vo = new ProductVO();
			vo.setPname(request.getParameter("pname"));
			vo.setPprice(Integer.parseInt(request.getParameter("pprice")));
//			System.out.println(vo.toString());
			pdao.insert(vo);
			break;
		case "/pro/delete":
			int pcode = Integer.parseInt(request.getParameter("code"));
//			System.out.println("삭제할 코드 : " + pcode);
			pdao.delete(pcode);
			break;
		case "/pro/update":
			vo = new ProductVO();
			vo.setPcode(Integer.parseInt(request.getParameter("pcode")));
			vo.setPname(request.getParameter("pname"));
			vo.setPprice(Integer.parseInt(request.getParameter("pprice")));
//			System.out.println(vo.toString());
			pdao.update(vo);
			break;
		}
	}
}
