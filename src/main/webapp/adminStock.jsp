<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="services.impl.*, services.*,models.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Inventory Management - AutoParts Hub</title>
<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<style>
.stocks {
    font-family: 'Roboto', sans-serif;
}

/* Text center class */
.text-center {
    text-align: center;
    color: #2c3e50;
    font-size: 32px;
    font-weight: 700;
    font-family: 'Oswald', sans-serif;
    text-transform: uppercase;
    letter-spacing: 1px;
    margin-top: 50px;
    margin-bottom: 30px;
    position: relative;
    padding-bottom: 15px;
}

.text-center:after {
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
.stocks.container-fluid {
    width: 100%;
    max-width: 1280px;
    margin: 30px auto 100px;
    padding: 0 20px;
}

/* Table responsive styles */
.stocks .table-responsive {
    overflow-x: auto;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
}

/* Table styles */
.stocks .table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 0;
}

/* Table header styles */
.stocks .table thead {
    background-color: #2c3e50;
    color: white;
    font-size: 15px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    font-family: 'Oswald', sans-serif;
    font-weight: 600;
}

.stocks .table thead th {
    padding: 16px 15px;
    vertical-align: middle;
    text-align: left;
    border: none;
}

/* Table row styles */
.stocks .table tbody tr {
    background-color: white;
    font-size: 14px;
    border-bottom: 1px solid #eee;
    transition: background-color 0.3s ease;
}

.stocks .table tbody tr:last-child {
    border-bottom: none;
}

/* Table cell styles */
.stocks .table td {
    padding: 12px 15px;
    border: none;
    vertical-align: middle;
}

/* Table hover effect */
.stocks .table-hover tbody tr:hover {
    background-color: #f9f9f9;
}

/* Button styles */
.stocks .btn {
    padding: 8px 12px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 13px;
    font-weight: 600;
    font-family: 'Oswald', sans-serif;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    transition: all 0.3s ease;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 5px;
}

/* Button primary styles */
.stocks .btn-primary {
    background-color: #3498db;
    color: white;
}

.stocks .btn-primary:hover {
    background-color: #2980b9;
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(52, 152, 219, 0.3);
}

/* Button danger styles */
.stocks .btn-danger {
    background-color: #e74c3c;
    color: white;
}

.stocks .btn-danger:hover {
    background-color: #c0392b;
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(231, 76, 60, 0.3);
}

.stocks a {
    text-decoration: none;
    color: #3498db;
    font-weight: 600;
    transition: all 0.3s ease;
}

.stocks a:hover {
    color: #e74c3c;
}

.stock-link {
    text-decoration: underline;
    color: #3498db;
}

/* Product image */
.stocks .product-image {
    width: 60px;
    height: 60px;
    object-fit: cover;
    border-radius: 6px;
    border: 1px solid #eee;
    transition: transform 0.3s ease;
}

.stocks .product-image:hover {
    transform: scale(1.1);
}

/* Product ID */
.stocks .product-id {
    font-family: 'Roboto Mono', monospace;
    font-size: 13px;
    color: #7f8c8d;
}

/* Product name */
.stocks .product-name {
    font-weight: 600;
    color: #2c3e50;
}

/* Product type */
.stocks .product-type {
    display: inline-block;
    padding: 5px 10px;
    background-color: rgba(52, 152, 219, 0.1);
    color: #3498db;
    border-radius: 4px;
    font-size: 12px;
    font-weight: 600;
    text-transform: uppercase;
}

/* Product price */
.stocks .product-price {
    font-weight: 700;
    color: #e74c3c;
}

/* Stock levels */
.stocks .stock-level {
    font-weight: 700;
}

.stocks .stock-high {
    color: #27ae60;
}

.stocks .stock-medium {
    color: #f39c12;
}

.stocks .stock-low {
    color: #e74c3c;
}

/* Action buttons container */
.stocks .action-buttons {
    display: flex;
    gap: 10px;
}

/* Empty stock message */
.stocks .no-items {
    background-color: #34495e !important;
    color: white !important;
    text-align: center;
    padding: 30px !important;
    font-family: 'Oswald', sans-serif;
    font-size: 16px;
    letter-spacing: 0.5px;
}

/* Filter controls */
.stocks .filter-controls {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
    align-items: center;
}

.stocks .search-box {
    display: flex;
    gap: 10px;
}

.stocks .search-input {
    padding: 10px 15px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-family: 'Roboto', sans-serif;
    width: 250px;
}

