package conroller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.*;

@WebServlet(value= {"/favorite/read", "/favorite/insert", "/favorite/delete"})
public class FavoriteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    FavoriteDAO dao = new FavoriteDAO();   
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		switch(request.getServletPath()) {
		case "/favorite/read":
			String uid = request.getParameter("uid");
			String gid = request.getParameter("gid");
			out.println(dao.read(gid, uid));
			break;
		case "/favorite/insert":
			uid = request.getParameter("uid");
			gid = request.getParameter("gid");
			dao.insert(gid, uid);
			break;
		case "/favorite/delete":
			uid = request.getParameter("uid");
			gid = request.getParameter("gid");
			dao.delete(gid, uid);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
