<%-- 
    Document   : Circle_page
    Created on : 2015-4-22, 20:15:13
    Author     : 鑫河
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <% String userid = (String) session.getAttribute("userid");
            String cid = (String) session.getAttribute("cid");
            if (userid == null) {

                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法

            } else if (cid == null) {
                out.println(cid);
                out.println("<script language=\"JavaScript\">alert(\"no such a circle！\");self.location='index.html';</script>"); //注意该方法的写法
            } else {
                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);
                PreparedStatement ps;
                boolean isowner;
                ps = conn.prepareStatement("SELECT * FROM owns Where User_Id=? and Circle_Id=?");
                ps.setString(1, userid);
                ps.setString(2, cid);
                ps.execute();
                ResultSet rs = ps.getResultSet();
                if (rs.next()) {
                    isowner = true;
                } else {
                    isowner = false;
                }
                ps = conn.prepareStatement("SELECT * FROM addedto Where User_Id=? and Circle_Id=?");
                ps.setString(1, userid);
                ps.setString(2, cid);

                ps.execute();
                rs = ps.getResultSet();
                if (!rs.next()) {
                    ps.close();

                    response.sendRedirect("apply.jsp");
                }
                session.setAttribute("cid", cid);

                ps = conn.prepareStatement("SELECT * FROM post Where Circle=?");
                ps.setString(1, cid);
                ps.execute();
                
                rs = ps.getResultSet();  %>
    </head>


    <body>
        <% if (isowner) %>
        <h2><a href="Manage_Circle.jsp">Manage the circle</a></h2>
        <h1>Recent posts</h1>
        <% while (rs.next()) {%>

        <a href="${pageContext.request.contextPath}/post?pid=<%=rs.getString("id")%>"><%=rs.getString("subject")%></a>
        </br>
        <%
                    }

                ps.close();
                conn.close();
            }
        %>
        <h1>Make a Post</h1>
        <form action="new_post" method="post"> 
            <table> 
                <tr><td>Subject</td><td><input style="width:250px" type="text" name="subject"></td></tr> 
                <tr><td>content</td><td><textarea name="content" style="height:150px;width:900px;resize: none;"></textarea></td></tr> 
                <tr><td></td><td><input type="submit" name="submit" value="Submit"></td></tr> 
            </table> 
        </form> 
        </br></br></br>


        <a href="user_index.jsp">back</a>
        &nbsp;
        <a href="logout.jsp">logout</a>
    </body>
</html>
