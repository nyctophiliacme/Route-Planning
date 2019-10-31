package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.util.*;

public final class safeAlgorithm_jsp extends org.apache.jasper.runtime.HttpJspBase
        implements org.apache.jasper.runtime.JspSourceDependent {

    private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

    private static java.util.List<String> _jspx_dependants;

    private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

    public java.util.List<String> getDependants() {
        return _jspx_dependants;
    }

    public void _jspService(HttpServletRequest request, HttpServletResponse response)
            throws java.io.IOException, ServletException {

        PageContext pageContext = null;
        HttpSession session = null;
        ServletContext application = null;
        ServletConfig config = null;
        JspWriter out = null;
        Object page = this;
        JspWriter _jspx_out = null;
        PageContext _jspx_page_context = null;

        try {
            response.setContentType("text/html;charset=UTF-8");
            pageContext = _jspxFactory.getPageContext(this, request, response,
                    null, true, 8192, true);
            _jspx_page_context = pageContext;
            application = pageContext.getServletContext();
            config = pageContext.getServletConfig();
            session = pageContext.getSession();
            out = pageContext.getOut();
            _jspx_out = out;
            _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

            out.write("\n");
            out.write("\n");
            out.write("\n");
            out.write("\n");
            out.write("\n");
            out.write("\n");
            out.write("\n");
            out.write("\n");
            out.write("\n");
            out.write("\n");
            out.write("\n");
            out.write("\n");
            out.write("\n");
            out.write("\n");
            out.write("\n");
            out.write("<!DOCTYPE html>\n");

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
                temp = (double) w / t;
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
//        System.out.println(place + "     " + z.get(i));
                i++;
            }
            Map<String, Double> map = new TreeMap<String, Double>();
            ps = database.db_result.get_places(con);
            i = 0;
            while (ps.next()) {
                place = ps.getString("place");
                Double tm = map.get(place);
                if (tm != null) {
                    map.put(place, map.get(place) + z.get(i));
                } else {
                    map.put(place, z.get(i));
                }
//        map.put(place, (double)map.get(place) + z.get(i));
                i++;
            }

            Set set = map.entrySet();
            Iterator it = set.iterator();
            int count = 0;
            while (it.hasNext()) {
                count++;
                Map.Entry me = (Map.Entry) it.next();
                System.out.println(me.getKey() + ": " + me.getValue());
            }
            System.out.println("********Count " + count);

        } catch (Throwable t) {
            if (!(t instanceof SkipPageException)) {
                out = _jspx_out;
                if (out != null && out.getBufferSize() != 0)
                    out.clearBuffer();
                if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
                else throw new ServletException(t);
            }
        } finally {
            _jspxFactory.releasePageContext(_jspx_page_context);
        }
    }
}
