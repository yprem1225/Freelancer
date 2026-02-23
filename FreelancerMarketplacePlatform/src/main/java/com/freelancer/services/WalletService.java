package com.freelancer.services;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.model.Wallet;
import com.util.DBConnection;

public class WalletService {
	
	// create wallet if not exist
	public void createWalletIdNotExist(int userId) throws SQLException {
		try {
			Connection con =  DBConnection.getConnection();
			String checksql = "SELECT wallet_id FROM wallet WHERE user_id=?";
			PreparedStatement ps = con.prepareStatement(checksql);
			
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			if(!rs.next()) {
				 	String insertSql = "INSERT INTO wallet(user_id, balance) VALUES(?, 0)";
		            PreparedStatement insertPs = con.prepareStatement(insertSql);
		            insertPs.setInt(1, userId);
		            insertPs.executeUpdate();
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	 // 2️⃣ Get wallet by user
    public Wallet getWalletByUser(int userId)
            throws ClassNotFoundException, SQLException {

        Connection con = DBConnection.getConnection();

        String sql = "SELECT * FROM wallet WHERE user_id=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, userId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            Wallet wallet = new Wallet();
            wallet.setWalletId(rs.getInt("wallet_id"));
            wallet.setUserId(rs.getInt("user_id"));
            wallet.setBalance(rs.getBigDecimal("balance"));
            return wallet;
        }

        con.close();
        return null;
    }
    
    // 3️⃣ Add funds (dummy manual)
    public void addFunds(int userId, BigDecimal amount)
            throws ClassNotFoundException, SQLException {

        Connection con = DBConnection.getConnection();

        String sql = "UPDATE wallet SET balance = balance + ? WHERE user_id=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setBigDecimal(1, amount);
        ps.setInt(2, userId);

        ps.executeUpdate();
        con.close();
    }

}
