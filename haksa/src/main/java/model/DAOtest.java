package model;

public class DAOtest {

	public static void main(String[] args) {
		ProfessorsDAO pdao = new ProfessorsDAO();
		StudentsDAO sdao = new StudentsDAO();
		
//		for(ProfessorsVO vo : pdao.list(1, "이", "pname")) {
//			System.out.println(vo.toString());
//		}
//		System.out.println("총개수 " + pdao.getTotal("이", "pname"));

		for(StudentsVO vo : sdao.list(1, "", "sname")) {
			System.out.println(vo.toString());
		}
		System.out.println("총개수 " + sdao.getTotal("", "pname"));
		
	}
}
