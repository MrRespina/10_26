package com.ji.oracleDB001;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;

public class InsertMain {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			String addr = "jdbc:oracle:thin:@192.168.0.157:1521:XE";
			conn = DriverManager.getConnection(addr,"pin","sdj7524");
			System.out.println("Connection 성공");
			
			String sql = "INSERT INTO oct26_item VALUES(oct26_item_seq.nextval";
			String insertSql = insert();
			
			sql = sql + insertSql;
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
			
			System.out.println("입력 성공!");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}
	
	public static String insert() {
		
		String sqlline = ",";
		Scanner s = new Scanner(System.in);
		System.out.println("DB에 넣을 작물의 이름을 입력해주세요 : ");
		String name = s.nextLine();
		
		System.out.println("DB에 넣을 FK의 숫자를 입력해주세요 : ");
		String fk = s.nextLine();
		
		System.out.println("DB에 넣을 WEIGHT의 숫자를 입력해주세요 : ");
		String weight = s.nextLine();
		
		System.out.println("DB에 넣을 PRICE의 숫자를 입력해주세요 : ");
		String price = s.nextLine();
		
		sqlline = sqlline+fk+","+"'"+name+"',"+weight+","+price+")";	
		
		return sqlline;
	}

}
