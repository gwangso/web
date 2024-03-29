package controller;

import java.io.IOException; 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.*;

@WebServlet(value = {"/pro/list","/pro/insert","/pro/read", "/pro/delete", "/pro/update"})
public class ProductController extends HttpServlet {
	ProductDAO pdao = new ProductDAO();
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		switch (request.getServletPath()) {
		case "/pro/list":
			int page= request.getParameter("page")==null ? 1: Integer.parseInt(request.getParameter("page"));
			int lastPage = (int)Math.ceil(pdao.getProEA()/(double)5);
			request.setAttribute("page", page);
			request.setAttribute("lastPage",lastPage);
			request.setAttribute("array", pdao.list(page));
			request.setAttribute("pageName", "/pro/list.jsp");
			dis.forward(request, response);
			break;
		case "/pro/insert":
			request.setAttribute("pageName", "/pro/insert.jsp");
			dis.forward(request, response);
			break;
		case "/pro/read":
			String pcode = request.getParameter("pcode");
			request.setAttribute("vo", pdao.read(pcode));
			request.setAttribute("pageName", "/pro/read.jsp");
			dis.forward(request, response); //page를 출력
			break;
		case "/pro/delete":
			pcode = request.getParameter("pcode");
			pdao.delete(pcode);
			response.sendRedirect("/pro/list"); //pro/list로 이동
			break;
		case "/pro/update":
			pcode = request.getParameter("pcode");
			request.setAttribute("vo", pdao.read(pcode));
			request.setAttribute("pageName", "/pro/update.jsp");
			dis.forward(request, response);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		switch(request.getServletPath()) {
		case "/pro/insert":
			String pname= request.getParameter("pname"); // submit하면 값이 request에 저장
			String pprice= request.getParameter("pprice");
			//getParameter로는 정수를 못받는다. 무조건 문자열
			ProductVO vo = new ProductVO();
			vo.setPname(pname);
			vo.setPprice(Integer.parseInt(pprice));
			pdao.insert(vo);
			response.sendRedirect("/pro/list");
			break;
		case "/pro/update":
			String pcode=request.getParameter("pcode");
			pname= request.getParameter("pname"); // submit하면 값이 request에 저장
			pprice= request.getParameter("pprice");
			vo = new ProductVO();
			vo.setPcode(Integer.parseInt(pcode));
			vo.setPname(pname);
			vo.setPprice(Integer.parseInt(pprice));
//			System.out.println(vo.toString());
			pdao.update(vo);
			response.sendRedirect("/pro/read?pcode="+pcode);
		}
	}
}