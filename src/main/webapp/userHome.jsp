<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="services.impl.*, services.*,models.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AutoParts Hub</title>
<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<style>
.products.container {
    max-width: 1280px;
    margin-inline: auto;
    padding: 0 20px;
}

.products a {
    text-decoration: none;
    font-size: 18px;
    font-weight: 500;
    font-family: 'Oswald', sans-serif;
    color: var(--dark-color);
    transition: color 0.3s ease;
}

.products a:hover {
    color: var(--main-color);
    cursor: pointer;
}

.products li {
    list-style: none;
}

.section.products {
    padding-block: 5rem;
    background-color: var(--light-color, #f5f5f5);
}

.products .container .section-title {
    text-align: center;
    margin-bottom: 40px;
    width: 100%;
    color: #2c3e50;
    font-family: 'Oswald', sans-serif;
    font-size: 32px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1px;
    position: relative;
    padding-bottom: 15px;
}

.products .container .section-title:after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 80px;
    height: 3px;
    background: #e74c3c;
}

.products .grid-list {
    display: grid;
    gap: 30px;
    padding: 0;
    margin: 0;
}

.products .container .grid-list {
    grid-template-columns: repeat(3, 1fr);
}

.products .container .grid-list .product-card {
    position: relative;
    background-color: #FFF;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.products .container .grid-list .product-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
}

.img-holder {
    position: relative;
    aspect-ratio: var(--width) / var(--height);
    overflow: hidden;
}

.img-holder:before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(to bottom, rgba(0,0,0,0) 70%, rgba(0,0,0,0.1) 100%);
    z-index: 1;
    opacity: 0;
    transition: opacity 0.3s ease;
}

.product-card:hover .img-holder:before {
    opacity: 1;
}

.img-cover {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.5s ease;
}

.product-card:hover .img-cover {
    transform: scale(1.05);
}

a, img, span, button, i {
    display: block;
}

.products .container .grid-list .product-card .card-content {
    padding: 25px 20px;
}

.products .h3 {
    font-size: 20px;
    margin-top: 0;
    margin-bottom: 12px;
}

.products :is(.h1, .h2, .h3, p) {
    font-family: 'Oswald', sans-serif;
}

.products .btn {
    display: flex;
    justify-content: center;
    align-items: center;
    color: white;
    font-family: 'Oswald', sans-serif;
    font-size: 15px;
    text-align: center;
    border-radius: 6px;
    overflow: hidden;
    transition: all 0.3s ease;
    line-height: 3rem;
    padding: 0 15px;
    gap: 8px;
    font-weight: 600;
    cursor: pointer;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    border: none;
    flex: 1;
}

.products .add {
    background-color: #2c3e50;
}

.products .add:hover {
    background-color: #34495e;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(44, 62, 80, 0.3);
}

.products .container .grid-list .product-card .card-content .btn-blue {
    background-color: #e74c3c;
}

.products .container .grid-list .product-card .card-content .btn-blue:hover {
    background-color: #c0392b;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
}

