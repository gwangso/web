package model;

import java.text.SimpleDateFormat;

public class DAOtest {

	public static void main(String[] args) {
		ProfessorsDAO pdao = new ProfessorsDAO();
		StudentsDAO sdao = new StudentsDAO();
		CoursesDAO cdao = new CoursesDAO();
		
//		for(ProfessorsVO vo : pdao.list(1, "이", "pname")) {
//			System.out.println(vo.toString());
//		}
//		System.out.println("총개수 " + pdao.getTotal("이", "pname"));

//		for(StudentsVO vo : sdao.list(1, "", "sname")) {
//			System.out.println(vo.toString());
//		}
//		System.out.println("총개수 " + sdao.getTotal("", "pname"));
		
//		for(CoursesVO vo : cdao.list(1, "리", "lname")) {
//			System.out.println(vo.toString());
//		}
//		System.out.println("총개수 " + cdao.getTotal("리", "lname"));
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");		
		ProfessorsVO vo = new ProfessorsVO();
//		vo.setPname("용몽리");
//		vo.setDept("컴정");
//		vo.setTitle("정교수");
//		vo.setHiredate("2023-08-02");
//		vo.setSalary(3000000);
//		System.out.println(vo.toString());
//		pdao.insert(vo);
		
//		System.out.println(pdao.read("159").toString());
//		
//		StudentsVO svo = new StudentsVO();
//		svo.setSname("남승훈");
//		svo.setDept("전자");
//		svo.setBirthday("1995-07-11");
//		svo.setYear(3);
//		svo.setAdvisor("311");
//		sdao.insert(svo);

//		System.out.println(cdao.getCode());
		System.out.println(cdao.read("A109").toString());
	
	
	}
	
}
