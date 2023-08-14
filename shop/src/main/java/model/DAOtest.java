package model;

import java.util.UUID;

public class DAOtest {

	public static void main(String[] args) {
		GoodsDAO dao = new GoodsDAO();
		
		UUID uid = UUID.randomUUID();
		System.out.println(uid);
		uid = UUID.randomUUID();
		System.out.println(uid);

	}

}
