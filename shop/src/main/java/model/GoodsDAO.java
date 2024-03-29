package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class GoodsDAO {
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	//상품등록
	public void insert(GoodsVO vo) {
		try {
			String sql = "INSERT INTO GOODS(GID,TITLE,PRICE,MAKER,IMAGE) VALUES(?,?,?,?,?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getGid());
			ps.setString(2, vo.getTitle());
			ps.setInt(3, vo.getPrice());
			ps.setString(4, vo.getMaker());
			ps.setString(5, vo.getImage());
			ps.execute();
		} catch (Exception e) {
			System.out.println("상품등록 오류 : " + e.toString());
		}
	}
	
	public ArrayList<GoodsVO> list (int page, String query, String uid){
		ArrayList<GoodsVO> list = new ArrayList<GoodsVO>();
		try {
			String sql = "select *,";
					sql += "(select count(*) from favorite where g.gid=gid and uid=?) ucnt";
					sql += " from view_goods g where title like ? limit ?,6";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, uid);
			ps.setString(2, "%" + query + "%");
			ps.setInt(3, (page-1)*6);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				GoodsVO vo = new GoodsVO();
				vo.setGid(rs.getString("gid"));
				vo.setTitle(rs.getString("title"));
				vo.setImage(rs.getString("image"));
				vo.setMaker(rs.getString("maker"));
				vo.setPrice(rs.getInt("price"));
				vo.setRegDate(sdf.format(rs.getTimestamp("regDate")));
				vo.setFcnt(rs.getInt("fcnt"));
				vo.setRcnt(rs.getInt("rcnt"));
				vo.setUcnt(rs.getInt("ucnt"));
				list.add(vo);
			}
		}catch (Exception e) {
			System.out.println("상품 목록 오류 : " + e.toString());
		}
		return list;
	}
	
	public int total(String query) {
		int total=0;
		try {
			String sql= "select count(*) cnt from goods where title like ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query +"%");
			ResultSet rs = ps.executeQuery();
			if(rs.next()) total=rs.getInt("cnt");
		} catch (Exception e) {
			System.out.println("상품 총수 오류 : " + e.toString());
		}
		return total;
	}
	
	public void delete(String gid) {
		try {
			String sql="delete from goods where gid=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, gid);
			ps.execute();
		} catch (Exception e) {
			System.out.println("상품 삭제 오류 : " + e.toString());
		}
	}
	
	public GoodsVO read(String gid) {
		GoodsVO vo = new GoodsVO();
		try {
			String sql = "select * from goods where gid=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, gid);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				vo.setGid(rs.getString("gid"));
				vo.setTitle(rs.getString("title"));
				vo.setImage(rs.getString("image"));
				vo.setMaker(rs.getString("maker"));
				vo.setPrice(rs.getInt("price"));
				vo.setRegDate(sdf.format(rs.getTimestamp("regDate")));
			}
		}catch (Exception e) {
			System.out.println("상품 정보 오류 : " + e.toString());
		}
		return vo;
	}
	
	public void update(GoodsVO vo) {
		try {
			String sql = "UPDATE GOODS SET TITLE=?, PRICE=?, MAKER=? ,IMAGE=? WHERE GID=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getTitle());
			ps.setInt(2, vo.getPrice());
			ps.setString(3, vo.getMaker());
			ps.setString(4, vo.getImage());
			ps.setString(5, vo.getGid());
			ps.execute();
		} catch (Exception e) {
			System.out.println("상품수정 오류 : " + e.toString());
		}
	}
}