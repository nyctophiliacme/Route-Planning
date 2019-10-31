/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * @author PRANSH
 */
public class db_result {

    public static ResultSet get_db(Connection dbc) {
        ResultSet rs = null;
        String sql;
        PreparedStatement pst;
        try {
            sql = "select * from master_crime_data ";
            pst = dbc.prepareStatement(sql);
            rs = pst.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
            String sqlMessage = e.getMessage();
            System.err.println("Message from Database:" + sqlMessage);
        }
        return rs;
    }

    public static ResultSet get_dateId(Connection dbc) {
        ResultSet rs = null;
        String sql;
        PreparedStatement pst;
        try {
            sql = "select dateTime,id from master_crime_data ";
            pst = dbc.prepareStatement(sql);
            rs = pst.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
            String sqlMessage = e.getMessage();
            System.err.println("Message from DateTime:" + sqlMessage);
        }
        return rs;
    }

    public static ResultSet get_mapping(Connection dbc, int x) {
        ResultSet rs = null;
        String sql;
        PreparedStatement pst;
        try {
            sql = "select rating from crime_mapping, master_crime_data where master_crime_data.id = " + x + " and master_crime_data.crime=crime_mapping.crime";
            pst = dbc.prepareStatement(sql);
            rs = pst.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
            String sqlMessage = e.getMessage();
            System.err.println("Message form Mapping: " + sqlMessage);
        }
        return rs;
    }

    public static ResultSet get_places(Connection dbc) {
        ResultSet rs = null;
        PreparedStatement pst;
        String sql;
        try {
            sql = "select place from master_crime_data";
            pst = dbc.prepareStatement(sql);
            rs = pst.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
            String sqlMessage = e.getMessage();
            System.err.println("Message from Places:" + sqlMessage);
        }
        return rs;
    }

    public static ResultSet getCount(Connection dbc) {
        ResultSet rs = null;
        PreparedStatement pst;
        String sql;
        try {
            sql = "select place,count(*) from master_crime_data group by place";
            pst = dbc.prepareStatement(sql);
            rs = pst.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
            String sqlMessage = e.getMessage();
            System.err.println("Message from GetCount:" + sqlMessage);
        }

        return rs;
    }
}
