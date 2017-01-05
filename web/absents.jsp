<%-- 
    Document   : Login
    Created on : 5 Jan, 2017, 12:07:07 PM
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
       <% 
           String uname =  request.getParameter("uname"); 
           String pwd=request.getParameter("pwd");
            if(uname.matches("staff_test") && pwd.matches("staff_test"))
            {
                out.println("successful");
            }else
            {
                out.println("not successful");
                response.sendRedirect("index.html");
                request.setAttribute("msg","not successful");
            }
       %>
       <form method="POST" action="">
           ENTER ABSENT NUMBERS:<textarea id="nums" name="nums" maxlength="10"></textarea>><br/>
           <br/>
           <input type="submit" title="submit">
       </form>  
        
    </body>
</html>
