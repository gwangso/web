package conroller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.*;


@WebServlet(value={"/purchase/insert", "/order/insert", "/purchase/list", "/purchase/list.json"})
public class PurchaseController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    PurchaseDAO pdao = new PurchaseDAO();   
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		switch (request.getServletPath()) {
		case "/purchase/list.json":
			String key = request.getParameter("key");
			String query = request.getParameter("query");
			int page = Integer.parseInt(request.getParameter("page"));
			Gson gson = new Gson();
			out.println(gson.toJson(pdao.list(key,query,page)));
			break;
		case "/purchase/list":
			request.setAttribute("pageName", "/purchase/list.jsp");
			dis.forward(request, response);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		PrintWriter out = response.getWriter();
		
		switch(request.getServletPath()) {
		case "/purchase/insert":
			PurchaseVO vo = new PurchaseVO();
			UUID uuid = UUID.randomUUID();
			String pid = uuid.toString().substring(0,13);
			vo.setPid(pid);
			vo.setUid(request.getParameter("uid"));
			vo.setPhone(request.getParameter("rphone"));
			vo.setAddress1(request.getParameter("raddress1"));
			vo.setAddress2(request.getParameter("raddress2"));
			vo.setPurSum(Integer.parseInt(request.getParameter("sum")));
			System.out.println(vo.toString());
			pdao.insert(vo);
			out.print(pid);
			break;
			
		case "/order/insert":
			OrderVO ovo = new OrderVO();
			ovo.setPid(request.getParameter("pid"));
			ovo.setGid(request.getParameter("gid"));
			ovo.setPrice(Integer.parseInt(request.getParameter("price")));
			ovo.setQnt(Integer.parseInt(request.getParameter("qnt")));
			System.out.println(ovo.toString());
			pdao.insert(ovo);
			break;
		}
	}
}