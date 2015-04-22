<%-- 
    Document   : user_index
    Created on : Apr 21, 2015, 11:54:44 PM
    Author     : Leon
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script type="text/javascript">
            function confirm()
            {
                alert("Create successfully");
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>My Circle</h1>

        <% String userid = request.getAttribute("userid").toString();

            String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
            String driver = "com.mysql.jdbc.Driver";
            Class.forName(driver).newInstance(); //init driver
            Connection conn = DriverManager.getConnection(dburl);
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM addedto Where User_Id=?");
            ps.setString(1, userid);
            ps.execute();
            ResultSet rs = ps.getResultSet();
            while (rs.next()) {
                String cid = rs.getString("Circle_Id");  //first time return first circle id, second time is second circle id
                PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM circle Where Id=?");
                ps1.setString(1, cid);
                ps1.execute();
                ResultSet rs1 = ps1.getResultSet();
                if (rs1.next()) {
                    out.println(rs1.getString("NAME"));
                }
                ps1.close();
            }
            out.println("</br>");
            ps.close();
        %>
        <h1>Manage My Circle</h1>
        <form action="createCircle" method="post">
            <table>
                <tr><td>Circle Name: </td> <td><input type="text" name="cname"/></td></tr>
                <tr><td>Type:</td> <td> <input type="text" name="ctype" /></td></tr>
                <input type="hidden" name="ownerId" value=<%=userid%> />
            </table>
            </br>
            <input type="submit" value="Create" /> 
        </form>
        <a href="Manage_Circle.jsp?userid=<%=userid%>">Manage my Circle</a>
    </body>
</html>