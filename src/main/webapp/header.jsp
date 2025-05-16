<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="services.impl.*, services.*"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AutoParts Hub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
    	* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

:root {
    --ff-heading: "Oswald", sans-serif;
    --ff-body: "Roboto", sans-serif;
    --main-color: #e74c3c;
    --dark-color: #2c3e50;
    --accent-color: #3498db;
    --light-color: #ecf0f1;
    --gray-color: #95a5a6;
    --success-color: #27ae60;
    --warning-color: #f39c12;
}

.container {
    max-width: 1280px;
    margin: 0 auto;
    padding: 0 20px;
}

a {
    text-decoration: none;
    font-size: 18px;
    font-weight: 500;
    font-family: var(--ff-heading);
    color: var(--dark-color);
    text-transform: uppercase;
    letter-spacing: 0.5px;
    transition: color 0.2s ease;
}

a:hover {
    color: var(--main-color);
    cursor: pointer;
}

/* Header Styling */
#header {
    background-color: #fff;
    width: 100%;
    box-shadow: 0 2px 15px rgba(0, 0, 0, 0.08);
    position: sticky;
    top: 0;
    z-index: 100;
}

.navbar {
    padding: 15px 0;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.navbar img {
    width: 50px;
    height: 50px;
}

.logo-part {
    display: flex;
    align-items: center;
    gap: 10px;
}

.logo-part h2 {
    font-family: var(--ff-heading);
    color: var(--dark-color);
    font-size: 24px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1px;
    position: relative;
}

.logo-part h2:after {
    content: "AUTO PARTS";
    position: absolute;
    bottom: -10px;
    left: 0;
    font-size: 12px;
    color: var(--main-color);
    letter-spacing: 2px;
    font-weight: 500;
}

.logo-part h2:hover {
    color: var(--main-color);
    cursor: pointer;
}

li {
    list-style: none;
}

.navbar .nav-list {
    display: flex;
    gap: 25px;
    align-items: center;
}

/* Dropdown menu */
.category {
    position: relative;
}

.dropdown-menu {
    display: none;
}

.category:hover .dropdown-menu {
    display: block;
    position: absolute;
    left: 0;
    top: 100%;
    background-color: #fff;
    border-radius: 4px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    z-index: 100;
    min-width: 200px;
    padding: 5px 0;
}

.category:hover .dropdown-menu ul {
    display: block;
}

.category:hover .dropdown-menu ul li {
    width: 100%;
    padding: 0;
}

.category:hover .dropdown-menu ul li a {
    padding: 12px 20px;
    display: block;
    font-size: 16px;
    border-left: 3px solid transparent;
    transition: all 0.3s ease;
}

.category:hover .dropdown-menu ul li a:hover {
    background-color: #f8f9fa;
    border-left: 3px solid var(--main-color);
    padding-left: 25px;
}

/* Search section */
.search {
    width: 100%;
    background: linear-gradient(135deg, var(--dark-color) 0%, #34495e 100%);
    padding: 60px 0;
    position: relative;
    overflow: hidden;
}

.search:before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: url('https://images.unsplash.com/photo-1527247043589-98e6ac08f56c') center/cover no-repeat;
    opacity: 0.1;
    z-index: 0;
}

.search .container {
    position: relative;
    z-index: 1;
}

.content h1, .content p {
    text-align: center;
    color: white;
    font-family: var(--ff-heading);
}

.content h1 {
    font-size: 42px;
    font-weight: 700;
    margin-bottom: 15px;
    text-transform: uppercase;
    letter-spacing: 1px;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
}

.content p {
    font-size: 18px;
    font-weight: 400;
    margin-bottom: 30px;
    max-width: 600px;
    margin-left: auto;
    margin-right: auto;
    line-height: 1.5;
    font-family: var(--ff-body);
    opacity: 0.9;
}

.content {
    margin-bottom: 40px;
}

.search-container {
    display: flex;
    justify-content: center;
    align-items: center;
    max-width: 600px;
    margin: 0 auto;
    position: relative;
}

.search-box {
    width: 100%;
    display: flex;
    overflow: hidden;
    border-radius: 50px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
}

.search-box input {
    flex: 1;
    height: 60px;
    border: none;
    outline: none;
    padding: 0 30px;
    font-size: 18px;
    font-family: var(--ff-body);
    color: var(--dark-color);
}

.search-box input::placeholder {
    color: #95a5a6;
}

.search-box .search-button {
    width: 120px;
    height: 60px;
    background-color: var(--main-color);
    color: white;
    font-family: var(--ff-heading);
    font-size: 18px;
    font-weight: 600;
    border: none;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background 0.3s ease;
}

.search-box .search-button:hover {
    background-color: #c0392b;
}

.search-box .search-button i {
    margin-right: 8px;
    font-size: 16px;
}

/* Cart Badge */
.cart {
    position: relative;
    display: flex;
    align-items: center;
    gap: 5px;
}

.cart i {
    font-size: 20px;
    color: var(--dark-color);
}
.cart .btn-badge {
    display: flex;
    align-items: center;
    justify-content: center;
    position: absolute;
    top: -10px;
    right: -10px;
    background-color: var(--main-color);
    color: white;
    font-family: var(--ff-body);
    font-size: 12px;
    font-weight: 600;
    min-width: 20px;
    height: 20px;
    border-radius: 50%;
    padding: 2px;
}

/* User Product show */
.centered {
    color: white;
    font-weight: bold;
    margin-top: 15px;
    text-align: center;
    font-family: var(--ff-body);
}

/* Quick links section */
.quick-links {
    display: flex;
    justify-content: center;
    gap: 20px;
    margin-top: 20px;
}

.quick-link {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 10px 20px;
    background-color: rgba(255, 255, 255, 0.1);
    border-radius: 50px;
    transition: all 0.3s ease;
}

.quick-link:hover {
    background-color: rgba(255, 255, 255, 0.2);
}

.quick-link i {
    font-size: 18px;
    color: white;
}

.quick-link span {
    color: white;
    font-family: var(--ff-heading);
    font-size: 16px;
    font-weight: 500;
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .navbar {
        flex-direction: column;
        gap: 20px;
    }
    
    .navbar .nav-list {
        flex-wrap: wrap;
        justify-content: center;
        gap: 15px;
    }
    
    .content h1 {
        font-size: 32px;
    }
    
    .content p {
        font-size: 16px;
    }
    
    .search-box {
        flex-direction: column;
        border-radius: 10px;
    }
    
    .search-box input {
        border-radius: 10px 10px 0 0;
    }
    
    .search-box .search-button {
        width: 100%;
        border-radius: 0 0 10px 10px;
    }
}
   </style>
</head>

<body>
	<%
	/* Checking the user credentials */
	String userType = (String) session.getAttribute("usertype");
	if (userType == null) { //LOGGED OUT
	%>
    <header id="header">
        <div class="container">
            <nav class="navbar">
                <div class="logo-part">
                    <a href="index.jsp">
                        <h2>Redline</h2>
                    </a>
                    
                </div>


                <ul class="nav-list">
                    <li><a href="login.jsp" class="login-link"><i class="fas fa-sign-in-alt"></i> Login</a></li>
                    <li><a href="Register.jsp" class="register-link"><i class="fas fa-user-plus"></i> Register</a></li>
                    <li><a href="contact.jsp"><i class="fas fa-info-circle"></i> About Us</a></li>
                    <li><a href="index.jsp"><i class="fas fa-car-alt"></i> Parts</a></li>
                    <li class="category"><a href="#"><i class="fas fa-list"></i> Categories <i class="fas fa-caret-down"></i></a>
                        <div class="dropdown-menu">
                            <ul>
                                <li><a href="index.jsp?type=engine">Engine Parts</a></li>
                                <li><a href="index.jsp?type=brakes">Brake Systems</a></li>
                                <li><a href="index.jsp?type=suspension">Suspension</a></li>
                                <li><a href="index.jsp?type=electrical">Electrical</a></li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </nav>
        </div>
    </header>
    <%
	} else if ("customer".equalsIgnoreCase(userType)) { //CUSTOMER HEADER

	int notf = new CartService().getCartCount((String) session.getAttribute("username"));
	%>
	<header id="header">
        <div class="container">
            <nav class="navbar">
                <div class="logo-part">
                    <a href="">
                         <h2>Redline</h2>
                    </a>
                   
                </div>


                <ul class="nav-list">
                 	<li><a href="userHome.jsp" class="product-link"><i class="fas fa-car-alt"></i> Parts</a></li>
                    <li class="category"><a href="#"><i class="fas fa-list"></i> Categories <i class="fas fa-caret-down"></i></a>
                        <div class="dropdown-menu">
                            <ul>
                                <li><a href="userHome.jsp?type=engine">Engine Parts</a></li>
                                <li><a href="userHome.jsp?type=brakes">Brake Systems</a></li>
                                <li><a href="userHome.jsp?type=suspension">Suspension</a></li>
                                <li><a href="userHome.jsp?type=electrical">Electrical</a></li>
                            </ul>
                        </div>
                    </li>
                    <%
					if (notf == 0) {
					%>
                    <li><a href="cartDetails.jsp" class="cart cart-link">
                        <i class="fas fa-shopping-cart"></i>
                        <span class="btn-badge">0</span>
                    </a></li>
                    <%
					} else {
					%>
					 <li><a href="cartDetails.jsp" class="cart cart-link">
                        <i class="fas fa-shopping-cart"></i>
                        <span class="btn-badge"><%=notf%></span>
                    </a></li>
                    <%
					}
					%>
                    <li><a href="orderDetails.jsp" class="order-link"><i class="fas fa-clipboard-list"></i> Orders</a></li>
                    <li><a href="userProfile.jsp"><i class="fas fa-user-circle"></i> Profile</a></li>
                    <li><a href="contact.jsp"><i class="fas fa-info-circle"></i> About Us</a></li>
                    <li><a href="./LogoutSrv"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                    
                </ul>
            </nav>
        </div>
    </header>
    <%
	} else { //ADMIN HEADER
	%>
	 <header id="header">
        <div class="container">
            <nav class="navbar">
                <div class="logo-part">
                    <a href="">
  						<h2>Redline</h2>
                    </a>
                  
                </div>


                <ul class="nav-list">
                    <li><a href="adminViewProduct.jsp" class="product-link"><i class="fas fa-car-alt"></i> Parts</a></li>
                    <li class="category"><a href="#"><i class="fas fa-list"></i> Categories <i class="fas fa-caret-down"></i></a>
                        <div class="dropdown-menu">
                            <ul>
                                <li><a href="adminViewProduct.jsp?type=engine">Engine Parts</a></li>
                                <li><a href="adminViewProduct.jsp?type=brakes">Brake Systems</a></li>
                                <li><a href="adminViewProduct.jsp?type=suspension">Suspension</a></li>
                                <li><a href="adminViewProduct.jsp?type=electrical">Electrical</a></li>
                            </ul>
                        </div>
                    </li>                    
                    <li><a href="adminStock.jsp" class="stock-link"><i class="fas fa-boxes"></i> Stock</a></li>
                    <li><a href="shippedItems.jsp" class="shipped-link"><i class="fas fa-truck"></i> Shipped</a></li>
                    <li><a href="unShippedItems.jsp" class="unshipped-link"><i class="fas fa-clock"></i> Orders</a></li>

                    <li class="category"><a href="#"><i class="fas fa-edit"></i> Manage <i class="fas fa-caret-down"></i></a>
                        <div class="dropdown-menu">
                            <ul>
                                <li><a href="addProduct.jsp" class="add-product-link"><i class="fas fa-plus-circle"></i> Add Part</a></li>
                                <li><a href="removeProduct.jsp"><i class="fas fa-trash-alt"></i> Delete Part</a></li>
                                <li><a href="updateProductById.jsp"><i class="fas fa-sync-alt"></i> Update Part</a></li>
                            </ul>
                        </div>
                    </li>

                    <li><a href="./LogoutSrv"><i class="fas fa-sign-out-alt"></i> Logout</a></li>

                    
                </ul>
            </nav>
        </div>
    </header>
    <%
	}
	%>
    <div class="search">
        <div class="container">
            <div class="content">
                <h1>FIND THE RIGHT PARTS FAST</h1>
                <p>Quality automotive parts for every make and model - guaranteed to fit and built to last</p>
            </div>
           
            <form action="index.jsp" method="get">
                <div class="search-container">
                    <div class="search-box">
                        <input type="text" name="search" placeholder="Search by part name, number, or vehicle...">
                        <button type="submit" class="search-button">
                            <i class="fas fa-search"></i> SEARCH
                        </button>
                    </div>
                </div>
            </form>
            
            
            <p id="message" class="centered"></p>
        </div>
    </div>
    
    <script src="./js/script.js"></script>
</body>

</html>