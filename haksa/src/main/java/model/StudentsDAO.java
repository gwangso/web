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
			String sql = "select * from view_stu where scode=?";
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
				vo.setPname(rs.getString("pname"));
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
	
	//수강신청 목록
	public ArrayList<EnrollVO> list(String scode){
		ArrayList<EnrollVO> list = new ArrayList<EnrollVO>(); 
		try {
			String sql = "select * from view_enroll_cou where scode=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, scode);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				EnrollVO vo = new EnrollVO();
				vo.setLcode(rs.getString("lcode"));
				vo.setScode(rs.getString("scode"));
				vo.setEdate(rs.getString("edate"));
				vo.setGrade(rs.getInt("grade"));
				vo.setLname(rs.getString("lname"));
				vo.setPname(rs.getString("pname"));
				vo.setHours(rs.getInt("hours"));
				vo.setRoom(rs.getString("room"));
				vo.setCapacity(rs.getInt("capacity"));
				vo.setPersons(rs.getInt("persons"));
				list.add(vo);
			}
		} catch (Exception e) {
			System.out.println("수강신청목록 오류 : " + e.toString());
		}
		return list;
	}
	
	//수강신청등록
	public int insert(String scode, String lcode) {
		//성공하면 1, 실패하면 0
		int count = -1;
		try {
			String sql = "call add_enroll(?, ?, ?)";
			CallableStatement cs = Database.CON.prepareCall(sql); //Stored Procedures를 불러올 때
			cs.setString(1, scode);
			cs.setString(2, lcode);
			cs.registerOutParameter(3, java.sql.Types.INTEGER); //output변수의 경우 지정방법(output변수의 값은 integer다)
			cs.execute();
			count = cs.getInt(3); //cs의 값 3번째것을 가져와라
		} catch (Exception e) {
			System.out.println("수강신청 등록 오류 : " +e.toString());
		}
		return count;
	}
	
	//수강취소
	public void delete(String scode, String lcode) {
		try {
			String sql = "call del_enroll(?, ?)";
			CallableStatement cs = Database.CON.prepareCall(sql); //Stored Procedures를 불러올 때
			cs.setString(1, scode);
			cs.setString(2, lcode);
			cs.execute();
		} catch (Exception e) {
			System.out.println("수강취소 오류 : " +e.toString());
		}
	}
}