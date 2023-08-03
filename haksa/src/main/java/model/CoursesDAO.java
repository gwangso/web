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
	
	public String getCode() {
		
		String code = "";
		try {
			String mcode = "";
			String sql = "select max(lcode) mcode from courses";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				mcode = rs.getString("mcode");
			}
			code="N" + (Integer.parseInt(mcode.substring(1))+1);
		} catch (SQLException e) {
			
		}
		return code;
	}
	
	public void insert(CoursesVO vo) {
		try {
			String code=getCode();
			String sql = "insert into courses(lcode, lname, instructor, room, hours, capacity, persons) values(?,?,?,?,?,?,?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, code);
			ps.setString(2, vo.getLname());
			ps.setString(3, vo.getInstructor());
			ps.setString(4, vo.getRoom());
			ps.setInt(5, vo.getHours());
			ps.setInt(6, vo.getCapacity());
			ps.setInt(7, vo.getPersons());
			ps.execute();
		}catch (Exception e) {
			System.out.println("강좌등록 오류 : " + e.toString());
		}
	}
	
	//강좌목록
	public CoursesVO read(String lcode){
		CoursesVO vo = new CoursesVO();
		try {
			String 	sql = "select * from courses where lcode=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, lcode);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				vo.setLcode(rs.getString("lcode"));
				vo.setLname(rs.getString("lname"));
				vo.setHours(rs.getInt("hours"));
				vo.setRoom(rs.getString("room"));
				vo.setInstructor(rs.getString("instructor"));
				vo.setPersons(rs.getInt("persons"));
				vo.setCapacity(rs.getInt("capacity"));
			}
		}catch (Exception e) {
			System.out.println("강좌목록 오류 : " + e.toString());
		}
		return vo;
	}
	
	public void update(CoursesVO vo) {
		try {
			String sql = "update courses set lname=?, instructor=?, room=?, hours=?, capacity=?, persons=? where lcode=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getLname());
			ps.setString(2, vo.getInstructor());
			ps.setString(3, vo.getRoom());
			ps.setInt(4, vo.getHours());
			ps.setInt(5, vo.getCapacity());
			ps.setInt(6, vo.getPersons());
			ps.setString(7, vo.getLcode());
			ps.execute();
		}catch (Exception e) {
			System.out.println("강좌등록 오류 : " + e.toString());
		}
	}
}