.products .product-title {
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 1;
    overflow: hidden;
    text-decoration: none;
    font-size: 20px;
    font-weight: 700;
    font-family: 'Oswald', sans-serif;
    color: #2c3e50;
    margin-bottom: 10px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.products .product-description {
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2;
    overflow: hidden;
    text-decoration: none;
    font-size: 15px;
    font-weight: 400;
    font-family: 'Roboto', sans-serif;
    color: #555;
    text-align: left;
    margin-bottom: 15px;
    line-height: 1.5;
}

.products .price {
    display: inline-block;
    text-decoration: none;
    font-size: 22px;
    font-weight: 700;
    font-family: 'Oswald', sans-serif;
    color: #e74c3c;
    margin-bottom: 20px;
    position: relative;
}

.products .price:before {
    content: "₹";
    font-size: 16px;
    margin-right: 2px;
}

.products .product-btn-form {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 10px;
}

/* Part badge */
.part-badge {
    position: absolute;
    top: 10px;
    right: 10px;
    background-color: rgba(44, 62, 80, 0.8);
    color: white;
    font-family: 'Oswald', sans-serif;
    font-size: 12px;
    font-weight: 600;
    text-transform: uppercase;
    padding: 5px 10px;
    border-radius: 4px;
    z-index: 5;
    letter-spacing: 0.5px;
}

/* Stock indicator */
.stock-indicator {
    position: absolute;
    top: 10px;
    left: 10px;
    background-color: rgba(39, 174, 96, 0.8);
    color: white;
    font-family: 'Oswald', sans-serif;
    font-size: 12px;
    font-weight: 600;
    text-transform: uppercase;
    padding: 5px 10px;
    border-radius: 4px;
    z-index: 5;
    letter-spacing: 0.5px;
}

.out-of-stock {
    background-color: rgba(231, 76, 60, 0.8);
}

.low-stock {
    background-color: rgba(243, 156, 18, 0.8);
}

/* Responsive adjustments */
@media (max-width: 1024px) {
    .products .container .grid-list {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 768px) {
    .products .container .grid-list {
        grid-template-columns: 1fr;
    }
    
    .products .container .section-title {
        font-size: 28px;
    }
}

.product-link {
    text-decoration: underline;
    color: #3498db;
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
    
        ProductService prodDao = new ProductService();
        List<Product> products = new ArrayList<Product>();
    
        String search = request.getParameter("search");
        String type = request.getParameter("type");
        String message = "Featured Auto Parts";
        if (search != null) {
            products = prodDao.searchAllProducts(search);
            message = "Search Results for '" + search + "'";
        } else if (type != null) {
            products = prodDao.getAllProductsByType(type);
            message = type.substring(0, 1).toUpperCase() + type.substring(1) + " Parts";
        } else {
            products = prodDao.getAllProducts();
        }
        if (products.isEmpty()) {
            message = "No parts found for '" + (search != null ? search : type) + "'";
            products = prodDao.getAllProducts();
        }
    %>
    <jsp:include page="header.jsp" />
    <section class="section products">
        <div class="container">
            <h2 class="h2 section-title"><%=message%></h2>
            <ul class="grid-list">
                <%
                for (Product product : products) {
                int cartQty = new CartService().getCartItemCount(userName, product.getProdId());
                String stockStatus = "";
                if (product.getProdQuantity() <= 0) {
                    stockStatus = "out-of-stock";
                } else if (product.getProdQuantity() <= 5) {
                    stockStatus = "low-stock";
                }
                %>
                <li>
                    <div class="product-card">
                        <% if (!stockStatus.isEmpty()) { %>
                        <div class="stock-indicator <%= stockStatus %>">
                            <%= stockStatus.equals("out-of-stock") ? "OUT OF STOCK" : "LOW STOCK" %>
                        </div>
                        <% } %>
                        <div class="part-badge"><%= product.getProdType() %></div>
                        <figure class="card-banner img-holder" style="--width: 410; --height: 260">
                            <img src="./ShowImage?pid=<%=product.getProdId()%>" width="410" height="260" loading="lazy" class="img-cover"
                                alt="<%= product.getProdName() %>" />
                        </figure>

                        <div class="card-content">
                            <h3 class="h3 product-title">
                                <%= product.getProdName() %>
                            </h3>
                            <%
                                String description = product.getProdInfo();
                                description = description.substring(0, Math.min(description.length(), 100));
                            %>
                            <p class="product-description"><%= description %></p>
                            <h4 class="price"><%= product.getProdPrice() %></h4>
                            <form method="post" class="product-btn-form">
                                <%
                                    if (cartQty == 0) {
                                %>
                                <button type="submit" formaction="./AddtoCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=1" class="btn add">
                                    <i class="fas fa-cart-plus"></i> Add to Cart
                                </button>

                                <button type="submit" formaction="./AddtoCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=1" class="btn btn-blue buy">
                                    <i class="fas fa-shopping-cart"></i> Buy Now
                                </button>
                                <%
                                    } else {
                                %>
                                 <button type="submit" formaction="./AddtoCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=0" class="btn add">
                                    <i class="fas fa-trash-alt"></i> Remove
                                 </button>

                                <button type="submit" formaction="cartDetails.jsp" class="btn btn-blue buy">
                                    <i class="fas fa-credit-card"></i> Checkout
                                </button>
                                <%
                                    }
                                %>
                            </form>
                        </div>
                    </div>
                </li>
                <%
                }
                %>
            </ul>
        </div>
    </section>
    <jsp:include page="footer.jsp" />
</body>
</html>