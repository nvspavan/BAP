<%-- 
    Document   : ClassSummary.jsp
    Created on : 8 Jan, 2017, 12:23:15 PM
    Author     : Rohith Reddy
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="DB" class="database.DatabaseCon"/>
<!DOCTYPE html>
<%
    String currClass="";
    if(session.getAttribute("sltClass")==null){
        response.sendRedirect("HOD_Classes.jsp");
    }
    else{
        currClass=session.getAttribute("sltClass").toString();
    }
    Connection con=DB.getConnection();
    Statement stmt=con.createStatement();
    //ResultSet rs=stmt.executeQuery("select * from bec_")
%>
<html xmlns:h="http://java.sun.com/jsf/html" xmlns:f="http://java.sun.com/jsf/core">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=currClass%></title>
        <SCRIPT type="text/javascript">
                window.history.forward();
                function noBack() { window.history.forward(); }
        </SCRIPT>
    </head>
    <body onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
        <%=currClass%>
        <table>
            <tr>
                <%
                    
                %>
            </tr>
        </table>

        
    </body>
</html>
