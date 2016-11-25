<%-- 
    Document   : safeCityScrape
    Created on : Nov 6, 2016, 5:48:31 PM
    Author     : PRANSH
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import= "java.util.List"%>
<%@page import= "org.json.JSONObject"%>
<script type="text/javascript" src="/crimeRateExtract/js/jquery.js"></script>
<script type="text/javascript" src="/crimeRateExtract/getFormattedPlace.js"></script>
<script>

    function demoFunction(str)
    {
//        console.log(str);
        getPlace(str.places, function (formattedPlaceArr) {
            console.log(formattedPlaceArr);
        });
        console.log(str);

        var json = JSON.stringify(str);
//        console.log(json);
        $.ajax({
            url: 'http://localhost:8084/crimeRateExtract/scrapeBackend.jsp',
            type: 'POST',
            data: "json=" + json,
            async: false,
            success: function (result) {
                console.log("Success");
            },
            error: function (error)
            {
                console.log(error);
            }
        });
    }
</script>
<%

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

        for (int i = 0; i < 1; i++) //type
        {
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
%>
