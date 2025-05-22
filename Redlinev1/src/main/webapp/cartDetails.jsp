<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="services.impl.*, services.*,models.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shopping Cart - AutoParts Hub</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
.text-center {
    text-align: center;
    color: #2c3e50;
    font-size: 32px;
    font-weight: 700;
    font-family: 'Oswald', sans-serif;
    text-transform: uppercase;
    margin-bottom: 30px;
    position: relative;
    padding-bottom: 15px;
    margin-top: 120px; /* Added to fix floating header issue */
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

.cart {
    margin-top: 20px;
    margin-bottom: 100px;
    font-family: 'Roboto', sans-serif;
    max-width: 1280px;
    margin-left: auto;
    margin-right: auto;
    padding: 0 20px;
    clear: both; /* Added to fix floating issue */
}

.cart-heading {
    margin-top: 120px; /* Increased to fix header overlap */
    clear: both; /* Added to fix floating issues */
}

.cart .product-table {
    width: 100%;
    border-collapse: collapse;
    box-shadow: 0 5px 15px rgba(0,0,0,0.08);
    border-radius: 8px;
    overflow: hidden;
}

.cart .product-table th,
.cart .product-table td {
    padding: 15px;
    text-align: center;
    vertical-align: middle;
}

.cart .product-table th {
    background-color: #2c3e50;
    color: white;
    font-size: 16px;
    font-weight: 600;
    font-family: 'Oswald', sans-serif;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.cart .product-table tbody tr {
    border-bottom: 1px solid #eee;
    transition: background-color 0.3s ease;
}

.cart .product-table tbody tr:hover {
    background-color: #f9f9f9;
}

.cart .product-table tbody tr:nth-child(even) {
    background-color: #f5f5f5;
}

.cart .product-table tbody tr:nth-child(even):hover {
    background-color: #f0f0f0;
}

.cart .product-image {
    width: 80px;
    height: 80px;
    object-fit: cover;
    border-radius: 6px;
    border: 1px solid #ddd;
}

.cart .quantity-input {
    width: 60px;
    padding: 8px;
    text-align: center;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
}

.cart .update-button {
    background-color: #3498db;
    padding: 8px 12px;
    border-radius: 4px;
    border: none;
    color: white;
    cursor: pointer;
    font-weight: 600;
    transition: all 0.3s ease;
    margin-left: 5px;
}

.cart .update-button:hover {
    background-color: #2980b9;
    transform: translateY(-2px);
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.cart .add-link,
.cart .remove-link {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 30px;
    height: 30px;
    border-radius: 50%;
    transition: all 0.3s ease;
}

.cart .add-link {
    background-color: rgba(46, 204, 113, 0.1);
    color: #27ae60;
}

.cart .add-link:hover {
    background-color: #27ae60;
    color: white;
}

.cart .remove-link {
    background-color: rgba(231, 76, 60, 0.1);
    color: #e74c3c;
}

.cart .remove-link:hover {
    background-color: #e74c3c;
    color: white;
}

.cart .total-row {
    background-color: #34495e !important;
    color: white;
    font-weight: 700;
}

.cart .total-row td {
    padding: 20px 15px;
}

.cart .total-label {
    text-align: right;
    font-family: 'Oswald', sans-serif;
    font-size: 18px;
    text-transform: uppercase;
}

.cart .action-row td {
    padding: 25px 15px;
    background-color: #f9f9f9;
}

.cart .button {
    padding: 12px 24px;
    border-radius: 6px;
    border: none;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    font-family: 'Oswald', sans-serif;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.cart .cancel-button {
    background-color: #7f8c8d;
    color: white;
}

.cart .cancel-button:hover {
    background-color: #95a5a6;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(127, 140, 141, 0.3);
}

.cart .pay-button {
    background-color: #e74c3c;
    color: white;
}

.cart .pay-button:hover {
    background-color: #c0392b;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
}

.cart-link {
    text-decoration: underline;
    color: #3498db;
}

.empty-cart {
    text-align: center;
    padding: 50px 20px;
    background-color: #f9f9f9;
    border-radius: 8px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.05);
    margin-top: 30px;
}

.empty-cart i {
    font-size: 60px;
    color: #95a5a6;
    margin-bottom: 20px;
}

.empty-cart h3 {
    font-family: 'Oswald', sans-serif;
    font-size: 24px;
    color: #2c3e50;
    margin-bottom: 15px;
}

.empty-cart p {
    font-family: 'Roboto', sans-serif;
    color: #7f8c8d;
    margin-bottom: 25px;
}

.empty-cart .continue-shopping {
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

.empty-cart .continue-shopping:hover {
    background-color: #2980b9;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
}

.product-name {
    font-weight: 600;
    color: #2c3e50;
}

.product-price {
    font-weight: 600;
    color: #e74c3c;
}

.amount {
    font-weight: 700;
    color: #2c3e50;
}

.total-amount {
    font-size: 20px;
    font-weight: 700;
    color: white;
}

/* Add this to ensure content doesn't overlap with header */
body {
    padding-top: 0;
    margin-top: 0;
}

/* Force the header to stay at the top */
header {
    position: relative;
    z-index: 1000;
}

@media (max-width: 768px) {
    .cart .product-table {
        font-size: 14px;
    }
    
    .cart .product-image {
        width: 60px;
        height: 60px;
    }
    
    .cart .button {
        padding: 10px 16px;
        font-size: 14px;
    }
    
    .cart .product-table th:nth-child(5),
    .cart .product-table td:nth-child(5),
    .cart .product-table th:nth-child(6),
    .cart .product-table td:nth-child(6) {
        display: none;
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

    String addS = request.getParameter("add");
    if (addS != null) {
        int add = Integer.parseInt(addS);
        String uid = request.getParameter("uid");
        String pid = request.getParameter("pid");
        int avail = Integer.parseInt(request.getParameter("avail"));
        int cartQty = Integer.parseInt(request.getParameter("qty"));
        CartService cart = new CartService();

        if (add == 1) {
            //Add Product into the cart
            cartQty += 1;
            if (cartQty <= avail) {
                cart.addProductToCart(uid, pid, 1);
            } else {
                response.sendRedirect("./AddtoCart?pid=" + pid + "&pqty=" + cartQty);
            }
        } else if (add == 0) {
            //Remove Product from the cart
            cart.removeProductFromCart(uid, pid);
        }
    }
    %>
    <jsp:include page="header.jsp" />
    <div class="text-center cart-heading">Your Shopping Cart</div>

    <!-- Start of Product Items List -->
    <div class="cart">
        <% 
        CartService cart = new CartService(); 
        List<Cart> cartItems = new ArrayList<Cart>(); 
        cartItems = cart.getAllCartItems(userName); 
        double totAmount = 0; 
        
        if (cartItems != null && !cartItems.isEmpty()) { 
            boolean hasItems = false;
            for (Cart item : cartItems) {
                if (item.getQuantity() > 0) {
                    hasItems = true;
                    break;
                }
            }
            
            if (hasItems) {
        %>
        <table class="product-table">
            <thead>
                <tr>
                    <th>Image</th>
                    <th>Product</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Add</th>
                    <th>Remove</th>
                    <th>Subtotal</th>
                </tr>
            </thead>
            <tbody>
                <% 
                for (Cart item : cartItems) { 
                    String prodId = item.getProdId(); 
                    int prodQuantity = item.getQuantity(); 
                    Product product = new ProductService().getProductDetails(prodId); 
                    double currAmount = product.getProdPrice() * prodQuantity; 
                    totAmount += currAmount; 
                    if (prodQuantity > 0) { 
                %>
                <tr>
                    <td><img src="./ShowImage?pid=<%=product.getProdId()%>" class="product-image" alt="<%=product.getProdName()%>"></td>
                    <td class="product-name"><%=product.getProdName()%></td>
                    <td class="product-price">₹<%=product.getProdPrice()%></td>
                    <td>
                        <form method="post" action="./UpdateToCart">
                            <input type="number" name="pqty" value="<%=prodQuantity%>" class="quantity-input" min="0">
                            <input type="hidden" name="pid" value="<%=product.getProdId()%>">
                            <input type="submit" name="Update" value="Update" class="update-button">
                        </form>
                    </td>
                    <td><a href="cartDetails.jsp?add=1&uid=<%=userName%>&pid=<%=product.getProdId()%>&avail=<%=product.getProdQuantity()%>&qty=<%=prodQuantity%>" class="add-link"><i class="fas fa-plus"></i></a></td>
                    <td><a href="cartDetails.jsp?add=0&uid=<%=userName%>&pid=<%=product.getProdId()%>&avail=<%=product.getProdQuantity()%>&qty=<%=prodQuantity%>" class="remove-link"><i class="fas fa-minus"></i></a></td>
                    <td class="amount">₹<%=currAmount%></td>
                </tr>
                <% } } %>
                <tr class="total-row">
                    <td colspan="6" class="total-label">Total Amount</td>
                    <td class="total-amount">₹<%=totAmount%></td>
                </tr>
                <% if (totAmount != 0) { %>
                <tr class="action-row">
                    <td colspan="3"></td>
                    <td colspan="2">
                        <form method="post">
                            <button formaction="userHome.jsp" class="button cancel-button">
                                <i class="fas fa-arrow-left"></i> Continue Shopping
                            </button>
                        </form>
                    </td>
                    <td colspan="2">
                        <form method="post">
                            <button formaction="payment.jsp?amount=<%=totAmount%>" class="button pay-button">
                                <i class="fas fa-credit-card"></i> Checkout
                            </button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% } else { %>
        <div class="empty-cart">
            <i class="fas fa-shopping-cart"></i>
            <h3>Your cart is empty</h3>
            <p>Looks like you haven't added any parts to your cart yet.</p>
            <a href="userHome.jsp" class="continue-shopping">Browse Parts</a>
        </div>
        <% } } else { %>
        <div class="empty-cart">
            <i class="fas fa-shopping-cart"></i>
            <h3>Your cart is empty</h3>
            <p>Looks like you haven't added any parts to your cart yet.</p>
            <a href="userHome.jsp" class="continue-shopping">Browse Parts</a>
        </div>
        <% } %>
    </div>
    
    <%@ include file="footer.jsp"%>
</body>
</html>