.stocks .search-button {
    background-color: #3498db;
    color: white;
    border: none;
    border-radius: 4px;
    padding: 10px 15px;
    cursor: pointer;
    font-weight: 600;
    font-family: 'Oswald', sans-serif;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    transition: all 0.3s ease;
}

.stocks .search-button:hover {
    background-color: #2980b9;
}

.stocks .filter-dropdown {
    padding: 10px 15px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-family: 'Roboto', sans-serif;
}

/* Add new part button */
.stocks .add-new-button {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background-color: #27ae60;
    color: white;
    border: none;
    border-radius: 4px;
    padding: 10px 15px;
    cursor: pointer;
    font-weight: 600;
    font-family: 'Oswald', sans-serif;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    transition: all 0.3s ease;
    text-decoration: none;
}

.stocks .add-new-button:hover {
    background-color: #219653;
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(39, 174, 96, 0.3);
}

/* Responsive adjustments */
@media (max-width: 992px) {
    .stocks .filter-controls {
        flex-direction: column;
        gap: 15px;
        align-items: flex-start;
    }
    
    .stocks .search-box {
        width: 100%;
    }
    
    .stocks .search-input {
        width: 100%;
        flex: 1;
    }
}

@media (max-width: 768px) {
    .stocks .action-buttons {
        flex-direction: column;
    }
    
    .stocks .btn {
        width: 100%;
    }
    
    .stocks .table th,
    .stocks .table td {
        padding: 10px 8px;
    }
    
    .stocks .product-image {
        width: 40px;
        height: 40px;
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
    response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");
}
else if (userName == null) {
    response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
}
%>
<jsp:include page="header.jsp" />
<div class="text-center stock-text">Inventory Management</div>

<!-- Start of Product Items List -->
<div class="container-fluid stocks">
    <div class="filter-controls">
        <div class="search-box">
            <input type="text" class="search-input" placeholder="Search by part name or ID">
            <button class="search-button"><i class="fas fa-search"></i> Search</button>
        </div>
        <a href="addProduct.jsp" class="add-new-button">
            <i class="fas fa-plus"></i> Add
        </a>
    </div>
    
    <div class="table-responsive">
        <table class="table table-hover table-sm">
            <thead>
                <tr>
                    <th>Image</th>
                    <th>Part ID</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Sold</th>
                    <th>In Stock</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                ProductService productDao = new ProductService();
                List<Product> products = new ArrayList<Product>();
                products = productDao.getAllProducts();
                for (Product product : products) {
                    String stockClass = "";
                    if (product.getProdQuantity() > 10) {
                        stockClass = "stock-high";
                    } else if (product.getProdQuantity() > 3) {
                        stockClass = "stock-medium";
                    } else {
                        stockClass = "stock-low";
                    }
                %>
                <tr>
                    <td><img src="./ShowImage?pid=<%=product.getProdId()%>" class="product-image" alt="<%=product.getProdName()%>"></td>
                    <td class="product-id"><a href="./updateProduct.jsp?prodid=<%=product.getProdId()%>"><%=product.getProdId()%></a></td>
                    <%
                    String name = product.getProdName();
                    name = name.substring(0, Math.min(name.length(), 25)) + "..";
                    %>
                    <td class="product-name"><%=name%></td>
                    <td><span class="product-type"><%=product.getProdType().toUpperCase()%></span></td>
                    <td class="product-price">₹<%=product.getProdPrice()%></td>
                    <td><%=new OrderService().countSoldItem(product.getProdId())%></td>
                    <td class="<%=stockClass%>"><%=product.getProdQuantity()%></td>
                    <td>
                        <div class="action-buttons">
                            <form method="post">
                                <button type="submit" formaction="updateProduct.jsp?prodid=<%=product.getProdId()%>" class="btn btn-primary">
                                    <i class="fas fa-edit"></i> Edit
                                </button>
                            </form>
                            <form method="post">
                                <button type="submit" formaction="./RemoveProductSrv?prodid=<%=product.getProdId()%>" class="btn btn-danger">
                                    <i class="fas fa-trash-alt"></i> Delete
                                </button>
                            </form>
                        </div>
                    </td>
                </tr>
                <%
                }
                %>
                
                <%
                if (products.size() == 0) {
                %>
                <tr>
                    <td colspan="8" class="no-items">
                        <i class="fas fa-box-open"></i> No Parts Available in Inventory
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