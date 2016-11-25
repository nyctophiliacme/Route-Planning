<%-- 
    Document   : safeAlgorithm
    Created on : Nov 17, 2016, 4:36:09 PM
    Author     : PRANSH
--%>

<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.temporal.TemporalAccessor"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.Date"%>
<!DOCTYPE html>
<%
    Date date = new Date();
    long time = date.getTime();
    Timestamp cur = new Timestamp(time);
//    System.out.println(cur);

    Connection con = null;
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/perimeterred", "root", "root");
    if (con != null) {
        System.out.println("Connection Successful");
    }
    ResultSet rs = database.db_result.get_dateId(con);
    int id, w;
    Timestamp ts;
    double temp, sum = 0, avg = 0, sum2 = 0, standard_deviation;
    List<Double> arr = new ArrayList<Double>();
    List<Double> z = new ArrayList<Double>();
    while (rs.next()) {
        ts = rs.getTimestamp("dateTime");
        id = rs.getInt("id");
        ResultSet mp = database.db_result.get_mapping(con, id);
        mp.next();
        w = mp.getInt("rating");
        long t = (cur.getTime() - ts.getTime()) / (60 * 60 * 1000);
//        System.out.println(id + "-->" + ts + "-->" + w + "-->" + t);
        temp = (double) w / Math.sqrt(t);
//        if(id >10) break;
        arr.add(temp);
        sum += temp;
//        System.out.println(id + "-->" + temp + "-->" + w + "-->" + t);
    }
    avg = sum / arr.size();
//    System.out.println(sum+"  "+avg+"  "+"  "+arr.size());
    for (double ai : arr) {
        sum2 += (ai - avg) * (ai - avg);
    }
    standard_deviation = Math.sqrt(sum2);
    for (double ai : arr) {
        temp = (ai - avg) / standard_deviation;
        z.add(temp);
//        System.out.println(temp);
    }
    ResultSet ps = database.db_result.get_places(con);
    String place;
    int i = 0;
    while (ps.next()) {
        place = ps.getString("place");
        System.out.println(i+1+"   "+place + "     " + z.get(i));
        i++;
    }
    Map<String, Double> map = new TreeMap<String, Double>();
    ps = database.db_result.get_places(con);
    i = 0;
    while (ps.next()) {
        place = ps.getString("place");
        Double tm = map.get(place);
        if(tm !=null)
        {
            map.put(place,map.get(place) + z.get(i));
        }
        else
        {
            map.put(place,z.get(i));
        }
//        map.put(place, (double)map.get(place) + z.get(i));
        i++;
    }

    Set set = map.entrySet();
    Iterator it = set.iterator();
    int count= 0;
    while (it.hasNext()) {
        count++;
        Map.Entry me = (Map.Entry) it.next();
//        System.out.println(me.getKey() + ": " + me.getValue());
    }
//    System.out.println("********Count "+count);
%>