<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="services.impl.*, services.*,models.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pending Shipments - AutoParts Hub</title>
<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<style>
/* Text center class */
.unshipped-text.text-center {
    text-align: center;
    font-size: 32px;
    font-weight: 700;
    font-family: 'Oswald', sans-serif;
    color: #2c3e50;
    text-transform: uppercase;
    letter-spacing: 1px;
    margin: 50px 0 30px;
    position: relative;
    padding-bottom: 15px;
}

.unshipped-text:after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 80px;
    height: 3px;
    background: #e74c3c;
}

.unshipped {
    margin: 30px auto 100px;
    font-family: 'Roboto', sans-serif;
}

/* Container styles */
.unshipped .container-fluid {
    width: 100%;
    max-width: 1280px;
    margin: 0 auto;
    padding: 0 20px;
}

/* Table responsive styles */
.unshipped .table-responsive {
    overflow-x: auto;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
}

/* Table styles */
.unshipped .table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 0;
}

/* Table header styles */
.unshipped .table thead {
    background-color: #2c3e50;
    color: white;
    font-size: 15px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    font-family: 'Oswald', sans-serif;
    font-weight: 600;
}

.unshipped .table thead th {
    padding: 16px 15px;
    vertical-align: middle;
    text-align: left;
    border: none;
}

/* Table row styles */
.unshipped .table tbody tr {
    background-color: white;
    border-bottom: 1px solid #eee;
    transition: background-color 0.3s ease;
}

.unshipped .table tbody tr:last-child {
    border-bottom: none;
}

/* Table cell styles */
.unshipped .table td {
    padding: 16px 15px;
    border: none;
    vertical-align: middle;
    font-size: 14px;
    color: #555;
}

/* Table hover effect */
.unshipped .table-hover tbody tr:hover {
    background-color: #f9f9f9;
}

/* Button styles */
.unshipped .btn {
    padding: 10px 18px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    text-decoration: none;
    color: white;
    font-size: 14px;
    font-weight: 600;
    font-family: 'Oswald', sans-serif;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    transition: all 0.3s ease;
}

/* Button success styles */
.unshipped .btn-success {
    background-color: #3498db;
}

.unshipped .btn-success:hover {
    background-color: #2980b9;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
}

.unshipped-link {
    text-decoration: underline;
    color: #3498db;
}

.unshipped .productID {
    text-decoration: none;
    color: #3498db;
    font-weight: 600;
    transition: all 0.3s ease;
}

.unshipped .productID:hover {
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

/* Status indicator */
.status-indicator {
    display: inline-block;
    padding: 6px 12px;
    background-color: rgba(243, 156, 18, 0.1);
    color: #f39c12;
    font-family: 'Oswald', sans-serif;
    font-size: 12px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    border-radius: 4px;
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
    .unshipped .table {
        font-size: 14px;
    }
    
    .unshipped .table th,
    .unshipped .table td {
        padding: 12px 10px;
    }
    
    .unshipped-text.text-center {
        font-size: 26px;
    }
}
</style>
</head>
<body>
    <%
    /* Checking the user credentials */
    String userType = (String) session.getAttribute("usertype");
    String userName = (String) session.getAttribute("username");

    if (userType == null || !userType.equals("admin")) {
        response.sendRedirect("loginFirst.jsp");
    }

    if (userName == null) {
        response.sendRedirect("loginFirst.jsp");
    }
    %>
    
    <jsp:include page="header.jsp" />
    <div class="text-center unshipped-text">Pending Shipments</div>

    <!-- Start of UnShipped Orders List -->
    <div class="container-fluid unshipped">
        <div class="table-responsive">
            <table class="table table-hover table-sm">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Part ID</th>
                        <th>Customer</th>
                        <th>Shipping Address</th>
                        <th>Quantity</th>
                        <th>Status</th>
                        <th>Action</th>
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
                        if (shipped == 0) {
                            count++;
                    %>
                    <tr>
                        <td class="transaction-id"><%=transId%></td>
                        <td><a class="productID" href="./updateProduct.jsp?prodid=<%=prodId%>"><i class="fas fa-tools"></i> <%=prodId%></a></td>
                        <td class="user-name"><%=userId%></td>
                        <td><%=userAddr%></td>
                        <td><%=quantity%></td>
                        <td><span class="status-indicator"><i class="fas fa-clock"></i> READY TO SHIP</span></td>
                        <td>
                           <a href="ShipmentServlet?orderid=<%=order.getTransactionId()%>&amount=<%=order.getAmount()%>&userid=<%=userId%>&prodid=<%=order.getProductId()%>"
                            class="btn btn-success"><i class="fas fa-truck"></i> SHIP NOW</a></td>
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
                            <i class="fas fa-check-circle"></i> No Pending Shipments Available
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