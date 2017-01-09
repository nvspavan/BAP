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
        
        Connection con=null;
        Statement s=null;
        ResultSet rs=null,rs1=null;
        java.sql.PreparedStatement pst=null;
        DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
        java.util.Date today = Calendar.getInstance().getTime();
        try{ 
            int StaffID=Integer.parseInt(session.getAttribute("StaffID").toString());
            String[] classDetails=session.getAttribute("classDetails").toString().split("_");
            String Class=classDetails[1];
            int ClassID=0;
            out.print(Class);
            con = DB.getConnection();
            s=con.createStatement();
            int year=Integer.parseInt(Class.valueOf(Class.charAt(0)));
            ResultSet r=s.executeQuery("select * from bec_class where year="+year+" and dept_Name_id=1 and section='"+Class.charAt(Class.length()-1)+"'");
            while(r.next()){
                ClassID=r.getInt(1);
            }
            String str=request.getParameter("nums");
            String[] rollnostr=str.split(",");
            ArrayList<Integer> periodlist=new ArrayList <Integer>();
            out.print("Selected Periods:");
            for (int i = 1; i < 10; i++) {
                try{
                    periodlist.add(Integer.parseInt(request.getParameter("p"+i)));
                    }
                catch(Exception ex){
                    
                }
            }
            Integer[] periods = periodlist.toArray(new Integer[periodlist.size()]);
            for (int i = 0; i < periods.length; i++) {
                out.print(periods[i]+",");
                    s.executeUpdate("update "+Class+" set p"+periods[i]+"="+StaffID+" where Date='"+df.format(today)+"'");
            }
            out.println("<br/><b>Absents List:</b><br/>");
            %>
            <table border="1">
                <tr>
                    <th>Name</th>
                    <th>Reg_Num</th>
                    <th>Roll No</th>
                </tr>
            <%
            for (int i = 0; i < rollnostr.length; i++) {
                int rollNO=Integer.parseInt(rollnostr[i]);
                rs=s.executeQuery("select * from bec_student where RollNo='"+rollNO+"' and classDetails_id="+ClassID);
                while(rs.next()){
                    out.println("<tr><td>"+rs.getString(2)+"</td>");
                    String reg_num=rs.getString(3).trim();
                    out.println("<td>"+reg_num+"</td>");
                    out.println("<td>"+rs.getInt(4)+"</td></tr>");
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
                rs.close();
            }
            %>
                </table><b>Present List:</b><br/>
                <table border='1'>
                    <tr>
                        <th>Name</th>
                        <th>Reg_Num</th>
                        <th>Roll No</th>
                    </tr>
            <%
            String rollnos="";
            for (int i = 0; i < rollnostr.length; i++) {
                if(i!=rollnostr.length-1)
                    rollnos+=rollnostr[i]+",";
                else
                    rollnos+=rollnostr[i];
                int rollNO=Integer.parseInt(rollnostr[i]);
            }
            rs=s.executeQuery("select * from bec_student where RollNo NOT IN("+rollnos+") and classDetails_id="+ClassID);
            while(rs.next()){
                out.println("<tr><td>"+rs.getString(2)+"</td>");
                String reg_num=rs.getString(3).trim();
                out.println("<td>"+reg_num+"</td>");
                out.println("<td>"+rs.getInt(4)+"</td></tr>");
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
            rs.close();
            con.close();
        }
        catch(Exception ex){
            out.print(ex.getMessage());
        } finally{
            
        }
     %>
     </table>
    </body>
</html>
