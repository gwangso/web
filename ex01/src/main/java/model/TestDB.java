package model;

public class TestDB {

	public static void main(String[] args) {
		ProductDAO pdao = new ProductDAO();
		for(ProductVO vo : pdao.list()) {
			System.out.println(vo.toString());
		}
	}

}
