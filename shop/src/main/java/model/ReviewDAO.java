package model;

import java.sql.*;
import java.text.*;
import java.util.*;

public class ReviewDAO {
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
	//리뷰등록
	public void insert(ReviewVO vo) {
		try {
			String sql = "insert into reviews(gid,uid,content) values(?,?,?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getGid());
			ps.setString(2, vo.getUid());
			ps.setString(3, vo.getContent());
			ps.execute();
		} catch (Exception e) {
			System.out.println("리뷰등록 오류 : " + e.toString());
		}
	}
	
	//리뷰 리스트
	public ArrayList<ReviewVO> list(String gid){
		ArrayList<ReviewVO> list = new ArrayList<ReviewVO>();
		try {
			String sql = "select * from view_reviews where gid=? order by rid desc";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, gid);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				ReviewVO vo = new ReviewVO();
				vo.setGid(rs.getString("gid"));
				vo.setRid(rs.getInt("rid"));
				vo.setUid(rs.getString("uid"));
				vo.setContent(rs.getString("content"));
				vo.setRevDate(sdf.format(rs.getTimestamp("revDate")));
				vo.setUname(rs.getString("uname"));
				vo.setPhoto(rs.getString("photo"));
				list.add(vo);
			}
		} catch (Exception e) {
			System.out.println("리뷰목록 오류 : " + e.toString());
		}
		return list;
	}
	
	//리뷰 삭제
	public void delete(int rid) {
		try {
			String sql="delete from reviews where rid=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setInt(1, rid);
			ps.execute();
		} catch (Exception e) {
			System.out.println("리뷰 삭제 오류 : " + e.toString());
		}
	}
	
	//리뷰 수정
	public void update(int rid, String content) {
		try {
			String sql="update reviews set content=? where rid=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, content);
			ps.setInt(2, rid);
			ps.execute();
		} catch (Exception e) {
			System.out.println("리뷰 삭제 오류 : " + e.toString());
		}
	}
}
