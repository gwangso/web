package model;

import java.util.*;
import java.sql.*;

public class CoursesDAO {
	//강좌목록
	public ArrayList<CoursesVO> list(int page, String query, String key){
		ArrayList<CoursesVO> list = new ArrayList<CoursesVO>();
		try {
			String 	sql = "select * from view_cou";
					sql += " where "+key+" like ?";
					sql += " limit ?, 5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ps.setInt(2, ((page-1)*5));
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				CoursesVO vo = new CoursesVO();
				vo.setLcode(rs.getString("lcode"));
				vo.setLname(rs.getString("lname"));
				vo.setHours(rs.getInt("hours"));
				vo.setRoom(rs.getString("room"));
				vo.setInstructor(rs.getString("instructor"));
				vo.setPersons(rs.getInt("persons"));
				vo.setCapacity(rs.getInt("capacity"));
				vo.setPname(rs.getString("pname"));
				list.add(vo);
			}
		}catch (Exception e) {
			System.out.println("강좌목록 오류 : " + e.toString());
		}
		return list;
	}

	public int getTotal(String query, String key){
		int total = 0;
		try {
			String 	sql = "select count(*) cnt from view_cou";
					sql += " where "+key+" like ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				total = rs.getInt("cnt");
			}
		}catch (Exception e) {
			System.out.println("강좌수 오류 : " + e.toString());
		}
		return total;
	}
}