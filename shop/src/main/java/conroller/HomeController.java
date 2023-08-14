package conroller;

import java.io.IOException;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.*;

@WebServlet("/")
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    UserDAO dao=new UserDAO();   
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Cookie[] cookies = request.getCookies();
		//쿠키에 uid값이 존재하면 사용자정보를 세션에 저장
		if(cookies != null) {
			for(Cookie cookie:cookies) {
				if(cookie.getName().equals("uid")) {
					String uid = cookie.getValue();
					UserVO user=dao.read(uid);
					HttpSession session = request.getSession();
					session.setAttribute("user", user);
				}
			}
		}
		
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		request.setAttribute("pageName", "/about.jsp");
		dis.forward(request, response);
	}
}
