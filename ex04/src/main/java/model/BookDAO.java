package model;

import java.sql.*;
import java.util.*;

public class BookDAO {
	public int total() {
		int total = 0;
			try {
				String sql="select count(*) cnt from tbl_books";
				PreparedStatement ps = Database.CON.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				if(rs.next()) {
					total=rs.getInt("cnt");
				}
			} catch (Exception e) {
				System.out.println("도서등록 오류 : " + e.toString());
			}
		return total;
	}
	
	
	//도서등록
	public void insert(BookVO vo) {
		try {
			String sql1="select * from tbl_books where isbn=?";
			PreparedStatement ps1 = Database.CON.prepareStatement(sql1);
			ps1.setString(1, vo.getIsbn());
			ResultSet rs = ps1.executeQuery();
			if(!rs.next()) {
				String sql ="insert into TBL_books(isbn,title,authors,publisher,thumbnail,price,pdate,url,contents) values(?,?,?,?,?,?,?,?,?)";
				PreparedStatement ps = Database.CON.prepareStatement(sql);
				ps.setString(1, vo.getIsbn());
				ps.setString(2, vo.getTitle());
				ps.setString(3, vo.getAuthors());
				ps.setString(4, vo.getPublisher());
				ps.setString(5, vo.getThumbnail());
				ps.setInt(6, vo.getPrice());
				ps.setString(7, vo.getPdate());
				ps.setString(8, vo.getUrl());
				ps.setString(9, vo.getContents());
				ps.execute();
			}
		} catch (Exception e) {
			System.out.println("도서등록 오류 : " + e.toString());
		}
	}
	
	//저장 도서목록
	public List<BookVO> list(int page){
		List<BookVO> list = new ArrayList<BookVO>();
		try {
			String sql = "Select * from tbl_books order by seq desc limit ?,5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setInt(1, ((page-1)*5));
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				BookVO vo = new BookVO();
				vo.setSeq(rs.getInt("seq"));
				vo.setTitle(rs.getString("title"));
				vo.setPublisher(rs.getString("publisher"));
				vo.setThumbnail(rs.getString("Thumbnail"));
				vo.setPrice(rs.getInt("Price"));
				vo.setContents(rs.getString("contents"));
				list.add(vo);
			}
		} catch (Exception e) {
			System.out.println("도서목록 오류 : " + e.toString());
		}
		return list;
	}

}
