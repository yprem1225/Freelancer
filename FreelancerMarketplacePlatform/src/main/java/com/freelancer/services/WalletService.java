package com.freelancer.services;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    
    public void saveTransaction(String transactionId,
            int userId,
            int walletId,
            BigDecimal amount,
            String type,
            String status,
            String description) throws ClassNotFoundException, SQLException {

		Connection con = DBConnection.getConnection();
		
		String sql = "INSERT INTO transactions " +
		"(transaction_id, user_id, wallet_id, amount, transaction_type, status, description) " +
		"VALUES (?, ?, ?, ?, ?, ?, ?)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, transactionId);
		ps.setInt(2, userId);
		ps.setInt(3, walletId);
		ps.setBigDecimal(4, amount);
		ps.setString(5, type);
		ps.setString(6, status);
		ps.setString(7, description);
		
		ps.executeUpdate();
		con.close();
		}
    
    
    
    public List<Map<String, Object>> getTransactionsByUser(int userId)
            throws ClassNotFoundException, SQLException {

        Connection con = DBConnection.getConnection();

        String sql = "SELECT transaction_id, amount, transaction_type, status " +
                     "FROM transactions WHERE user_id=? ORDER BY created_at DESC";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, userId);

        ResultSet rs = ps.executeQuery();

        List<Map<String, Object>> list = new ArrayList<>();

        while (rs.next()) {
            Map<String, Object> row = new HashMap<>();
            row.put("transaction_id", rs.getString("transaction_id"));
            row.put("amount", rs.getBigDecimal("amount"));
            row.put("type", rs.getString("transaction_type"));
            row.put("status", rs.getString("status"));

            list.add(row);
        }

        con.close();
        return list;
    }
    
    /**
     * Credits a freelancer's wallet when a project payment is released.
     * Call this from your project/payment servlet.
     */
    public void payFreelancer(int freelancerUserId, BigDecimal amount, String projectDescription)
            throws ClassNotFoundException, SQLException {

        // Ensure wallet exists
        createWalletIdNotExist(freelancerUserId);

        // Get wallet
        Wallet wallet = getWalletByUser(freelancerUserId);
        int walletId = wallet.getWalletId();

        // Credit balance
        addFunds(freelancerUserId, amount);

        // Log transaction
        String transactionId = "TXN" + System.currentTimeMillis();
        saveTransaction(
            transactionId,
            freelancerUserId,
            walletId,
            amount,
            "CREDIT",
            "SUCCESS",
            "Payment for: " + projectDescription
        );
    }

}
