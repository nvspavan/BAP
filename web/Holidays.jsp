<%-- 
    Document   : Holidays
    Created on : 24 Jan, 2017, 1:49:35 PM
    Author     : Rohith Reddy
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="database.DatabaseCon" id="DB"/>
<jsp:useBean id="DS" class="dateop.DateSelection"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Holidays</title>
        <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
  
  <script>
  $(document).ready(function() {
    $("#datepicker1").datepicker();
  });
  $(document).ready(function() {
    $("#datepicker2").datepicker();
  });
  </script>
    </head>
    <body>
        <%
            if(session.getAttribute("HODID")==null){
                response.sendRedirect("index.jsp");
            }
            else{
        %>
        <form action="Holidays.jsp" method="POST">
            From Date:<input id="datepicker1" name="fromDate" />
            To Date:<input id="datepicker2" name="toDate" /><br/>
            Reason:<textarea name="Reason"></textarea>
            <input type="submit" value="Add Holidays"/>
        </form>            
        <%
                if ( "POST".equalsIgnoreCase(request.getMethod()) && (request.getRequestURI() != null && request.getRequestURI().toString().equalsIgnoreCase("/BAP/Holidays.jsp")))
                if(request.getParameter("Reason")!=null&&request.getParameter("fromDate")!=null&&request.getParameter("toDate")!=null){
                    Connection con=DB.getConnection();
                    Statement st=con.createStatement();
                    ResultSet rs=st.executeQuery("select * from bec_holidays where date between '"+DS.getSQLDateFromCal(request.getParameter("fromDate"))+"' and '"+DS.getSQLDateFromCal(request.getParameter("toDate"))+"'");
                    int count=0;
                    while(rs.next()){
                        count++;
                    }
                    DateFormat df = new SimpleDateFormat("mm/dd/yyyy");
                    DateFormat d = new SimpleDateFormat("yyyy-mm-dd");
                    try{
                    Date fromDate=df.parse(request.getParameter("fromDate"));               
                    Date toDate=df.parse(request.getParameter("toDate"));
                    
                    if(count==0){
                        while(fromDate.before(toDate)){
                            st.executeUpdate("INSERT INTO `bec`.`bec_holidays`(`Date`,`Reason`) VALUES('"+d.format(fromDate)+"','"+request.getParameter("Reason")+"')");
                            out.println(fromDate+":"+request.getParameter("Reason")+"<br/>");
                            Calendar calendar = Calendar.getInstance();
                            calendar.setTime(fromDate);
                            calendar.add(Calendar.DAY_OF_YEAR, 1);
                            fromDate = calendar.getTime();
                            Date dt=new Date();
                            calendar.setTime(dt);
                        }
                    }
                    else{
                        out.println("Already updated");
                    }
                    }
                    catch(Exception ex){
                        
                    }
                }   
                
                Connection con=DB.getConnection();
                Statement st=con.createStatement();
                ResultSet rs=st.executeQuery("select * from bec_holidays");
                out.print("Date(yyyy-mm-dd):Reason<br/>");
                while(rs.next()){
                    out.print(rs.getString(2)+":"+rs.getString(3)+"<br/>");
                }
            }
        %>
        
    </body>
</html>
