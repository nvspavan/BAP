<%-- 
    Document   : Report
    Created on : 18 Jan, 2017, 9:48:32 AM
    Author     : Rohith Reddy
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<jsp:useBean id="DB" class="database.DatabaseCon"/>
<jsp:useBean id="BAP" class="BAP.BAPOP"/>
<jsp:useBean id="DS" class="dateop.DateSelection"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
<head>
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
<SCRIPT type="text/javascript">
            window.history.forward();
            function noBack() { window.history.forward(); }
            function print1() {
            window.print();}

        </SCRIPT>
        
    </head>
    <body onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
        <a href="Staff_classes.jsp">Back</a>
        <a href="MissedClasses.jsp">Missed Classes</a>
    <%
        Connection con=DB.getConnection();
        Statement stmt=con.createStatement();
        ResultSet rs=null;
        String currClass=session.getAttribute("Class").toString();
        String fromDate=DS.getSQLDateFromCal(request.getParameter("fromDate"));
        String toDate=DS.getSQLDateFromCal(request.getParameter("toDate"));
        
    %>
    <h1>Coordinating Class:<%=currClass%></h1>
    
    <form action="CoReport.jsp" method="post">
        Form Date:<input id="datepicker1" name="fromDate" value="<%=(request.getParameter("fromDate")==null)?new String():request.getParameter("fromDate")%>"/>
        TO Date:<input id="datepicker2" name="toDate" value="<%=(request.getParameter("toDate")==null)?new String():request.getParameter("toDate")%>"/>
        <input type="submit" value="submit"/>
        <%
            if("POST".equalsIgnoreCase(request.getMethod()) && (request.getRequestURI() != null && request.getRequestURI().toString().equalsIgnoreCase("/BAP/CoReport.jsp")))
            if(request.getParameter("fromDate")==null){
        %>      <script type="text/javascript">
                    alert("Please Select From Date");
                </script> 
        <%
            }
            else if(request.getParameter("toDate")==null){
        %>      <script type="text/javascript">
                    alert("Please Select To Date");
                </script> 
        <%
            }
            else if(request.getParameter("fromDate")!=null && request.getParameter("toDate")!=null){            
        %>
        <%@include file="ClassReport.jsp" %>
        <%}%>
    </form>
</body>
</html>