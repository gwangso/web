package conroller;

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

@WebServlet(value={"/review/insert", "/review/list.json", "/review/delete", "/review/update"})
public class ReviewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    ReviewDAO rdao = new ReviewDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		switch(request.getServletPath()) {
		case "/review/list.json":
			Gson gson = new Gson();
			out.println(gson.toJson(rdao.list(request.getParameter("gid"))));
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		switch (request.getServletPath()) {
		case "/review/insert":
			ReviewVO vo = new ReviewVO();
			vo.setGid(request.getParameter("gid"));
			vo.setUid(request.getParameter("uid"));
			vo.setContent(request.getParameter("content"));
			rdao.insert(vo);
			break;
		case "/review/delete":
			int rid = Integer.parseInt(request.getParameter("rid"));
			rdao.delete(rid);
			break;
		case "/review/update":
			rid = Integer.parseInt(request.getParameter("rid"));
			String content = request.getParameter("content");
			rdao.update(rid, content);
			break;
		}
	}

}
