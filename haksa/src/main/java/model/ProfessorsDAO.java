package model;

import java.util.*;
import java.sql.*;
import java.text.*;


public class ProfessorsDAO {
	//교수목록
	public ArrayList<ProfessorsVO> list(int page, String query, String key){
		ArrayList<ProfessorsVO> array = new ArrayList<ProfessorsVO>();
		try {
			String sql = "select * from professors where "+key+" like ? limit ?, 5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ps.setInt(2, ((page-1)*5));
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				ProfessorsVO vo = new ProfessorsVO();
				vo.setPcode(rs.getString("pcode"));
				vo.setPname(rs.getString("pname"));
				vo.setDept(rs.getString("dept"));
				vo.setHiredate(rs.getString("Hiredate"));
				vo.setTitle(rs.getString("title"));
				vo.setSalary(rs.getInt("salary"));
				array.add(vo);
			}
		} catch (Exception e) {
			System.out.println("교수 목록 오류 : " + e.toString());
		}
		return array;
	}
	
	//전체 데이터 개수
	public int getTotal(String query, String key) {
		int total = 0;
		try {
			String sql = "select count(*) cnt from professors where "+key+" like ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				total = rs.getInt("cnt");
			}
		} catch (Exception e) {
			System.out.println("교수데이터 개수 오류 : " + e.toString());
		}
		return total;
	}
	
	//교수등록
	public void insert(ProfessorsVO vo) {
		try {
			int ncode=0;
			String sql = "select max(pcode)+1 ncode from professors";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				ncode = rs.getInt("ncode");
			}
			sql = "insert into professors(pcode,pname,dept,hiredate,title,salary) values(?,?,?,?,?,?)";
			ps = Database.CON.prepareStatement(sql);
			ps.setInt(1, ncode);
			ps.setString(2, vo.getPname());
			ps.setString(3, vo.getDept());
			ps.setString(4, vo.getHiredate().toString());
			ps.setString(5, vo.getTitle());			
			ps.setInt(6, vo.getSalary());
			ps.execute();
		} catch (Exception e) {
			System.out.println("교수등록 오류 : " + e.toString());
		}
	}
	
	public ProfessorsVO read(String pcode) {
		ProfessorsVO vo = new ProfessorsVO();
		try {
			String sql = "select * from professors where pcode=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, pcode);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				vo.setPcode(rs.getString("pcode"));
				vo.setPname(rs.getString("pname"));
				vo.setDept(rs.getString("dept"));
				vo.setHiredate(rs.getString("Hiredate"));
				vo.setTitle(rs.getString("title"));
				vo.setSalary(rs.getInt("salary"));
			}
		} catch (Exception e) {
			System.out.println("교수 정보 오류 : " + e.toString());
		}
		return vo;
	}
	
	public void update(ProfessorsVO vo) {
		try {
			String sql = "UPDATE professors SET pname=?, dept=?, hiredate=?, title=?, salary=? WHERE PCODE=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getPname());
			ps.setString(2, vo.getDept());
			ps.setString(3, vo.getHiredate().toString());
			ps.setString(4, vo.getTitle());			
			ps.setInt(5, vo.getSalary());
			ps.setString(6, vo.getPcode());
			ps.execute();
		} catch (Exception e) {
			System.out.println("교수등록 오류 : " + e.toString());
		}
	}
	
	public ArrayList<ProfessorsVO> allList() {
		ArrayList<ProfessorsVO> array = new ArrayList<ProfessorsVO>();
		try {
			String sql = "select * from professors order by pname asc";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				ProfessorsVO vo = new ProfessorsVO();
				vo.setPcode(rs.getString("pcode"));
				vo.setPname(rs.getString("pname"));
				vo.setDept(rs.getString("dept"));
				vo.setHiredate(rs.getString("Hiredate"));
				vo.setTitle(rs.getString("title"));
				vo.setSalary(rs.getInt("salary"));
				array.add(vo);
			}
		} catch (Exception e) {
			System.out.println("모든 교수 목록 오류 : " + e.toString());
		}
		return array;
	}
}
