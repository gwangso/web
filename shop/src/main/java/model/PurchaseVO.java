package model;

public class PurchaseVO extends UserVO{
	private String pid;
	private String purDate;
	private int purSum;
	private int status;
	
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getPurDate() {
		return purDate;
	}
	public void setPurDate(String purDate) {
		this.purDate = purDate;
	}
	public int getPurSum() {
		return purSum;
	}
	public void setPurSum(int purSum) {
		this.purSum = purSum;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
	@Override
	public String toString() {
		return "PurchaseVO [pid=" + pid + ", purDate=" + purDate + ", purSum=" + purSum + ", status=" + status
				+ ", getUid()=" + getUid() + ", getUname()=" + getUname() + ", getPhone()=" + getPhone()
				+ ", getAddress1()=" + getAddress1() + ", getAddress2()=" + getAddress2() + "]";
	}
	
	
}
