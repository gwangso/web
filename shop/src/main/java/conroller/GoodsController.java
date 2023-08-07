package conroller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.GoodsDAO;
import model.GoodsVO;
import model.NaverAPI;

@WebServlet(value={"/goods/search", "/goods/search.json", "/goods/append", "/goods/list.json", "/goods/total", "/goods/list", "/goods/delete"})
public class GoodsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	GoodsDAO gdao=new GoodsDAO();
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		PrintWriter out = response.getWriter();
		switch (request.getServletPath()) {
		case "/goods/search":
			request.setAttribute("pageName", "/goods/search.jsp");
			dis.forward(request, response);
			break;
		case "/goods/search.json":
			int page = Integer.parseInt(request.getParameter("page"));
			String query= request.getParameter("query");
			String result = NaverAPI.search(page, query);
			out.println(result);
			break;
		case "/goods/list.json": // /goods/list.json?page=1&query=
			page = Integer.parseInt(request.getParameter("page"));
			query = request.getParameter("query");
			Gson gson = new Gson();
			out.println(gson.toJson(gdao.list(page, query)));
			break;
		case "/goods/total":
			query=request.getParameter("query");
			out.print(gdao.total(query));
			break;
		case "/goods/list":
			request.setAttribute("pageName", "/goods/list.jsp");
			dis.forward(request, response);			
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String path="/upload/goods/"; //path를 설정할때 upload/goods/ 로 마지막에 슬레시를 꼭 넣어줘야 그곳에 넣는다.
//		File mdPath = new File("c:/"+path); //mdPath에 c:/upload/goods를 집어넣어 본다.
//		//File
//		if(!mdPath.exists()) mdPath.mkdir(); //mdPath가 존재하지 않는다면(c:/에 /upload/goods가 !없다면)새로 생성
//		//mkdir = make dir
		switch (request.getServletPath()) {
		case "/goods/append":
			InputStream is = null; //읽어들이는 역할
			FileOutputStream fos=null; //출력하는 역할
			try {
				URL url = new URL(request.getParameter("image"));
				is = url.openStream();
				
				UUID uuid = UUID.randomUUID(); //랜덤한 32bit짜리 
				String gid=uuid.toString().substring(0,8); 
				//8자리 gid를 주는 과정
				
				String fileName = gid + ".jpg"; //받아올이미지이름을 [git].jpg로 가져옴
				fos = new FileOutputStream("c:/" + path + fileName);
				
				int data = 0;
				
				while ((data=is.read()) != -1) {
					fos.write(data);
				}
				
				GoodsVO vo = new GoodsVO();
				vo.setGid(gid);
				vo.setTitle(request.getParameter("title"));
				vo.setMaker(request.getParameter("maker"));
				vo.setPrice(Integer.parseInt(request.getParameter("lprice")));
				vo.setImage(path + fileName);
				System.out.println(vo.toString());
				gdao.insert(vo);
				break;
			} catch (Exception e) {
				System.out.println("상품이미지 저장 : " + e.toString());
			}
			break;
		case "/goods/delete":
			try {
				String gid = request.getParameter("gid");
				String image = request.getParameter("image");
				File file = new File("c:/"+image);
				file.delete(); // 이미지파일 삭제 메서드
				gdao.delete(gid); //테이블 삭제 DAO
			} catch (Exception e) {
				System.out.println("상품삭제 : " + e.toString());
			}
			break;
		}
	}
}
