/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * @author PRANSH
 */
package database_result;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class master {
    public static ResultSet get_val(Connection dbc, String x) {
        ResultSet rs = null;
        String sql;
        PreparedStatement pst;
        try {
            sql = "select value from safetyindex where place like \"" + x + "\"";
            pst = dbc.prepareStatement(sql);
            rs = pst.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
            String sqlMessage = e.getMessage();
            System.err.println("Message from master:" + sqlMessage);
        }
        return rs;
    }
}
