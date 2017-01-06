<%-- 
    Document   : status
    Created on : 5 Jan, 2017, 3:45:15 PM
    Author     : Mahidhar reddy
--%>

<%@page import="com.sun.imageio.plugins.common.I18N"%>
<%@page import="java.text.DateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <SCRIPT type="text/javascript">
	window.history.forward();
	function noBack() { window.history.forward(); }
       
</SCRIPT>
    </head>
    <body onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
         <%@ page import="java.util.*" %>
         <%@ page import="javax.sql.*" %>
         <%@ page import="java.sql.*"%>
         <%@page import="java.text.SimpleDateFormat" %>
         <jsp:useBean id="DB" class="database.DatabaseCon"/>
     <% 

        java.sql.Connection con=null;
        java.sql.Statement s=null;
        java.sql.ResultSet rs=null,rs1=null;
        java.sql.PreparedStatement pst=null;

        // Remember to change the next line with your own environment 
        /* String url= 
        "ap-cdbr-azure-southeast-b.cloudapp.net/bap";
        String id= "bf099cfd7e031b";
        String pass = "a085a02d";*/
        DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
        java.util.Date today = Calendar.getInstance().getTime();
        try{   
            String Class="4CSEA";
            con = DB.getConnection();
            s=con.createStatement();
            String str=request.getParameter("nums");
            String[] rollnostr=str.split(",");
            ArrayList<Integer> periodlist=new ArrayList <Integer>();
            out.print("Selected Periods:");
            for (int i = 1; i < 10; i++) {
                try{
                    periodlist.add(Integer.parseInt(request.getParameter("p"+i)));
                    out.print(Integer.parseInt(request.getParameter("p"+i))+",");
                    }
                catch(Exception ex){
                    
                }
            }
            Integer[] periods = periodlist.toArray(new Integer[periodlist.size()]);
            for (int i = 0; i < periods.length; i++) {
                out.print(periods[i]+",");
                    s.executeUpdate("update "+Class+" set p"+periods[i]+"=1 where Date='"+df.format(today)+"'");
            }
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
                    int update=0;
                    try{
                        for (int j  = 0; j < periods.length; j++) {
                            update=stmt.executeUpdate("update "+reg_num+" set p"+periods[j]+"=0 where Date='"+df.format(today)+"'");
                            if(update==0){
                                int insert=stmt.executeUpdate("insert into "+reg_num+"(Date,p"+periods[j]+") values('"+df.format(today)+"',0)");
                            }
                        }
                    }
                    catch(Exception e){
                        stmt.execute(DB.getCreateStmt(reg_num));
                        stmt.execute("insert into "+reg_num+"(Date) values('"+df.format(today)+"')");
                        for (int j  = 0; j < periods.length; j++) {
                            stmt.executeUpdate("update "+reg_num+" set p"+periods[j]+"=0 where Date='"+df.format(today)+"'");
                        }
                    }
                out.println("");
                }
            }
            out.println("<b>Present List:</b><br/>");
            String rollnos="";
            for (int i = 0; i < rollnostr.length; i++) {
                if(i!=rollnostr.length-1)
                    rollnos+=rollnostr[i]+",";
                else
                    rollnos+=rollnostr[i];
                int rollNO=Integer.parseInt(rollnostr[i]);
            }
                out.print(rollnos);
                rs=s.executeQuery("select * from bec_student where RollNo NOT IN("+rollnos+")");
                while(rs.next()){
                    out.println("Name:"+rs.getString(2));
                    String reg_num=rs.getString(3).trim();
                    out.print("<br/>Reg_Num:"+reg_num );
                    out.print("<br/>RollNO:"+rs.getInt(4));
                    out.print("<br/>");
                    Statement stmt=con.createStatement();
                    int update=0;
                    try{
                        for (int j  = 0; j < periods.length; j++) {
                            update=stmt.executeUpdate("update "+reg_num+" set p"+periods[j]+"=1 where Date='"+df.format(today)+"'");
                            if(update==0){
                             int insert=stmt.executeUpdate("insert into "+reg_num+"(Date,p"+periods[j]+") values('"+df.format(today)+"',1)");
                            }
                        }
                    }
                    catch(Exception e){
                        stmt.execute(DB.getCreateStmt(reg_num));
                        stmt.execute("insert into "+reg_num+"(Date) values('"+df.format(today)+"')");
                    for (int j  = 0; j < periods.length; j++) {
                            stmt.executeUpdate("update "+reg_num+" set p"+periods[j]+"=1 where Date='"+df.format(today)+"'");
                        }
                    }
                }
            }
catch(Exception ex){
    out.print(ex.getMessage());
}
     %>  
    </body>
</html>
