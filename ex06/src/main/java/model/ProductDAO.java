package model;

import java.util.*;
import java.sql.*;

public class ProductDAO {
	
	public ArrayList<ProductVO> list(int page, String query){
		ArrayList<ProductVO> list = new ArrayList<ProductVO>();
		try {
			String sql = "SELECT * FROM TBL_PRODUCTS WHERE PNAME LIKE ? ORDER BY PCODE DESC limit ?, 5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ps.setInt(2, ((page-1)*5));
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

	//검색수
	public int getTotal(String query) {
		int total = 0;
		try {
			String sql = "SELECT COUNT(*) cnt FROM TBL_PRODUCTS WHERE PNAME LIKE ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				total = rs.getInt("cnt");
			}
		} catch (Exception e) {
			System.out.println("상품목록 오류 : " + e.toString());
		}
		return total;
	}
	
	//상품등록
	public void insert(ProductVO vo) {
		try {
			String sql = "INSERT INTO TBL_PRODUCTS(PNAME,PPRICE) VALUES(?,?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getPname());
			ps.setInt(2, vo.getPprice());
			ps.execute();
		} catch (Exception e) {
			System.out.println("상품등록 오류 : " + e.toString());
		}
	}
	
	//상품삭제
	public void delete(int code) {
		try {
			String sql = "DELETE FROM TBL_PRODUCTS WHERE PCODE=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setInt(1, code);
			ps.execute();
		} catch (Exception e) {
			System.out.println("상품삭제 오류 : " + e.toString());
		}
	}

	//상품 수정
	public void update(ProductVO vo) {
		try {
			String sql = "UPDATE TBL_PRODUCTS SET PNAME=?, PPRICE=? WHERE PCODE=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getPname());
			ps.setInt(2, vo.getPprice());
			ps.setInt(3, vo.getPcode());
			ps.execute();
		} catch (Exception e) {
			System.out.println("상품수정 오류 : " + e.toString());
		}
	}
}
