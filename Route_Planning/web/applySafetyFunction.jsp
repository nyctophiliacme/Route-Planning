<%-- 
    Document   : applySafetyFunction
    Created on : Nov 1, 2016, 6:20:54 PM
    Author     : PRANSH
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/plain" pageEncoding="UTF-8"%>
<%@page import = "com.google.gson.Gson"%>
<%@page import = "DataPackage.*" %>
<%@page import= "java.util.List"%>
<%
    String str = request.getParameter("jsonPlaces");
    Data data = new Gson().fromJson(str, Data.class);
//    out.println(data);
//    out.println(data.getPlace_name());
    List<String> places = data.getPlace_name();
    Connection dbc = null;
    double value = 0, finalVal = 0;
    int total = places.size();
    int ans, avg;
    Class.forName("com.mysql.jdbc.Driver");
    dbc = DriverManager.getConnection("jdbc:mysql://localhost:3306/perimeterred", "root", "root");
    if (dbc != null) {
        System.out.println("Connection successful");
    }
    for (String place : places) {
        ResultSet res = database_result.master.get_val(dbc, place);
        value = 0;
        while (res.next()) {
            value = res.getDouble("value");
            System.out.println(place + "-->" + value);
        }
        finalVal += value;
        if (value == 0) {
            total--;
//            System.out.println("--------->" + value);
        }
//        out.println(place+"  "+value);

    }
    if(total!=0)
    {
        avg = (int) finalVal / total;
    }
    else
    {
        avg = 85;
    }
    System.out.println("****************" + finalVal + "   " + total + "   " + avg);
    int val1 = 70;
    int val2 = 80;
    int val3 = 110;
    int val4 = 150;
    ans = 2;
    if (avg < val1) {
        ans = 1;
    } else if (avg >= val1 && avg < val2) {
        ans = 2;
    } else if (avg >= val2 && avg < val3) {
        ans = 3;
    } else if (avg >= val3 && avg < val4) {
        ans = 4;
    } else {
        ans = 5;
    }
    out.println(ans);
%>
