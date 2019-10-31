package org.apache.jsp;

import org.json.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.ArrayList;
import java.util.List;

public final class safeCityScrape_jsp extends org.apache.jasper.runtime.HttpJspBase
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
            out.write("<script type=\"text/javascript\" src=\"/crimeRateExtract/js/jquery.js\"></script>\n");
            out.write("<script type=\"text/javascript\" src=\"/crimeRateExtract/getFormattedPlace.js\"></script>\n");
            out.write("<script>\n");
            out.write("\n");
            out.write("    function demoFunction(str)\n");
            out.write("    {\n");
            out.write("//        console.log(str);\n");
            out.write("        getPlace(str.places, function (formattedPlaceArr) {\n");
            out.write("            console.log(formattedPlaceArr);\n");
            out.write("        });\n");
            out.write("        console.log(str);\n");
            out.write("\n");
            out.write("        var json = JSON.stringify(str);\n");
            out.write("//        console.log(json);\n");
            out.write("        $.ajax({\n");
            out.write("            url: 'http://localhost:8084/crimeRateExtract/scrapeBackend.jsp',\n");
            out.write("            type: 'POST',\n");
            out.write("            data: \"json=\" + json,\n");
            out.write("            async: false,\n");
            out.write("            success: function (result) {\n");
            out.write("                console.log(\"Success\");\n");
            out.write("            },\n");
            out.write("            error: function (error)\n");
            out.write("            {\n");
            out.write("                console.log(error);\n");
            out.write("            }\n");
            out.write("        });\n");
            out.write("    }\n");
            out.write("</script>\n");


            try {
                //url will be received from index.jsp
                String url = "";
                System.out.println("*************SafeCity.in**************");
//        url = "http://maps.safecity.in/reports/index?sw=76.085333%2C27.563696&ne=78.111541%2C29.713363&z=6";
                JSONObject json = new JSONObject();
                List<String> locs = new ArrayList<String>();
                List<String> tims = new ArrayList<String>();
                List<String> crimes = new ArrayList<String>();
                String[] typesArray = {
                        "Ogling/Facial Expressions/Staring",
                        "Stalking",
                        "Taking pictures",
                        "Catcalls/Whistles",
                        "Commenting",
                        "Indecent exposure",
                        "Touching/Groping",
                        "Sexual Invites",
                        "Rape/Sexual Assault",
                        "Poor/No Street Lighting",
                        "Chain Snatching",
                        "North East India Report",
                        "Others"
                };
                int[] pagesArray = {53, 4, 22, 54, 101, 13, 57, 23, 5, 8, 16, 2, 28};
                int[] typesIndexArray = {6, 20, 3, 1, 2, 9, 8, 10, 11, 18, 17, 19, 15};
//        System.out.println(pagesArray.length+" "+typesArray.length+" "+typesIndexArray.length);
                int pageNo, type;
                String[] check = {
                        "Dwarka Sector 8 Metro Station, Sector 8 Dwarka, Dwarka, New Delhi, Delhi 110077, India",
                        "Dispensary Paharganj"};
                String[] sol = {
                        "Dwarka",
                        "Paharganj"};

                for (int i = 0; i < 1; i++) {
                    for (int j = 1; j <= 10/*pagesArray[i]*/; j++) {
                        type = typesIndexArray[i];
                        pageNo = j;
                        url = "http://maps.safecity.in/reports/fetch_reports?sw=76.085333%2C27.563696&ne=78.111541%2C29.713363&z=6&c%5B0%5D=" + type + "&page=" + pageNo;
                        System.out.println(url);
                        Document doc = Jsoup.connect(url).get();
                        String loc, tim, crime;
                        Elements locations = doc.select(".r_location");
                        Elements times = doc.select(".r_date");

                        for (int k = 0; k < locations.size(); k++) {
                            loc = locations.get(k).text();
//                out.println("<script> getPlace('" + loc + "'); </script>");
                            for (int l = 0; l < loc.length(); l++) {
                                if (loc.charAt(l) == '(') {
//                            System.out.print("BUGGGGG");
                                    String newLoc = loc.substring(0, l);
//                            System.out.print(newLoc+"-->"+loc);
                                    for (; l < loc.length(); l++) {
                                        if (loc.charAt(l) == ')') {
                                            break;
                                        }
                                    }
                                    newLoc += loc.substring(l + 1, loc.length() - 1);
//                            System.out.print("-->" + newLoc);
//                            System.out.println();
                                    loc = newLoc;
                                }
                            }
                            for (int l = 0; l < check.length; l++) {
                                if (loc.toLowerCase().contains(check[l].toLowerCase())) {
                                    loc = sol[l];
                                    break;
                                }
                            }
//                    System.out.println(loc);
                            loc = "\"" + loc + "\"";

                            locs.add(loc);
                            tim = times.get(k).text();
                            tim = "'" + tim + "'";
                            tims.add(tim);
                            crime = "'" + typesArray[i] + "'";
                            crimes.add(crime);
                        }
                    }
                }

//Using Jsoup Library for scraping, and extracting html and css from websites
                json.accumulate("places", locs);
                json.accumulate("times", tims);
                json.accumulate("crimes", crimes);

//        System.out.println(json.toString());
                out.println("<script> demoFunction(" + json.toString() + ");</script>");

            } catch (Exception e) {
                e.printStackTrace();
                System.out.println();
            }

            out.write('\n');
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
