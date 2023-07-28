package model;

import java.util.*;

public class ProductVO {
	private int pcode;
	private String pname;
	private int pprice;
	private Date pdate;
	
	public int getPcode() {
		return pcode;
	}
	public void setPcode(int pcode) {
		this.pcode = pcode;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getPprice() {
		return pprice;
	}
	public void setPprice(int pprice) {
		this.pprice = pprice;
	}
	public Date getPdate() {
		return pdate;
	}
	public void setPdate(Date pdate) {
		this.pdate = pdate;
	}
	
	public String toString() {
		return "ProductDAO [pcode=" + pcode + ", pname=" + pname + ", pprice=" + pprice + ", pdate=" + pdate + "]";
	}
}
