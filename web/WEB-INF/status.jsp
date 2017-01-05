<%-- 
    Document   : status
    Created on : 5 Jan, 2017, 3:45:15 PM
    Author     : phaneendraN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <%@ page import="java.util.*" %>
         <%@ page import="javax.sql.*;" %>
         <%@page import="java.sql.DriverManager"%>
         <%@page import="java.sql.Connection"%>

     <% 

        java.sql.Connection con;
        java.sql.Statement s;
        java.sql.ResultSet rs,rs1;
        java.sql.PreparedStatement pst;

        con=null;
        s=null;
        pst=null;
        rs=null;

        // Remember to change the next line with your own environment 
        String url= 
        "ap-cdbr-azure-southeast-b.cloudapp.net";
        String id= "bf099cfd7e031b";
        String pass = "a085a02d";
        try{

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
           String connectionUrl = "jdbc:sqlserver://'"+url+"'.database.windows.net;"
                                   + "database=bap;"
                                   + "user=id;"
                                   + "password=Pass";
            con = DriverManager.getConnection(connectionUrl);
            out.print("Connected.<br/>");
            s=con.createStatement();
            String str=request.getParameter("nums");
            String []st=str.split(",");
            for(String str1:st)
            {
               rs=s.executeQuery("select regdno from students where regdno='"+str1+"' ");
            }
            
            while(rs.next())
            {
                
            }
           
        }
        catch(ClassNotFoundException cnfex){
        cnfex.printStackTrace();

        }
        
     %>  
    </body>
</html>
