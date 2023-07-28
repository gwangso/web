package model;

import java.util.List;

public class DAOTest {

	public static void main(String[] args) {
		ProductDAO dao = new ProductDAO();
		
		List<ProductVO> array = dao.list(1);
		for(ProductVO vo : array) {
			System.out.println(vo.toString());
		}
		
		System.out.println(dao.total());
	}
}
