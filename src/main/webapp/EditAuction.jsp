<%@ page contentType="text/html;charset=UTF-8" %>
<%
    java.sql.ResultSet rs = (java.sql.ResultSet) request.getAttribute("item");
    rs.next();
%>
<!doctype html>
<html>
<head><title>Edit Auction</title></head>
<body>
<h2>Edit Auction</h2>
<form action="${pageContext.request.contextPath}/seller" method="post" enctype="multipart/form-data">
    <input type="hidden" name="action" value="update"/>
    <input type="hidden" name="id" value="<%= rs.getInt("id") %>"/>
    Title: <input name="title" value="<%= rs.getString("title") %>" required/><br/>
    Description: <textarea name="description"><%= rs.getString("description") %></textarea><br/>
    Start Price: <input name="start_price" type="number" step="0.01" value="<%= rs.getBigDecimal("start_price") %>" required/><br/>
    Image: <input type="file" name="image" accept="image/*"/><br/>
    Current image:
    <%
        String img = rs.getString("image_path");
        if (img != null) {
    %>
      <img src="<%=request.getContextPath()+"/"+img %>" width="120"/>
    <% } %>
    <br/>
    <button type="submit">Update</button>
</form>
</body>
</html>
