package model;

public class EnrollVO extends CoursesVO{
	private String scode;
	private String lcode;
	private String edate;
	private int grade;
	
	public String getScode() {
		return scode;
	}
	public void setScode(String scode) {
		this.scode = scode;
	}
	public String getLcode() {
		return lcode;
	}
	public void setLcode(String lcode) {
		this.lcode = lcode;
	}
	public String getEdate() {
		return edate;
	}
	public void setEdate(String edate) {
		this.edate = edate;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	@Override
	public String toString() {
		return "EnrollVO [scode=" + scode + ", lcode=" + lcode + ", edate=" + edate + ", grade=" + grade
				+ ", getLname()=" + getLname() + ", getHours()=" + getHours() + ", getRoom()=" + getRoom()
				+ ", getCapacity()=" + getCapacity() + ", getPersons()=" + getPersons() + ", getPname()=" + getPname()
				+ "]";
	}
	
}
