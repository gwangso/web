package model;

import java.sql.*;
import java.util.*;

public class ProductDAO {
	//목록 출력 
	public List<ProductVO> list(){
		List<ProductVO> list = new ArrayList<ProductVO>();
		try {
			String sql = "SELECT * FROM TBL_PRODUCTS ORDER BY PCODE DESC";
			PreparedStatement pre = Database.CON.prepareStatement(sql);
			ResultSet rs = pre.executeQuery();
			while (rs.next()) {
				ProductVO vo = new ProductVO();
				vo.setPcode(rs.getInt("pcode"));
				vo.setPname(rs.getString("pname"));
				vo.setPprice(rs.getInt("pprice"));
				vo.setPdate(rs.getTimestamp("pdate"));
				list.add(vo);
			}
		} catch (Exception e) {
			System.out.println("상품목록 출력 오류 : " + e.toString());
		}
		return list;
	}
}

