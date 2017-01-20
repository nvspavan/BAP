<%-- 
    Document   : CheckReason
    Created on : 19 Jan, 2017, 12:29:42 PM
    Author     : Rohith Reddy
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
        
  <link rel='stylesheet prefetch' href='http://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700,900|RobotoDraft:400,100,300,500,700,900'>
<link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'>

        <link rel="stylesheet" href="css/newcss.css">
       
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:useBean id="DB" class="database.DatabaseCon"/>
        <SCRIPT type="text/javascript">
            window.history.forward();
            function noBack() { window.history.forward(); }
            function print1() {
            window.print();}

        </SCRIPT>
         <style>
                .button {
    display: block;
    width: 115px;
    height: 25px;
    background: #4E9CAF;
    padding: 10px;
    text-align: center;
    border-radius: 5px;
    color: white;
    font-weight: bold;
    
  position: fixed;
  top: 50%;
  left: 50%;
  margin-top: -50px;
  margin-left: -100px;
}

            </style>
        
    </head>
    <body  onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
        <a class="button" href="HOD_Classes.jsp">Back</a>
        <table class="module form-module" border="1">
            <tr >
                <th>ID</th>
                <th>Date</th>
                <th>Class</th>
                <th>Staff</th>
                <th>Period</th>
                <th>Reason</th>
            </tr>
        <% 
        
            Connection con=DB.getConnection();
            Statement s=con.createStatement();
            ResultSet rs=s.executeQuery("SELECT bec_period_change_reason.id,Date,year,section,Name,Reason,Period FROM bec.bec_period_change_reason join bec.bec_class on bec.bec_period_change_reason.classDetails_id=bec.bec_class.id"+
" join bec_staff on bec_period_change_reason.staff_id=bec_staff.id");
            
            
            while(rs.next()){
                out.println("<tr><td>"+rs.getString(1)+
                            "</td><td>"+rs.getString(2)+
                            "</td><td>"+rs.getString(3)+rs.getString(4)+
                            "</td><td>"+rs.getString(5)+
                            "</td><td>"+rs.getString(7)+
                            "</td><td>"+rs.getString(6)+"</td></tr>");
                
                
            }
            
        %>
        </table>
    </body>
</html>
