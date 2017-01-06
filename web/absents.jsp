<%-- 
    Document   : Login
    Created on : 5 Jan, 2017, 12:07:07 PM
    Author     : Mahidhar reddy
    Staff 
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
       <% 
           String uname =  request.getParameter("uname"); 
           String pwd = request.getParameter("pwd");
            if(uname.matches("staff_test") && pwd.matches("staff_test"))
            {
                out.println("Login successful");
            }else
            {
                out.println("not successful");
                response.sendRedirect("index.html");
                request.setAttribute("msg","not successful");
            }
       %>
       <form method="POST" action="status.jsp">
           <% Date dt = new Date();
                SimpleDateFormat ft = 
                new SimpleDateFormat ("dd-MM-yyyy");
                out.print(ft.format(dt));
           %><br/><br/>
           Choose Peroid:<select id = "peroids" name="peroids"
    multiple = "multiple"
    size = "3">
   <option value = "1">1</option>
   <option value = "2">2</option>
   <option value = "3">3</option>
   <option value = "4">4</option>
   <option value = "5">5</option>
   <option value = "6">6</option>
   <option value = "7">7</option>
   <option value = "8">8</option>
   <option value = "9">9</option>
  </select><br/><br/>
           
           ENTER ABSENT NUMBERS:<textarea id="nums" name="nums"></textarea><br/>
           <br/>
           <input type="submit" title="submit">
       </form>  
        
    </body>
</html>
