<%-- 
    Document   : advertisement
    Created on : 2015-5-4, 10:53:54
    Author     : Leon
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <% String userid = (String) session.getAttribute("userid");
            String type = (String) session.getAttribute("type");
            if (userid == null) {

                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法

            }
            if (!type.equals("1")) {
                out.println("<script language=\"JavaScript\">alert(\"access deny！\");self.location='user_index.jsp';</script>");
            } else {
                String itemname = request.getParameter("item_name");
                String uname = request.getParameter("username");
                String fname = request.getParameter("fname");
                String lname = request.getParameter("lname");
                if (itemname.equals("")) {
                    itemname = "%";
                }
                if (uname.equals("")) {
                    uname = "%";
                }
                if (fname.equals("")) {
                    fname = "%";
                }
                if (lname.equals("")) {
                    lname = "%";
                }
                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);
                PreparedStatement ps = conn.prepareStatement("SELECT s.* FROM sale s,advertisement a ,user u ,person p Where a.id=s.advertisement and u.id=p.id and s.user=u.id and a.item_name like ? and p.last_name like ? and p.first_name like ? and u.username like ?");
             //   out.println(itemname+" "+lname+" "+fname+" "+uname);
                ps.setString(1, itemname);
                ps.setString(2, lname);
                ps.setString(3, fname);
                ps.setString(4, uname);

                ps.execute();
                ResultSet rs = ps.getResultSet();


        %>
    </head>
    <body>
        <h1>Transactions</h1>

        <table border="1">
            <tr>

                <td>Ad_Id</td>
                <td>Date</td>
                <td>Number of Units</td>

                <td>User_Id</td>
                <td>Account Number</td>

            </tr>
            <%              while (rs.next()) {


            %>
            <tr>

                <td><%=rs.getString("advertisement")%></td>
                <td><%=rs.getString("date")%></td>
                <td><%=rs.getString("number_of_units")%></td>
                <td><%=rs.getString("user")%></td>
                <td><%=rs.getString("account")%></td>

                <%
                    }
                %>
        </table>

        <br>
        <br>
        <br>
        <button type="button" onclick="window.location.href = 'manager_page.jsp'">back</button>
    </body>
    <%
            ps.close();
            conn.close();
        }
    %>

</html>