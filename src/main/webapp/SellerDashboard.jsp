<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="nextauction.servlet.SellerServlet.Item" %>
<%
    List<Item> items = (List<Item>) request.getAttribute("items");
%>
<!doctype html>
<html>
<head><title>Seller Dashboard</title></head>
<body>
<h2>Your Auctions</h2>
<p><a href="${pageContext.request.contextPath}/seller?action=add">Add New Auction</a></p>

<table border="1" cellpadding="6">
    <tr><th>ID</th><th>Title</th><th>Price</th><th>Image</th><th>Start</th><th>End</th><th>Actions</th></tr>
    <c:forEach var="it" items="${items}">
        <tr>
            <td>${it.id}</td>
            <td>${it.title}</td>
            <td>${it.price}</td>
            <td>
                <c:if test="${not empty it.image}">
                    <img src="${pageContext.request.contextPath}/${it.image}" width="80"/>
                </c:if>
            </td>
            <td>${it.start}</td>
            <td>${it.end}</td>
            <td>
                <a href="${pageContext.request.contextPath}/seller?action=edit&id=${it.id}">Edit</a> |
                <a href="${pageContext.request.contextPath}/seller?action=delete&id=${it.id}" onclick="return confirm('Delete?');">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
