package com.freelancer.services;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.util.DBConnection;

public class EscrowService {

    /**
     * Called when a client ACCEPTS a proposal.
     * Debits client wallet and holds amount in escrow_wallet.
     * Throws IllegalStateException if client has insufficient balance.
     */
    public void holdFunds(int jobId, int clientUserId, int freelancerUserId, BigDecimal amount)
            throws ClassNotFoundException, SQLException {

        WalletService walletService = new WalletService();

        // 1. Ensure client wallet exists
        walletService.createWalletIdNotExist(clientUserId);

        // 2. Check sufficient balance
        com.model.Wallet clientWallet = walletService.getWalletByUser(clientUserId);
        if (clientWallet == null || clientWallet.getBalance().compareTo(amount) < 0) {
            throw new IllegalStateException("Insufficient wallet balance to hold in escrow.");
        }

        Connection con = DBConnection.getConnection();

        // 3. Debit client wallet
        String debitSql = "UPDATE wallet SET balance = balance - ? WHERE user_id = ?";
        PreparedStatement ps1 = con.prepareStatement(debitSql);
        ps1.setBigDecimal(1, amount);
        ps1.setInt(2, clientUserId);
        ps1.executeUpdate();
        ps1.close();

        // 4. Log DEBIT transaction for client
        String txnId = "ESC_HOLD_" + System.currentTimeMillis();
        String txnSql = "INSERT INTO transactions " +
                "(transaction_id, user_id, wallet_id, amount, transaction_type, status, description) " +
                "VALUES (?, ?, ?, ?, 'DEBIT', 'SUCCESS', ?)";
        PreparedStatement ps2 = con.prepareStatement(txnSql);
        ps2.setString(1, txnId);
        ps2.setInt(2, clientUserId);
        ps2.setInt(3, clientWallet.getWalletId());
        ps2.setBigDecimal(4, amount);
        ps2.setString(5, "Escrow hold for job #" + jobId);
        ps2.executeUpdate();
        ps2.close();

        // 5. Insert into escrow_wallet
        String escrowSql = "INSERT INTO escrow_wallet(job_id, client_id, freelancer_id, amount, status) " +
                "VALUES(?, ?, ?, ?, 'HELD')";
        PreparedStatement ps3 = con.prepareStatement(escrowSql);
        ps3.setInt(1, jobId);
        ps3.setInt(2, clientUserId);
        ps3.setInt(3, freelancerUserId);
        ps3.setBigDecimal(4, amount);
        ps3.executeUpdate();
        ps3.close();

        con.close();
    }

    /**
     * Called when client clicks "Release Payment".
     * Moves funds from escrow to freelancer wallet and marks job COMPLETED.
     */
    public void releaseFunds(int jobId, int clientUserId)
            throws ClassNotFoundException, SQLException {

        Connection con = DBConnection.getConnection();

        // 1. Fetch escrow record
        String fetchSql = "SELECT * FROM escrow_wallet WHERE job_id = ? AND status = 'HELD'";
        PreparedStatement ps1 = con.prepareStatement(fetchSql);
        ps1.setInt(1, jobId);
        ResultSet rs = ps1.executeQuery();

        if (!rs.next()) {
            rs.close(); ps1.close(); con.close();
            throw new IllegalStateException("No held escrow found for this job.");
        }

        int freelancerUserId = rs.getInt("freelancer_id");
        BigDecimal amount    = rs.getBigDecimal("amount");
        int escrowId         = rs.getInt("escrow_id");
        rs.close();
        ps1.close();

        // 2. Credit freelancer wallet (creates wallet if needed)
        WalletService walletService = new WalletService();
        walletService.createWalletIdNotExist(freelancerUserId);
        walletService.addFunds(freelancerUserId, amount);

        // 3. Log CREDIT transaction for freelancer
        com.model.Wallet fWallet = walletService.getWalletByUser(freelancerUserId);
        String txnId = "ESC_REL_" + System.currentTimeMillis();
        walletService.saveTransaction(
                txnId,
                freelancerUserId,
                fWallet.getWalletId(),
                amount,
                "CREDIT",
                "SUCCESS",
                "Payment released by client for job #" + jobId
        );

        // 4. Mark escrow as RELEASED
        String releaseSql = "UPDATE escrow_wallet SET status = 'RELEASED' WHERE escrow_id = ?";
        PreparedStatement ps2 = con.prepareStatement(releaseSql);
        ps2.setInt(1, escrowId);
        ps2.executeUpdate();
        ps2.close();

        // 5. Mark job as COMPLETED
        String jobSql = "UPDATE jobs SET status = 'COMPLETED' WHERE job_id = ?";
        PreparedStatement ps3 = con.prepareStatement(jobSql);
        ps3.setInt(1, jobId);
        ps3.executeUpdate();
        ps3.close();

        // 6. Notify freelancer
        String notifySql = "INSERT INTO notifications(user_id, user_type, message, reference_id) " +
                "VALUES(?, 'freelancer', ?, ?)";
        PreparedStatement ps4 = con.prepareStatement(notifySql);
        ps4.setInt(1, freelancerUserId);
        ps4.setString(2, "💰 Payment of ₹" + amount + " has been released to your wallet!");
        ps4.setInt(3, jobId);
        ps4.executeUpdate();
        ps4.close();

        con.close();
    }

    /**
     * Returns the escrow record for a job, or null if none.
     */
    public java.util.Map<String, Object> getEscrowByJob(int jobId)
            throws ClassNotFoundException, SQLException {

        Connection con = DBConnection.getConnection();
        String sql = "SELECT * FROM escrow_wallet WHERE job_id = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, jobId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            java.util.Map<String, Object> map = new java.util.HashMap<>();
            map.put("escrow_id",     rs.getInt("escrow_id"));
            map.put("job_id",        rs.getInt("job_id"));
            map.put("client_id",     rs.getInt("client_id"));
            map.put("freelancer_id", rs.getInt("freelancer_id"));
            map.put("amount",        rs.getBigDecimal("amount"));
            map.put("status",        rs.getString("status"));
            rs.close(); ps.close(); con.close();
            return map;
        }
        rs.close(); ps.close(); con.close();
        return null;
    }
}
