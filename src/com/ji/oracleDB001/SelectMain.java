package com.ji.oracleDB001;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SelectMain {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String addr = "jdbc:oracle:thin:@192.168.0.157:1521:XE";
			conn = DriverManager.getConnection(addr,"pin","sdj7524");
			System.out.println("Connection 성공");
			
			String sql = "SELECT * FROM oct26_item ORDER BY i_name";
			pstmt = conn.prepareStatement(sql);
			
			// pstmt.executeQuery() : 데이터(R - select문)
			// pstmt.executeUpdate() : 몇개나 영향을 받았나(C,U,D)
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				// rs.getXXX("컬럼명") : 현재 위치의 컬럼 읽기
				// rs.getXXX(인덱스) : 현재 데이터의 인덱스에 해당하는 컬럼 읽기
				System.out.println("PK : "+rs.getInt("i_num"));
				System.out.println("FK : "+rs.getInt("i_m_num"));
				System.out.println("NAME : "+rs.getString("i_name"));
				System.out.println("WEIGHT : "+rs.getInt("i_weight"));
				System.out.println("PRICE : "+rs.getString("i_price"));
				System.out.println("====================");
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}
