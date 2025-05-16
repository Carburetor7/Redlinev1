<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page
import="services.impl.*, services.*,models.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order History - AutoParts Hub</title>
<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<style>
/* Global styles */
body {
    font-family: 'Roboto', sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f5f5f5;
}

/* Order history header */
.order-text.text-center {
    text-align: center;
    color: #2c3e50;
    font-size: 32px;
    font-weight: 700;
    font-family: 'Oswald', sans-serif;
    text-transform: uppercase;
    margin-bottom: 30px;
    position: relative;
    margin-top: 50px;
    padding-bottom: 15px;
}

.order-text.text-center:after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 80px;
    height: 3px;
    background: #e74c3c;
}

/* Container styles */
.orders.container {
    width: 100%;
    max-width: 1280px;
    margin: 30px auto 100px;
    padding: 0 20px;
}

/* Table responsive styles */
.orders .table-responsive {
    overflow-x: auto;
    background: white;
    border-radius: 8px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.08);
}

/* Table styles */
.orders .table {
    width: 100%;
    border-collapse: collapse;
}

/* Table header styles */
.orders .table thead {
    background-color: #2c3e50;
    color: white;
    font-size: 15px;
    font-weight: 600;
    font-family: 'Oswald', sans-serif;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

/* Table row styles */
.orders .table tbody tr {
    background-color: white;
    font-size: 15px;
    font-weight: 400;
    border-bottom: 1px solid #eee;
    transition: background-color 0.3s ease;
}

/* Table cell styles */
.orders .table td,
.orders .table th {
    padding: 15px;
    text-align: center;
    vertical-align: middle;
}

/* Table hover effect */
.table-hover tbody tr:hover {
    background-color: #f9f9f9;
}

/* Success text color */
.orders .text-success {
    color: #27ae60;
    font-weight: 600;
}

/* Order status style */
.orders .order-status {
    display: inline-block;
    padding: 6px 12px;
    border-radius: 30px;
    font-size: 12px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.orders .status-placed {
    background-color: rgba(243, 156, 18, 0.1);
    color: #f39c12;
}

.orders .status-shipped {
    background-color: rgba(39, 174, 96, 0.1);
    color: #27ae60;
}

/* Product image style */
.orders .product-image {
    width: 70px;
    height: 70px;
    object-fit: cover;
    border-radius: 6px;
    border: 1px solid #ddd;
}

/* Order ID style */
.orders .order-id {
    font-family: 'Roboto Mono', monospace;
    font-weight: 600;
    color: #3498db;
}

/* Product name style */
.orders .product-name {
    font-weight: 600;
    color: #2c3e50;
    max-width: 200px;
    text-align: left;
}

/* Price style */
.orders .price {
    font-weight: 700;
    color: #e74c3c;
}

/* Time style */
.orders .time {
    font-size: 13px;
    color: #7f8c8d;
}

/* No orders message */
.orders .no-orders {
    text-align: center;
    padding: 50px 20px;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.05);
}

.orders .no-orders i {
    font-size: 60px;
    color: #95a5a6;
    margin-bottom: 20px;
}

.orders .no-orders h3 {
    font-family: 'Oswald', sans-serif;
    font-size: 24px;
    color: #2c3e50;
    margin-bottom: 15px;
}

.orders .no-orders p {
    color: #7f8c8d;
    margin-bottom: 25px;
}

.orders .no-orders .browse-parts {
    display: inline-block;
    background-color: #3498db;
    color: white;
    padding: 12px 24px;
    border-radius: 6px;
    font-family: 'Oswald', sans-serif;
    font-weight: 600;
    text-transform: uppercase;
    text-decoration: none;
    transition: all 0.3s ease;
}

.orders .no-orders .browse-parts:hover {
    background-color: #2980b9;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
}

.order-link {
    text-decoration: underline;
    color: #3498db;
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .orders .table thead {
        font-size: 14px;
    }
    
    .orders .table tbody {
        font-size: 14px;
    }
    
    .orders .table td,
    .orders .table th {
        padding: 10px 8px;
    }
    
    .orders .product-image {
        width: 50px;
        height: 50px;
    }
    
    .orders .product-name {
        max-width: 150px;
    }
}
</style>
</head>
<body>
<%
/* Checking the user credentials */
String userName = (String) session.getAttribute("username");

if (userName == null) {
    response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
}

OrderService dao = new OrderService();
List<OrderDetails> orders = dao.getAllOrderDetails(userName);
%>
<jsp:include page="header.jsp" />
<div class="text-center order-text">Order History</div>

<!-- Start of Order History List -->
<div class="container orders">
    <div class="table-responsive">
        <% if (orders != null && !orders.isEmpty()) { %>
        <table class="table table-hover table-sm">
            <thead>
                <tr>
                    <th>Image</th>
                    <th>Part Name</th>
                    <th>Order ID</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                for (OrderDetails order : orders) {
                %>
                <tr>
                    <td><img src="./ShowImage?pid=<%=order.getProductId()%>" class="product-image" alt="<%=order.getProdName()%>"></td>
                    <td class="product-name"><%=order.getProdName()%></td>
                    <td class="order-id"><%=order.getOrderId()%></td>
                    <td><%=order.getQty()%></td>
                    <td class="price">₹<%=order.getAmount()%></td>
                    <td class="time"><%=order.getTime()%></td>
                    <td>
                        <% if (order.getShipped() == 0) { %>
                            <span class="order-status status-placed">Processing</span>
                        <% } else { %>
                            <span class="order-status status-shipped">Shipped</span>
                        <% } %>
                    </td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
        <% } else { %>
        <div class="no-orders">
            <i class="fas fa-clipboard-list"></i>
            <h3>No orders yet</h3>
            <p>You haven't placed any orders yet. Start shopping to see your order history here.</p>
            <a href="userHome.jsp" class="browse-parts">Browse Parts</a>
        </div>
        <% } %>
    </div>
</div>
<%@ include file="footer.jsp"%>
</body>
</html>