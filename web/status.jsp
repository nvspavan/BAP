<%-- 
    Document   : status
    Created on : 5 Jan, 2017, 3:45:15 PM
    Author     : Mahidhar reddy
--%>

<%@page import="java.text.DateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <%@ page import="java.util.*" %>
         <%@ page import="javax.sql.*" %>
         <%@ page import="java.sql.*"%>
         <%@page import="java.text.SimpleDateFormat" %>
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
        /* String url= 
        "ap-cdbr-azure-southeast-b.cloudapp.net/bap";
        String id= "bf099cfd7e031b";
        String pass = "a085a02d";*/
        
        String url= 
        "localhost/bec";
        String id= "root";
        String pass = "admin";
        try{

            Class.forName("com.mysql.jdbc.Driver");
            String Url = "jdbc:mysql://"+url;      
            con = DriverManager.getConnection(Url, id, pass);
            s=con.createStatement();
            String peroid=request.getParameter("peroid");
            String str=request.getParameter("nums");
            String[] rollnostr=str.split(",");
            out.println("<b>Absents List:</b><br/>");
            for (int i = 0; i < rollnostr.length; i++) {
                int rollNO=Integer.parseInt(rollnostr[i]);
                rs=s.executeQuery("select * from bec_student where RollNo='"+rollNO+"'");
                while(rs.next()){
                    out.println("Name:"+rs.getString(2));
                    String reg_num=rs.getString(3).trim();
                    out.println("<br/>Reg_Num:"+reg_num );
                    out.println("<br/>RollNO:"+rs.getInt(4));
                    out.println("<br/>");
                    Statement stmt=con.createStatement();
                    DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
                    java.util.Date today = Calendar.getInstance().getTime();
                    int update=0;
                    try{
                        update=stmt.executeUpdate("update "+reg_num+" set p"+peroid+"=0 where Date='"+df.format(today)+"'");
                        if(update==0){
                         int insert=stmt.executeUpdate("insert into "+reg_num+"(Date,p"+peroid+") values('"+df.format(today)+"',0)");
                        }
                    }
                    catch(Exception e){
                        stmt.execute("CREATE TABLE "+reg_num+"(id int(11) NOT NULL AUTO_INCREMENT,"+
              "Date varchar(10) DEFAULT NULL,"+
              "p1 int(11) DEFAULT '2',"+
              "p2 int(11) DEFAULT '2',"+
              "p3 int(11) DEFAULT '2',"+
              "p4 int(11) DEFAULT '2',"+
              "p5 int(11) DEFAULT '2',"+
              "p6 int(11) DEFAULT '2',"+
              "p7 int(11) DEFAULT '2',"+
              "p8 int(11) DEFAULT '2',"+
              "p9 int(11) DEFAULT '2',"+
              "PRIMARY KEY (id),"+
              "UNIQUE KEY id_UNIQUE (id)"+
            ") AUTO_INCREMENT=2 DEFAULT CHARSET=utf8");
                    stmt.executeUpdate("insert into "+reg_num+"(Date,p"+peroid+") values('"+df.format(today)+"',0)");

                    }
                
                out.println("");
                }
            }
            out.println("<b>Present List:</b><br/>");
            for (int i = 0; i < rollnostr.length; i++) {
                int rollNO=Integer.parseInt(rollnostr[i]);
                rs=s.executeQuery("select * from bec_student where RollNo NOT IN("+rollNO+")");
                while(rs.next()){
                    out.println("Name:"+rs.getString(2));
                    String reg_num=rs.getString(3).trim();
                    out.print("<br/>Reg_Num:"+reg_num );
                    out.print("<br/>RollNO:"+rs.getInt(4));
                    out.print("<br/>");
                    Statement stmt=con.createStatement();
                    DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
                    java.util.Date today = Calendar.getInstance().getTime();
                    int update=0;
                    try{
                        update=stmt.executeUpdate("update "+reg_num+" set p"+peroid+"=1 where Date='"+df.format(today)+"'");
                        if(update==0){
                         int insert=stmt.executeUpdate("insert into "+reg_num+"(Date,p"+peroid+") values('"+df.format(today)+"',1)");
                        }
                    }
                    catch(Exception e){
                        stmt.execute("CREATE TABLE "+reg_num+"(id int(11) NOT NULL AUTO_INCREMENT,"+
              "Date varchar(10) DEFAULT NULL,"+
              "p1 int(11) DEFAULT '2',"+
              "p2 int(11) DEFAULT '2',"+
              "p3 int(11) DEFAULT '2',"+
              "p4 int(11) DEFAULT '2',"+
              "p5 int(11) DEFAULT '2',"+
              "p6 int(11) DEFAULT '2',"+
              "p7 int(11) DEFAULT '2',"+
              "p8 int(11) DEFAULT '2',"+
              "p9 int(11) DEFAULT '2',"+
              "PRIMARY KEY (id),"+
              "UNIQUE KEY id_UNIQUE (id)"+
            ") AUTO_INCREMENT=2 DEFAULT CHARSET=utf8");
                    stmt.executeUpdate("insert into "+reg_num+"(Date,p"+peroid+") values('"+df.format(today)+"',1)");

                    }
                }
            }
        }
        catch(ClassNotFoundException cnfex){
        cnfex.printStackTrace();
              %>
    <p1>Not Connected</p1>
      <%  
        }
catch(Exception ex){
    out.print(ex.getMessage());
}
     %>  
    </body>
</html>
