package model;

import java.sql.*;
import java.text.*;
import java.util.*;

public class PurchaseDAO {
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	//구매정보등록
	public void insert(PurchaseVO vo) {
		try {
			String sql="insert into purchase(pid,uid,raddress1,raddress2,rphone,purSum) values(?,?,?,?,?,?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getPid());
			ps.setString(2, vo.getUid());
			ps.setString(3, vo.getAddress1());
			ps.setString(4, vo.getAddress2());
			ps.setString(5, vo.getPhone());
			ps.setInt(6, vo.getPurSum());
			ps.execute();
		} catch (Exception e) {
			System.out.println("구매등록 오류 : " + e.toString());
		}
	}
	
	//주문상품 등록
	public void insert(OrderVO vo) {
		try {
			String sql="insert into orders(pid,gid,price,qnt) values(?,?,?,?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getPid());
			ps.setString(2, vo.getGid());
			ps.setInt(3, vo.getPrice());
			ps.setInt(4, vo.getQnt());
			ps.execute();
		} catch (Exception e) {
			System.out.println("주문상품등록 오류 : " + e.toString());
		}
	}
	
	//구매목록(관리자용)
	public ArrayList<PurchaseVO> list(String key, String query, int page){
		ArrayList<PurchaseVO> array = new ArrayList<PurchaseVO>();
		try {
			String sql = "select * from view_purchase where "+key+" like ? order by purDate desc limit ?,5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%"+query+"%");
			ps.setInt(2, (page-1)*5);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				PurchaseVO vo = new PurchaseVO();
				vo.setPid(rs.getString("pid"));
				vo.setUid(rs.getString("uid"));
				vo.setUname(rs.getString("uname"));
				vo.setAddress1(rs.getString("raddress1"));
				vo.setAddress2(rs.getString("raddress2"));
				vo.setPhone(rs.getString("rphone"));
				vo.setPurSum(rs.getInt("pursum"));
				vo.setPurDate(sdf.format(rs.getTimestamp("purdate")));
				vo.setStatus(rs.getInt("status"));
				array.add(vo);
			}
		} catch (Exception e) {
			System.out.println("구매목록 오류 : " + e.toString());
		}
		return array;
	}
	
	//주문목록(사용자용)
	public ArrayList<PurchaseVO> user(String uid){
		ArrayList<PurchaseVO> array = new ArrayList<PurchaseVO>();
		try {
			String sql = "select * from purchase where uid=? order by purdate";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, uid);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				PurchaseVO vo = new PurchaseVO();
				vo.setPid(rs.getString("pid"));
				vo.setUid(rs.getString("uid"));
				vo.setAddress1(rs.getString("raddress1"));
				vo.setAddress2(rs.getString("raddress2"));
				vo.setPhone(rs.getString("rphone"));
				vo.setPurSum(rs.getInt("pursum"));
				vo.setPurDate(sdf.format(rs.getTimestamp("purdate")));
				vo.setStatus(rs.getInt("status"));
				array.add(vo);
			}
		} catch (Exception e) {
			System.out.println("주문목록 오류 : " + e.toString());
		}
		return array;
	}
	
	
	public int total(String key, String query) {
		int total=0;
		try {
			String sql = "select count(*) from view_purchase where "+key+" like ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%"+query+"%");
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				total=rs.getInt("count(*)");
			}
		} catch (Exception e) {
			System.out.println("구매검색수 오류 : " + e.toString());
		}
		return total;
	}
	
	//구매정보읽기
	public PurchaseVO read(String pid) {
		PurchaseVO vo = new PurchaseVO();
		try {
			String sql = "select * from view_purchase where pid=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, pid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				vo.setPid(rs.getString("pid"));
				vo.setUid(rs.getString("uid"));
				vo.setUname(rs.getString("uname"));
				vo.setAddress1(rs.getString("raddress1"));
				vo.setAddress2(rs.getString("raddress2"));
				vo.setPhone(rs.getString("rphone"));
				vo.setPurDate(sdf.format(rs.getTimestamp("purdate")));
				vo.setStatus(rs.getInt("status"));
				vo.setPurSum(rs.getInt("pursum"));
			}
		} catch (Exception e) {
			System.out.println("구매정보 오류 : " + e.toString());
		}
		return vo;
	}
	
	//구매상품목록
	public ArrayList<OrderVO> list(String pid){
		ArrayList<OrderVO> array = new ArrayList<OrderVO>();
		try {
			String sql = "select * from view_orders where pid=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, pid);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				OrderVO vo = new OrderVO();
				vo.setOid(rs.getInt("oid"));
				vo.setPid(rs.getString("pid"));
				vo.setGid(rs.getString("gid"));
				vo.setTitle(rs.getString("title"));
				vo.setImage(rs.getString("image"));
				vo.setQnt(rs.getInt("qnt"));
				vo.setPrice(rs.getInt("price"));
				array.add(vo);
			}
		} catch (Exception e) {
			System.out.println("구매상품목록 오류 : " + e.toString());
		}
		return array;
	}
	
	//상태(status)변경
	public void update(String pid, int status) {
		try {
			String sql = "UPDATE PURCHASE SET STATUS=? WHERE PID=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setInt(1, status);
			ps.setString(2, pid);
			ps.execute();
		} catch (Exception e) {
			System.out.println("구매상태변경 오류 : " + e.toString());
		}
	}
}