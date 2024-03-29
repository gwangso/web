package model;

import java.sql.*;
import java.util.*;

public class ProductDAO {
	//전체 상품 수
	public int getProEA() {
		int count = 0;
		try {
			String sql ="select count(*) r from tbl_products";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				count = rs.getInt("r");
			}
		} catch (Exception e) {
			System.out.println("상품 개수 출력 오류 : " + e.toString());
		}
		return count;
	}
	
	public List<ProductVO> list(int page){
		List<ProductVO> list = new ArrayList<ProductVO>();
		try {
			String sql = "SELECT * FROM TBL_PRODUCTS ORDER BY PCODE DESC LIMIT ?, 5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setInt(1, (page-1)*5);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				ProductVO vo = new ProductVO();
				vo.setPcode(rs.getInt("pcode"));
				vo.setPname(rs.getString("pname"));
				vo.setPprice(rs.getInt("pprice"));
				vo.setPdate(rs.getTimestamp("pdate"));
				list.add(vo);
			}
		} catch (Exception e) {
			System.out.println("상품 목록 출력 오류 : " + e.toString());
		}
		return list;
	}
	
	public void insert(ProductVO vo) {
		try {
			String sql = "INSERT INTO TBL_PRODUCTS(PNAME, PPRICE) VALUES(?,?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getPname());
			ps.setInt(2, vo.getPprice());
			ps.execute();
		} catch (Exception e) {
			System.out.println("상품 등록 오류 : " + e.toString());
		}
		
	}
	
	public ProductVO read(String code) {
		ProductVO vo = new ProductVO();
		try {
			String sql = "SELECT * FROM TBL_PRODUCTS WHERE PCODE=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, code);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				vo.setPcode(rs.getInt("pcode"));
				vo.setPname(rs.getString("pname"));
				vo.setPprice(rs.getInt("pprice"));
				vo.setPdate(rs.getTimestamp("pdate"));
			}
		} catch (Exception e) {
			System.out.println("상품 정보 출력 오류 : " + e.toString());
		}
		return vo;
	}
	
	public void delete(String code) {
		try {
			String sql = "DELETE FROM TBL_PRODUCTS WHERE PCODE=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, code);
			ps.execute();
		} catch (Exception e) {
			System.out.println("상품 삭제 오류 : " + e.toString());
		}
	}
	
	public void update(ProductVO vo) {
		try {
			String sql = "UPDATE TBL_PRODUCTS SET PNAME=?, PPRICE=?, PDATE=now() WHERE PCODE=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getPname());
			ps.setInt(2, vo.getPprice());
			ps.setInt(3, vo.getPcode());
			ps.execute();
		} catch (Exception e) {
			System.out.println("상품 삭제 오류 : " + e.toString());
		}
	}
}
