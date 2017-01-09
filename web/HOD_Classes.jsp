<%-- 
    Document   : HOD_Classes
    Created on : 8 Jan, 2017, 10:24:29 AM
    Author     : Rohith Reddy
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="database.DatabaseCon" id="DB"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CSE</title>
           <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">

  <link rel='stylesheet prefetch' href='http://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700,900|RobotoDraft:400,100,300,500,700,900'>
<link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'>

        <link rel="stylesheet" href="css/newcss.css">
        <SCRIPT type="text/javascript">
            window.history.forward();
            function noBack() { window.history.forward(); }
        </SCRIPT>
    </head>
    <body class="module form-module" onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
        <% 
            if ( "POST".equalsIgnoreCase(request.getMethod()) && (request.getRequestURI() != null && request.getRequestURI().toString().equalsIgnoreCase("/BAP/HOD_classes.jsp"))) {
                if(request.getParameter("logout")!=null){
                    session.invalidate();
                    response.sendRedirect("index.jsp");
                }
                else if(request.getParameter("classes")!=null){
                    session.setAttribute("sltClass", request.getParameter("classes"));
                    response.sendRedirect("ClassSummary.jsp");
                }
            }
            else if(session.getAttribute("HODID")==null)
                response.sendRedirect("index.jsp");
            else{
        %>
        <form method="post" action="HOD_Classes.jsp" class="module form-module">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input name="logout" type="submit" value="Logout"/>
        
            <%
                int HODID=Integer.parseInt(session.getAttribute("HODID").toString());
                Connection con=DB.getConnection();
                Statement stmt=con.createStatement();
                ResultSet rs=stmt.executeQuery("select c.id,c.year,c.section,c.coordinator_id from bec_class as c join bec_hod as h on c.Dept_Name_id=h.id where h.id="+HODID);
                while(rs.next()){
                    int id=rs.getInt(1);
                    String cls=rs.getInt(2)+rs.getString(3);
            %>
            <input type="submit" style="color: background" class="module form-module" name="classes" id="<%=id%>" value="<%=cls %>"/> 
            <%
                }
                rs.close();
                }

            %>
        </form>
    </body>
</html>
