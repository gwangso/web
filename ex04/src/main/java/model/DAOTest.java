package model;

public class DAOTest {

	public static void main(String[] args) {
		BookDAO dao=new BookDAO();
		for (BookVO vo : dao.list(5)) {
			System.out.println(vo.toString());
		}
	}

}
