package model;

public class DAOTest {

	public static void main(String[] args) {
		ProductDAO pdao = new ProductDAO();
		LocalDAO ldao = new LocalDAO();
//		for(ProductVO vo : dao.list(1, "냉장고")) {
//			System.out.println(vo.toString());
//		}
		
		System.out.println(ldao.total("인천일보"));
	}

}
