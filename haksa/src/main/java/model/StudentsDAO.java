package model;

import java.util.*;
import java.sql.*;

public class StudentsDAO {
	//학생목록
	public ArrayList<StudentsVO> list(int page, String query, String key){
		ArrayList<StudentsVO> list = new ArrayList<StudentsVO>();
		try {
			String sql = "select * from view_stu where "+key+" like ? limit ?, 5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%"+query+"%");
			ps.setInt(2, ((page-1)*5));
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				StudentsVO vo = new StudentsVO();
				vo.setScode(rs.getString("scode"));
				vo.setSname(rs.getString("sname"));
				vo.setDept(rs.getString("dept"));
				vo.setYear(rs.getInt("year"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setAdvisor(rs.getString("advisor"));
				vo.setPname(rs.getString("pname"));
				list.add(vo);
			}
		} catch (Exception e) {
			System.out.println("학생 목록 오류 : " + e.toString());
		}
		return list;
	}
	
	public int getTotal(String query, String key) {
		int total = 0;
		try {
			String sql = "select count(*) cnt from view_stu where "+key+" like ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%"+query+"%");
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				total = rs.getInt("cnt");
			}
		} catch (Exception e) {
			System.out.println("학생수 오류 : " + e.toString());
		}
		return total;
	}
	
	public void insert(StudentsVO vo) {
		try {
			String ncode = "";
			String sql = "select Max(scode)+1 ncode from students";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				ncode=rs.getString("ncode");
			}
			sql="insert into students(scode,sname,dept,year,birthday,advisor) values(?,?,?,?,?,?)";
			ps = Database.CON.prepareStatement(sql);
			ps.setString(1, ncode);
			ps.setString(2, vo.getSname());
			ps.setString(3, vo.getDept());
			ps.setInt(4, vo.getYear());
			ps.setString(5, vo.getBirthday());
			ps.setString(6, vo.getAdvisor());
			ps.execute();
		} catch (Exception e) {
			System.out.println("학생등록 오류 : " + e.toString());
		}
	}
	
	public StudentsVO read (String scode) {
		StudentsVO vo = new StudentsVO();
		try {
			String sql = "select * from students where scode=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, scode);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				vo.setScode(rs.getString("scode"));
				vo.setSname(rs.getString("sname"));
				vo.setDept(rs.getString("dept"));
				vo.setYear(rs.getInt("year"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setAdvisor(rs.getString("advisor"));
			}
		} catch (Exception e) {
			System.out.println("학생정보 오류 : " + e.toString());
		}
		return vo;
	}
	
	public void update(StudentsVO vo) {
		try {
			String sql="update students set sname=?,dept=?,year=?,birthday=?,advisor=? where scode=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getSname());
			ps.setString(2, vo.getDept());
			ps.setInt(3, vo.getYear());
			ps.setString(4, vo.getBirthday());
			ps.setString(5, vo.getAdvisor());
			ps.setString(6, vo.getScode());
			ps.execute();
		} catch (Exception e) {
			System.out.println("학생수정 오류 : " + e.toString());
		}
	}
}