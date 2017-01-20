<%-- 
    Document   : Login
    Created on : 7 Jan, 2017, 10:24:31 AM
    Author     : Rohith Reddy
--%>

<%@page import="org.apache.tomcat.util.descriptor.web.LoginConfig"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="Login" class="Login.LoginValidation"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <% 
            String login_as="";
           if(request.getParameter("staff")!=null){
               login_as="staff";
           }else if(request.getParameter("hod")!=null){
               login_as="hod";
           }
           else{
               //response.sendRedirect("index.jsp");
           }
           String uname =  request.getParameter("uname"); 
           String pwd = request.getParameter("pwd");
          
           out.print(login_as);
           int ID=Login.LoginValidate(uname, pwd, login_as);
           if(login_as.matches("staff")){
                if(ID==0){
                    response.sendRedirect("index.jsp");
                }
                else{
                    session.setAttribute("StaffID", ID);
                    response.sendRedirect("Staff_classes.jsp");
                }
           }
           else if(login_as.matches("hod")){
                if(ID==0){
                    response.sendRedirect("index.jsp");
                }
                else{
                    session.setAttribute("HODID", ID);
                    response.sendRedirect("HOD_Classes.jsp");
                }
           }
           else{
               response.sendRedirect("index.jsp");
           }
       %>
    </body>
</html>
