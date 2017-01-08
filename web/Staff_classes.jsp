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
        <% Date dt = new Date();
            SimpleDateFormat ft = new SimpleDateFormat ("dd-MM-yyyy");
            out.print(ft.format(dt));
            if(request.getParameter("absentsSubmit")!=null){
                RequestDispatcher rd=getServletContext().getRequestDispatcher("/status.jsp");
                rd.forward(request,response);
            }
            if(session.getAttribute("StaffID")==null)
                response.sendRedirect("index.jsp");
            else{
        %>
        <div class="form">
        <form action="Staff_classes.jsp" method="post">
           <input name="logout" type="submit" value="Logout"/>
            <ul class="tab-group">
            <%
                int StaffID=Integer.parseInt(session.getAttribute("StaffID").toString());
                Connection con=DB.getConnection();
                Statement st=con.createStatement();
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
                    DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
                    java.util.Date today = Calendar.getInstance().getTime();
                    String Class=request.getParameter("MyClasses").split("_")[1];
                    out.print(Class);
                    session.setAttribute("classDetails", request.getParameter("MyClasses"));
                    Statement stmt=con.createStatement();
                    rs=null;
                    try{
                        rs= stmt.executeQuery("select * from "+Class+" where Date='"+df.format(today)+"'");
                    }catch(Exception ex){
                        stmt.executeUpdate(DB.CreateClassTable(Class));
                        rs= stmt.executeQuery("select * from "+Class+" where Date='"+df.format(today)+"'");
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
                                    <input type="checkbox" class="input-assumpte" id="input-confidencial1" name="p<%=i%>" value = "<%=i%>"><label for="input-confidencial1"><%=i%></label><br/>
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
                        stmt.executeUpdate("insert into "+Class+"(Date) values('"+df.format(today)+"')");
                    }
                    con.close();
                }//if close - ButtonID
            }//IF close
            if(request.getParameter("logout")!=null){
                session.invalidate();
                response.sendRedirect("index.jsp");
            }
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
      </form>
</div> <!-- /form -->
  <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>

    <script src="js/index.js"></script>
        
            
    <%}//else%>
             
    </body>
</html>
