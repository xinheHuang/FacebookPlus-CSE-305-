<%-- 
    Document   : newAccount
    Created on : 2015-4-30, 23:40:08
    Author     : yishuo wang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
        body {
	background-image: url(img/ice.jpg);
	background-repeat: repeat;
}
.whiteTextBackground{
    background-color: white; 
}
            
        </style>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Account page</title>
        <%String userid = (String) session.getAttribute("userid");
          if (userid == null) {

                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法

            }
          else
          { %>
    </head>
    <body>
        <form action="creditAccount" method="post">
            <table>
                <tr><td class="whiteTextBackground">Credit Card Number </td> <td><input type="text" name="Card_Num"/></td></tr>
                <tr><td class="whiteTextBackground">Name On Your Card:</td> <td> <input type="text" name="Full_Name" /></td></tr>
            </table>
            </br>
            <input type="submit" value="Create" />       &nbsp;&nbsp; &nbsp;   
            <input type="reset" value="Reset" /></br>

        </form>
        <button type="button" onclick="window.location.href = 'account.jsp'">back</button>
    </body>
     <% }%>
</html>
