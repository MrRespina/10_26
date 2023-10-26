package com.ji.oracleDB001;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionMain {
	
	// cmd 기반 sqlplus 프로그램으로 OracleDB를 제어 > CMD 기반은 불편함.
	
	// 사제로 나온 것 : Orange,Toad,Dbeaver,SqlDeveloper,Eclipse,...
	
	// Socket 통신 > O
	// HTTP 통신 > O
	// DB 서버와 통신 : 자바에 내장되어있지만 미완상태임.
	//	DB 메이커가 많아서 메이커별로 통신방법이 조금씩 다름
	//	연결할 DB에 맞춰서 조금씩 터치가 필요하다.
	
	// JDBC : JAVA DabaBase Connectivity
	//		자바에서 DB 프로그래밍을 하기 위해 사용되는 API

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		// 연결할 DB 주소
		// OracleDB Connection : jdbc:oracle:thin:@192.168.0.157:1521:XE
		// id : pin
		// pw : sdj7524
		
		Connection conn = null;
		try {
			String addr = "jdbc:oracle:thin:@192.168.0.157:1521:XE";
			conn = DriverManager.getConnection(addr,"pin","sdj7524");
			System.out.println("Connection 성공");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
