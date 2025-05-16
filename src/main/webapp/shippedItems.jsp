<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="services.impl.*, services.*,models.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shipped Orders - Admin Dashboard</title>
<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<style>
.shipped {
    font-family: 'Roboto', sans-serif;
}

/* Page title styling */
.shipped-text.text-center {
    text-align: center;
    font-size: 32px;
    font-weight: 700;
    font-family: 'Oswald', sans-serif;
    color: #2c3e50;
    text-transform: uppercase;
    letter-spacing: 1px;
    margin-top: 50px;
    margin-bottom: 30px;
    position: relative;
    padding-bottom: 15px;
}

.shipped-text:after {
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
.shipped.container-fluid {
    width: 100%;
    max-width: 1280px;
    margin: 30px auto 100px;
    padding: 0 20px;
}

/* Table responsive styles */
.shipped .table-responsive {
    overflow-x: auto;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
}

/* Table styles */
.shipped .table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 0;
}

/* Table header styles */
.table thead {
    background-color: #2c3e50;
    color: white;
    font-size: 15px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    font-family: 'Oswald', sans-serif;
    font-weight: 600;
}

.table thead th {
    padding: 16px 15px;
    vertical-align: middle;
    text-align: left;
    border: none;
}

/* Table row styles */
.shipped .table tbody tr {
    background-color: white;
    border-bottom: 1px solid #eee;
    transition: background-color 0.3s ease;
}

.shipped .table tbody tr:last-child {
    border-bottom: none;
}

/* Table cell styles */
.shipped .table td {
    padding: 16px 15px;
    border: none;
    vertical-align: middle;
    font-size: 14px;
    color: #555;
}

/* Table hover effect */
.shipped .table-hover tbody tr:hover {
    background-color: #f9f9f9;
}

/* Status styling */
.shipped .text-success {
    display: inline-block;
    padding: 6px 12px;
    background-color: rgba(39, 174, 96, 0.1);
    color: #27ae60;
    font-family: 'Oswald', sans-serif;
    font-size: 12px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    border-radius: 4px;
}

/* ProductID link styling */
.shipped .productID {
    text-decoration: none;
    color: #3498db;
    font-weight: 600;
    transition: all 0.3s ease;
}

.shipped .productID:hover {
    color: #e74c3c;
    text-decoration: underline;
}

/* Transaction ID styling */
.transaction-id {
    font-family: 'Roboto Mono', monospace;
    font-size: 13px;
    font-weight: 500;
    color: #7f8c8d;
}

/* User name styling */
.user-name {
    font-weight: 600;
    color: #2c3e50;
}

/* Amount styling */
.amount {
    font-weight: 700;
    color: #e74c3c;
}

/* Empty table message */
.no-items {
    background-color: #34495e !important;
    color: white !important;
}

.no-items td {
    text-align: center !important;
    padding: 30px !important;
    font-family: 'Oswald', sans-serif;
    font-size: 16px;
    letter-spacing: 0.5px;
}

/* Responsive styling */
@media (max-width: 768px) {
    .shipped .table {
        font-size: 14px;
    }
    
    .shipped .table th,
    .shipped .table td {
        padding: 12px 10px;
    }
    
    .shipped-text.text-center {
        font-size: 26px;
    }
}

.shipped-link {
    text-decoration: underline;
    color: #3498db;
}
</style>
</head>
<body>
    <%
    /* Checking the user credentials */
    String userType = (String) session.getAttribute("usertype");
    String userName = (String) session.getAttribute("username");

    if (userType == null || !userType.equals("admin")) {
        response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");
    }
    else if (userName == null) {
        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
    }
    %>
    <jsp:include page="header.jsp" />
    <div class="text-center shipped-text">Shipped Orders</div>

    <!-- Start of Shipped Orders List -->
    <div class="container-fluid shipped">
        <div class="table-responsive">
            <table class="table table-hover table-sm">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Part ID</th>
                        <th>Customer</th>
                        <th>Shipping Address</th>
                        <th>Quantity</th>
                        <th>Total</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    OrderService orderdao = new OrderService();

                    List<OrderBean> orders = new ArrayList<OrderBean>();
                    orders = orderdao.getAllOrders();
                    int count = 0;
                    for (OrderBean order : orders) {
                        String transId = order.getTransactionId();
                        String prodId = order.getProductId();
                        int quantity = order.getQuantity();
                        int shipped = order.getShipped();
                        String userId = new TransactionService().getUserId(transId);
                        String userAddr = new UserService().getUserAddr(userId);
                        if (shipped != 0) {
                            count++;
                    %>
                    <tr>
                        <td class="transaction-id"><%=transId%></td>
                        <td><a class="productID" href="./updateProduct.jsp?prodid=<%=prodId%>"><i class="fas fa-tools"></i> <%=prodId%></a></td>
                        <td class="user-name"><%=userId%></td>
                        <td><%=userAddr%></td>
                        <td><%=quantity%></td>
                        <td class="amount">₹<%=order.getAmount()%></td>
                        <td><span class="text-success"><i class="fas fa-truck"></i> SHIPPED</span></td>
                    </tr>
                    <%
                    }
                    }
                    %>
                    <%
                    if (count == 0) {
                    %>
                    <tr class="no-items">
                        <td colspan="7">
                            <i class="fas fa-box-open"></i> No Shipped Orders Available
                        </td>
                    </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>