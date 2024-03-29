package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.*;

@WebServlet(value={"/book/search","/book/insert", "/book/list", "/book/list.json", "/book/total"})
public class BookController extends HttpServlet {
	BookDAO dao = new BookDAO();
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8"); //한글 안깨지게 하는법
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");

		PrintWriter out = response.getWriter(); //브라우저에 출력
		Gson gson=new Gson();//gson가져오기
		switch(request.getServletPath()) {
		case "/book/search":
			request.setAttribute("pageName", "/book/search.jsp");
			dis.forward(request, response);
			break;
		case "/book/list":
			request.setAttribute("pageName", "/book/list.jsp");
			dis.forward(request, response);
			break;
		case "/book/list.json":
			//핸들바를 쓰기위해선 json으로 바꿔줘야한다.
			//json을 쓰기위해선 ajax으로 받아줘한다.
			//ajax으로 받기 위해선 브라우저에 띄워야한다.
			//ajax으로 받기 위해서는 주소를 하나 만들어서 브라우저에 출력해야한다
			int page=Integer.parseInt(request.getParameter("page"));
			//array를 json으로 바꿔주고 브라우저에 출력하는것
			out.println(gson.toJson(dao.list(page)));
			break;
		case "/book/total":
			out.println(gson.toJson(dao.total()));
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		switch (request.getServletPath()) {
		case "/book/insert":
			BookVO vo = new BookVO();
			vo.setIsbn(request.getParameter("isbn"));
			vo.setTitle(request.getParameter("title"));
			vo.setAuthors(request.getParameter("authors"));
			vo.setPublisher(request.getParameter("publisher"));
			vo.setThumbnail(request.getParameter("thumbnail"));
			vo.setPrice(Integer.parseInt(request.getParameter("price")));
			vo.setPdate(request.getParameter("datetime"));
			vo.setUrl(request.getParameter("url"));
			vo.setContents(request.getParameter("contents"));
			dao.insert(vo);
			break;
		}	
	}
}
