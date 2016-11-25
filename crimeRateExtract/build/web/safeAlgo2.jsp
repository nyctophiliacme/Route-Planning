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
    ResultSet rs = database.db_result.get_db(con);
    int id, w, j, mx = -1;
    Timestamp ts;
    double temp, rate, h, l, offset, mx_rate = -1.0;
    List<Double> arr = new ArrayList<Double>();
    List<Double> z = new ArrayList<Double>();
    j = 1;
    ResultSet cnt = database.db_result.getCount(con);
    Map<String, Integer> map = new TreeMap<String, Integer>();
    Map<String, Double> rate_map = new TreeMap<String, Double>();
    String place, tmp_pl = "";
    int freq;
    while (cnt.next()) {
        place = cnt.getString("place");
//        System.out.println("******"+place);
        freq = cnt.getInt("count(*)");
        map.put(place, freq);
        if (mx < freq) {
            mx = freq;
        }
    }
    while (rs.next()) {
        ts = rs.getTimestamp("dateTime");
        id = rs.getInt("id");
        tmp_pl = rs.getString("place");
        ResultSet mp = database.db_result.get_mapping(con, id);
        mp.next();
        w = mp.getInt("rating");
//        tmp_pl = mp.getString("place");
        long t = (cur.getTime() - ts.getTime()) / (60 * 60 * 1000 * 24) - 60;
//        System.out.println(j + "\t" + t);
//        j++;

//        System.out.println(id + "-->" + ts + "-->" + w + "-->" + t);
        temp = (double) w / (double) t;
//        if(id >10) break;
        arr.add(temp);

        if (temp > (double) 2.0 / 45) {
            h = (double) 1.0;
            l = (double) 2.0 / 45;
            offset = 4.5;
        } else if (temp > (double) 1.0 / 45) {
            h = (double) 2.0 / 45;
            l = (double) 1.0 / 45;
            offset = 4.0;
        } else if (temp > (double) 1.0 / 90) {
            h = (double) 1.0 / 45;
            l = (double) 1.0 / 90;
            offset = 3.5;
        } else if (temp > (double) 1.0 / 135) {
            h = (double) 1.0 / 90;
            l = (double) 1.0 / 135;
            offset = 3.0;
        } else if (temp > (double) 1.0 / 180) {
            h = (double) 1.0 / 135;
            l = (double) 1.0 / 180;
            offset = 2.5;
        } else if (temp > (double) 1.0 / 270) {
            h = (double) 1.0 / 180;
            l = (double) 1.0 / 270;
            offset = 2.0;
        } else if (temp > (double) 1.0 / 360) {
            h = (double) 1.0 / 270;
            l = (double) 1.0 / 360;
            offset = 1.5;
        } else if (temp > (double) 1.0 / 540) {
            h = (double) 1.0 / 360;
            l = (double) 1.0 / 540;
            offset = 1.0;
        } else if (temp > (double) 1.0 / 720) {
            h = (double) 1.0 / 540;
            l = (double) 1.0 / 720;
            offset = 0.5;
        } else {
            h = (double) 1.0 / 720;
            l = 0.0;
            offset = 0.0;
        }
        rate = offset + (temp - l) / (h - l) * 0.5;
        z.add(rate);
        if (rate_map.containsKey(tmp_pl)) {
            rate_map.put(tmp_pl, rate + rate_map.get(tmp_pl));
        } else {
            rate_map.put(tmp_pl, rate);
        }
//        sum += temp;
//        System.out.println(id + "-->" + temp + "-->" + w + "-->" + t);
        if (mx_rate < rate_map.get(tmp_pl)) {
            mx_rate = rate_map.get(tmp_pl);
        }
    }

    System.out.println("*********************" + mx);

    double min4 = 33.87178, min3 = 68.13789, min2 = 110.64237, min1 = 148.48352,min0=162.43896;
    for (Map.Entry<String, Double> entry
            : rate_map.entrySet()) {
        tmp_pl = entry.getKey();
        rate = entry.getValue();
        freq = map.get(tmp_pl);
//        System.out.println("### " + tmp_pl + " " + freq);
//  
        double cur_rate;
        if (freq > 400) {
            double t = 163.4 + (mx_rate - rate) / mx_rate * 4;
            cur_rate = t + (t - min0) * 15 + ((t * 1000) % 10) * 6 + ((t * 10000) % 10) * 4 + ((t * 100000) % 10) * 0.1;
//            System.out.println( tmp_pl + "----->" + cur_rate);
        } else if (freq > 200) {
            double t = 146.4 + (mx_rate - rate) / mx_rate * 6;
            cur_rate = t + (t - min1) * 15 + ((t * 1000) % 10) * 6 + ((t * 10000) % 10) * 4 + ((t * 100000) % 10) * 0.1;
//            System.out.println( tmp_pl + "----->" + cur_rate);
        } else if (freq > 100) {
            double t = 106.4 + (mx_rate - rate) / mx_rate * 6;
            cur_rate = t + (t - min2) * 15 + ((t * 1000) % 10) * 6 + ((t * 10000) % 10) * 4 + ((t * 100000) % 10) * 0.1;
//            System.out.println(tmp_pl + "----->" + cur_rate);
        } else if (freq > 50) {
            double t = 63.4 + (mx_rate - rate) / mx_rate * 8;
            cur_rate = t + (t - min3) * 15 + ((t * 1000) % 10) * 4 + ((t * 10000) % 10) * 2 + ((t * 100000) % 10) * 0.1;
//            System.out.println( tmp_pl + "----->" + cur_rate);
        } else {
            double t = 24.3 + (mx_rate - rate) / mx_rate * 10;
            cur_rate = t + (t - min4) * 15 + ((t * 1000) % 10) * 4 + ((t * 10000) % 10) * 2 + ((t * 100000) % 10) * 0.1;
//            System.out.println(tmp_pl + "----->" + cur_rate);
        }
//        rate_map.put(tmp_pl,0.5*(rate/freq + freq/mx*5));
        rate_map.put(tmp_pl, cur_rate);
//        System.out.println(tmp_pl + "----->" + rate_map.get(tmp_pl));
    }
    PreparedStatement st = null;
    double placeRating;
    String pl = "";
    for (Map.Entry<String, Double> entry
            : rate_map.entrySet()) {
        pl = entry.getKey();
         System.out.println(pl + "---->" + rate_map.get(pl));
        placeRating = rate_map.get(pl);
        String sql = "insert into safetyindex(place,value) values(?,?);";
        st = con.prepareStatement(sql);
        st.setString(1, pl);
        st.setDouble(2, placeRating);
        st.executeUpdate();
    }
%>