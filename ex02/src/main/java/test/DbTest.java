package test;

import model.*;

public class DbTest {

	public static void main(String[] args) {
		ProductDAO dao = new ProductDAO();
		System.out.println(dao.getProEA() +"개");
		System.out.println(Math.ceil(dao.getProEA()/(double)5));
	}

}
