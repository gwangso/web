package model;

import java.util.*;
import java.sql.*;

public class ProductDAO {
	//상품수 출력
	public int total() {
		int total=0;
		try {
			String sql = "SELECT count(*) cnt FROM TBL_PRODUCTS";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				total=rs.getInt("cnt");
			}
		} catch (Exception e) {
			System.out.println("상품수 출력 오류 : " + e.toString());
		}
		return total;
	}
	
	//상품목록
	public ArrayList<ProductVO> list(int page){
		ArrayList<ProductVO> list = new ArrayList<ProductVO>();
		try {
			String sql = "SELECT * FROM TBL_PRODUCTS ORDER BY PCODE DESC limit ?, 5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setInt(1, ((page-1)*5));
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				ProductVO vo = new ProductVO();
				vo.setPcode(rs.getInt("pcode"));
				vo.setPname(rs.getString("pname"));
				vo.setPprice(rs.getInt("pprice"));
				vo.setPdate(rs.getTimestamp("pdate"));
				list.add(vo);
			}
		} catch (Exception e) {
			System.out.println("상품목록 오류 : " + e.toString());
		}
		return list;
	}
	
	//상품등록
	public void insert(ProductVO vo) {
		try {
			String sql = "insert into tbl_products(pname, pprice) values(?,?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getPname());
			ps.setInt(2, vo.getPprice());
			ps.execute();
		} catch (Exception e) {
			System.out.println("상품목록 오류 : " + e.toString());			// TODO: handle exception
		}
	}
}
