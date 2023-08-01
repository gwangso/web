package model;

import java.util.*;
import java.sql.*;

public class LocalDAO {
	public ArrayList<LocalVO> list(int page, String query){
		ArrayList<LocalVO> list = new ArrayList<LocalVO>();
		try {
			String sql = "select * from tbl_local where lname like ? or laddress like ? order by id desc limit ?,5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ps.setString(2, "%" + query + "%");
			ps.setInt(3, page);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				LocalVO vo = new LocalVO();
				vo.setId(rs.getInt("id"));
				vo.setLid(rs.getString("lid"));
				vo.setLname(rs.getString("lname"));
				vo.setLaddress(rs.getString("laddress"));
				vo.setLphone(rs.getString("lphone"));
				list.add(vo);
			}
		} catch (Exception e) {
			System.out.println("지역목록 : " + e.toString());
		}
		return list; 
	}
	
	public int total(String query) {
		int total = 0;
		try {
			String sql = "select count(*) cnt from tbl_local where lname like ? or laddress like ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ps.setString(2, "%" + query + "%");
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				total = rs.getInt("cnt");
			}
		} catch (Exception e) {
			System.out.println("지역총합 : " + e.toString());
		}
		return total;
	}
}
