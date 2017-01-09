<%-- 
    Document   : Staff_classes
    Created on : 7 Jan, 2017, 11:28:32 AM
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
<jsp:useBean id="DS" class="dateop.DateSelection"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Classes</title>
        
        <SCRIPT type="text/javascript">
            window.history.forward();
            function noBack() { window.history.forward(); }
        </SCRIPT>
    </head>
    <body onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
        <div class="form">
            <form action="Staff_classes.jsp" method="post">
        <% 
            Connection con=DB.getConnection();
            Statement st=con.createStatement();
            String todayDate="",dayOfWeek="",currDate=null;
            SimpleDateFormat dWF = new SimpleDateFormat("E");
            SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
            Date today = new Date();
            String Reason="";
            String prevDate="";
            todayDate=df.format(today);
            if ( "POST".equalsIgnoreCase(request.getMethod()) && (request.getRequestURI() != null && request.getRequestURI().toString().equalsIgnoreCase("/BAP/Staff_classes.jsp"))) {
                if(request.getParameter("currDate")!=null){
                    currDate=request.getParameter("currDate");
                    session.setAttribute("currDate", currDate);
                }
            }
            if(currDate==null)
                if(session.getAttribute("currDate")==null)
                    currDate=todayDate;
                else
                    currDate=session.getAttribute("currDate").toString();
            prevDate=DS.prevWorkingDay(todayDate);
        %>
            <input type="submit" name="currDate" value="<%=prevDate%>"/>
            <input type="submit" name="currDate" value="<%=todayDate%>"/>
            <input name="logout" type="submit" value="Logout"/>
        <%
            
            Date myDate = null;
            try{
                myDate=df.parse(currDate);
            }
            catch(Exception ex){
                myDate=null;
            }
            dayOfWeek=dWF.format(myDate);
            out.print(dayOfWeek);//Day of the Week
            out.print(currDate);//Current Selected Date
            boolean Holiday=false;
            if(dayOfWeek.equalsIgnoreCase("sun")){
                Holiday=true;
                Reason="Sunday";
            }
            ResultSet rsDt=st.executeQuery("select * from bec_holidays where Date='"+currDate+"'");
            while(rsDt.next()){
                Holiday=true;
                Reason=rsDt.getString(3);
            }
            rsDt.close();
            if(!Holiday){
                if(request.getParameter("absentsSubmit")!=null){
                    RequestDispatcher rd=getServletContext().getRequestDispatcher("/status.jsp");
                    rd.forward(request,response);
                }
                if(session.getAttribute("StaffID")==null)
                    response.sendRedirect("index.jsp");
                else{
        %>
           
            <ul class="tab-group">
                <%
                    int StaffID=Integer.parseInt(session.getAttribute("StaffID").toString());
                    ResultSet rs=st.executeQuery("SELECT d.class_name_id,d.Subject_Name,c.year,h.Dept_Name,c.section FROM bec.bec_dealingclass as d join bec.bec_class as c on d.class_name_id=c.id join bec.bec_hod as h on c.Dept_Name_id=h.id where d.staff_name_id="+StaffID+"");
                    ArrayList<String> ButtonIDs=new ArrayList<String>();
                    while(rs.next()){
                        int classid=rs.getInt(1);
                        String sub=rs.getString(2);
                        String classDet=rs.getInt(3)+rs.getString(4)+rs.getString(5);
                        ButtonIDs.add(classid+"_"+classDet);
                %>
        <li class="tab"><input type="submit" name="MyClasses" value="<%= sub+"_"+classDet %>"/></li>
                <%
                        out.print("<br/><br/>");
                    }
                    rs.close();
                    if ( "POST".equalsIgnoreCase(request.getMethod()) && (request.getRequestURI() != null && request.getRequestURI().toString().equalsIgnoreCase("/BAP/Staff_classes.jsp"))) {
                        if(request.getParameter("MyClasses")!=null){
                %>
      </ul>
       <div class="">
        <div id="signup">   	
            <div class="field-wrap">
                Choose Period:
                        <% 
                            String Class=request.getParameter("MyClasses").split("_")[1];
                            out.print(Class);
                            session.setAttribute("classDetails", request.getParameter("MyClasses"));
                            Statement stmt=con.createStatement();
                            ResultSet rs2=stmt.executeQuery("select * from cs"+Class.charAt(0)+Class.charAt(Class.length()-1)+"_timetable where Day=UPPER('"+dayOfWeek+"')");
                            int[] todayclasses=new int[10];
                            while(rs2.next()){
                                for(int i=1;i<10;i++){
                                    todayclasses[i]=rs2.getInt(i+2);
                                }
                            }
                            rs=null;
                            try{
                                rs= stmt.executeQuery("select * from "+Class+" where Date='"+currDate+"'");
                            }catch(Exception ex){
                                stmt.executeUpdate(DB.CreateClassTable(Class));
                                rs= stmt.executeQuery("select * from "+Class+" where Date='"+currDate+"'");
                            }
                            int count=0;
                            int[] periods=new int[10];
                            while(rs.next()){
                                count++;
                                for (int i = 1; i < 10; i++) {
                                    periods[i]=rs.getInt(i+2);
                                    if(periods[i]==0){
                        %>
                        <div class="checkbox">
                            <div class="tag"></div>
                            <input type="checkbox" <%if(todayclasses[i]==StaffID)out.println("checked");%> class="input-assumpte" id="input-confidencial1" name="p<%=i%>" value = "<%=i%>"><label for="input-confidencial1"><%=i%></label><br/>
                        <%
                                    }
                                }
                            }
                            rs.close();
                            if(count==0){
                                for (int i = 1; i < 10; i++) {
                                        %>
                                        <input type="checkbox" class="input-assumpte" id="input-confidencial2" name="p<%=i%>" value = "<%=i%>"><label for="input-confidencial1"><%=i%></label><br/>
                                        <%
                                    }
                                stmt.executeUpdate("insert into "+Class+"(Date) values('"+currDate+"')");
                            }
                            con.close();
                        }//if close - ButtonID
                        if(request.getParameter("logout")!=null){
                            session.invalidate();
                            response.sendRedirect("index.jsp");
                        }
                    }//IF close
                    
%>
        </div>
        <br/><br/>
           <p> Please specify absenties list in comma sepeated values</p>
           <textarea id="nums" name="nums"></textarea><br/>
           <br/>
           <input name="absentsSubmit" type="submit" title="submit">
          </div>
        </div>
      </div><!-- tab-content -->    
                <%}//else
            }
            else{
                out.print("<br/><br/>Today is Holiday. Beacuase Today is "+Reason);
            }
                %>
            </form>
        </div> <!-- /form -->
        <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
        <script src="js/index.js"></script> 
    </body>
</html>
