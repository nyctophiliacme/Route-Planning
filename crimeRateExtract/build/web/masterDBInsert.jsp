<%-- 
    Document   : safeAlgorithm
    Created on : Nov 17, 2016, 4:36:09 PM
    Author     : PRANSH
--%>

<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.temporal.TemporalAccessor"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.Date"%>
<!DOCTYPE html>
<%
    SimpleDateFormat format;
    Date parsed;
    Connection con = null;
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/perimeterred", "root", "root");
    if (con != null) {
        System.out.println("Connection successful");
    }
    ResultSet we = database.db_result.get_db(con);
    format = new SimpleDateFormat("HH:mm MMM dd, yyyy");
    String place, crime, dateTime;
    int id;
    while (we.next()) {
        id = we.getInt("id");
        place = we.getString("place");
        crime = we.getString("crime");
        dateTime = we.getString("time");
        parsed = format.parse(dateTime);
//        java.sql.Date dateOfCrime = new java.sql.Date(parsed.getTime());
        Timestamp ts = new Timestamp(parsed.getTime());
        
        System.out.println(id + "-->" + place + "-->" + crime + "-->" +ts+ "-->");
        PreparedStatement st = null;
        String sql = "insert into master_crime_data(place,dateTime,crime) values(?,?,?);";
        st = con.prepareStatement(sql);
        st.setString(1, place);
        st.setTimestamp(2, ts);
        st.setString(3, crime);
        st.executeUpdate();

    }


%>