package com.company3;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	
	/*
	 * private static final String driver ="oracle.jdbc.OracleDriver"; private
	 * static final String url ="jdbc:oracle:thin:@localhost:1521:XE"; private
	 * static final String user ="lch"; private static final String pwd ="lch";
	 */

	
	private PreparedStatement pstmt;
	private Connection con;
	private DataSource dataFactory;
	
	
	
	public MemberDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("jdbc/oracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}



	public List<MemberVO> listMembers(){
		
		List<MemberVO> list = new ArrayList<>(); // 메모리 할당
		
		try {
			
		//	connDB();
			con = dataFactory.getConnection();
			String query = "select * from t_member";
			System.out.println(query);
			pstmt = con.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				
				String id = rs.getString("id");
				String pwd = rs.getString("pwd");
				String name = rs.getString("name");
				String email = rs.getString("email");
				Date joinDate = rs.getDate("joinDate");
				
				MemberVO vo = new MemberVO();
				vo.setId(id);
				vo.setPwd(pwd);
				vo.setName(name);
				vo.setEmail(email);
				vo.setJoinDate(joinDate);
				
				list.add(vo);
			
			
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
			
		}	
		return list;
	}
}
		
	
/*
 * private void connDB() { try { Class.forName(driver);
 * System.out.println("Oracle 드라이버 로딩 성공"); con =
 * DriverManager.getConnection(url,user,pwd);
 * System.out.println("Connection 드라이버 생성 성공"); //
 * System.out.println("Statement 드라이버 생성 성공"); } catch (Exception e) {
 * e.printStackTrace();
 * 
 * }
 * 
 * 
 * 
 * 
 * 
 * 
 * }
 * 
 * 
 * 
 * }
 * 
 */