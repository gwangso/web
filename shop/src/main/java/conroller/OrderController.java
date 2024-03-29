package conroller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import model.*;

@WebServlet(value={"/cart/list", "/cart/list.json", "/cart/insert", "/cart/delete", "/cart/update"})
public class OrderController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	GoodsDAO gdao = new GoodsDAO();
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		HttpSession session = request.getSession();
		ArrayList<CartVO> arrCart = session.getAttribute("arrCart")==null?
				new ArrayList<CartVO>() : (ArrayList<CartVO>)session.getAttribute("arrCart");
		
		switch(request.getServletPath()) {
		case "/cart/list":
			request.setAttribute("pageName", "/order/cart.jsp");
			dis.forward(request, response);
			break;
		case "/cart/insert":
			String gid = request.getParameter("gid");
			
			boolean find=false;
			for(CartVO vo : arrCart) {
				if(vo.getGid().equals(gid)) {
					vo.setQnt(vo.getQnt()+1);
					find=true;
				}
			}
			
			GoodsVO gvo = gdao.read(gid);
			CartVO cvo = new CartVO();
			if(!find) {
				cvo.setGid(gvo.getGid());
				cvo.setTitle(gvo.getTitle());
				cvo.setPrice(gvo.getPrice());
				cvo.setMaker(gvo.getMaker());
				cvo.setImage(gvo.getImage());
				cvo.setQnt(1);
				arrCart.add(cvo);
			}
			session.setAttribute("arrCart", arrCart);
			break;
		
		case "/cart/list.json":
			Gson gson = new Gson();
			out.print(gson.toJson(arrCart));
			break;
		
		case "/cart/delete":
			gid = request.getParameter("gid");
			
			for (CartVO vo : arrCart) {
				if(gid.equals(vo.getGid())) {
					arrCart.remove(vo);//카트에서 상품을 찾으면 삭제
					break;
				}
			}
			session.setAttribute("arrCart", arrCart); //삭제 이후 변한 arrCart를 세션에 다시저장
			break;
		
		case "/cart/update":
			gid=request.getParameter("gid");
			int qnt = Integer.parseInt(request.getParameter("qnt"));
			for(CartVO vo : arrCart) {
				if(gid.equals(vo.getGid())) {
					vo.setQnt(qnt);
					break;
				}
			}
			session.setAttribute("arrCart", arrCart);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
}
