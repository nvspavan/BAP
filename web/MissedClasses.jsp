<%-- 
    Document   : MissedClasses
    Created on : 19 Jan, 2017, 12:45:31 PM
    Author     : Rohith Reddy
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    <jsp:useBean id="DB" class="database.DatabaseCon"/>
    <jsp:useBean id="BAP" class="BAP.BAPOP"/>
        <SCRIPT type="text/javascript">
            window.history.forward();
            function noBack() { window.history.forward(); }
            function print1() {
            window.print();}

        </SCRIPT>
        
    </head>
    <body onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
        <table border="1">
            
        <% 
            SimpleDateFormat dWF = new SimpleDateFormat("E");
            SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
            SimpleDateFormat sqlDF = new SimpleDateFormat("yyyy-mm-dd");
            Connection con=DB.getConnection();
            Statement s=con.createStatement();
            ResultSet rs=null;
            String currClass=session.getAttribute("Class").toString();
            out.print(currClass);
            rs=s.executeQuery("select * from "+currClass.charAt(0)+"CSE"+currClass.charAt(1));
            /*int lab_count=0;//if there is a lab then count is 2 otherwise count=1
            while(rs.next()){
                lab_count++;
            }
            int[][] todayclasses=new int[lab_count][10];
            //int[] todayclasses=new int[10];
            rs.beforeFirst();
            int lc=0;
            while (rs.next()) {
                for(int i=0;i<10;i++){
                    todayclasses[lc][i]=rs.getInt(i+3);
                }
                lc++;
            }
            List<Integer> labdetails=new ArrayList<Integer>();//index-0 have Batch id other 3 have period details
            String BatchQuery=" and Batch=0";
            if(lab_count==2){
                labdetails=BAP.getLabPeriods(todayclasses);
            }
            rs.beforeFirst();*/
            while(rs.next()){
                String date=rs.getString(2);
                int batch=rs.getInt(12);
                if(batch==0){
                    batch=1;
                }
                Statement st=con.createStatement();
                String Date=null,Day=null;
                try{
                    Day=dWF.format(sqlDF.parse(date));
                    Date=df.format(sqlDF.parse(date));
                }
                catch(Exception ex){}
                ResultSet r=st.executeQuery("select * from cs"+currClass+"_timetable where Day='"+Day+"' and Batch="+batch);
                while(r.next()){
                    for (int i = 4; i < 12; i++) {
                            if(r.getInt(i)!=0){
                                if(rs.getInt(i-1)==0){
                                    //if(lab_count==2&&labdetails.contains(i-3)){
                                        Statement staffS=con.createStatement();
                                        ResultSet staffRS=staffS.executeQuery("select * from bec_staff where id="+r.getInt(i));
                                        while(staffRS.next()){
                                            out.print("<tr><td>"+Date+"</td><td>"+(i-3)+"</td><td>"+staffRS.getString(2)+"</td></tr>");
                                        }
                                    /*}
                                    else if(!labdetails.contains(i-3)&&batch==1){
                                        Statement staffS=con.createStatement();
                                        ResultSet staffRS=staffS.executeQuery("select * from bec_staff where id="+r.getInt(i));
                                        while(staffRS.next()){
                                            out.print("<tr><td>"+Date+"</td><td>"+(i-3)+"</td><td>"+staffRS.getString(2)+"</td></tr>");
                                        }
                                    }
                                    else if(!labdetails.contains(i-3)&&batch==2){
                                        Statement staffS=con.createStatement();
                                        ResultSet staffRS=staffS.executeQuery("select * from bec_staff where id="+r.getInt(i));
                                        while(staffRS.next()){
                                            out.print("<tr><td>"+Date+"</td><td>"+(i-3)+"</td><td>"+staffRS.getString(2)+"</td></tr>");
                                        }
                                    }*/
                                }
                            }
                        }
                }
            }
            
        %>
        </table>
        
    </body>
</html>
