package model;

import java.sql.*;

public class LocalDAO {
	
	//입력
	public void insert(LocalVO vo) {
		try {
			String sql = "select * from local where lid=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(!rs.next()) {
				sql = "INSERT INTO TBL_LOCAL(LID,LNAME,LADDRESS,LPHONE,LURL,X,Y) VALUES(?,?,?,?,?,?,?)";
				ps = Database.CON.prepareStatement(sql);
				ps.setString(1, vo.getLid());
				ps.setString(2, vo.getLname());
				ps.setString(3, vo.getLaddress());
				ps.setString(4, vo.getLphone());
				ps.setString(5, vo.getLurl());
				ps.setString(6, vo.getX());
				ps.setString(7, vo.getY());
				ps.execute();
			}
		} catch (Exception e) {
			System.out.println("지역등록 오류" + e.toString());
		}
	}
}
