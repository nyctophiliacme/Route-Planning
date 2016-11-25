<%-- 
    Document   : scrapeBackend
    Created on : Nov 11, 2016, 10:00:25 PM
    Author     : PRANSH
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/plain" pageEncoding="UTF-8"%>
<%@page import = "com.google.gson.Gson"%>
<%@page import = "DataPackage.*" %>
<%@page import= "java.util.List"%>

<%
    String str = request.getParameter("json");
    Data data = new Gson().fromJson(str, Data.class);
//    out.println(data);
//    out.println(data.getPlace_name());
    List<String> places = data.getPlaces();
    List<String> crimes = data.getCrimes();
    List<String> times = data.getTimes();

    Connection con = null;
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/perimeterred", "root", "root");
    if (con != null) {
        System.out.println("Connection successful");
    }

    String place, crime, time;
    for (Iterator<String> pt = places.iterator(), ct = crimes.iterator(), tt = times.iterator(); pt.hasNext();) {
        place = pt.next();
        crime = ct.next();
        time = tt.next();
        System.out.println(place + " " + time + " " + crime);

        PreparedStatement st = null;
        String sql = "insert into place_crime_data(place,time,crime) values(?,?,?);";
        st = con.prepareStatement(sql);
        st.setString(1, place);
        st.setString(2, time);
        st.setString(3, crime);
        st.executeUpdate();
    }


%>

