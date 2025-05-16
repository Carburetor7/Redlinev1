<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="services.impl.*, services.*,models.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Products</title>
<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" />
<style>
.blogs.container {
    max-width: 1280px;
    margin-inline: auto;
    padding: 0 20px;
}

.blogs a {
    text-decoration: none;
    font-size: 18px;
    font-weight: 500;
    font-family: "Oswald", sans-serif;
    color: var(--black);
    transition: color 0.3s ease;
}

.blogs a:hover {
    color: var(--red);
    cursor: pointer;
}

.blogs li {
    list-style: none;
}

.section.blogs {
    padding-block: 5rem;
    background-color: var(--gray-2);
}
  
.blogs .container .section-title {
    text-align: center;
    margin-bottom: 40px;
    color: var(--black);
    font-family: "Oswald", sans-serif;
    font-size: 2rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    padding-bottom: 15px;
    position: relative;
}

.blogs .container .section-title:after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 80px;
    height: 3px;
    background-color: var(--red);
}
  
.blogs .grid-list {
    display: grid;
    gap: 2rem;
    padding: 0;
    margin: 0;
}

.blogs .container .grid-list {
    grid-template-columns: repeat(3, 1fr);
}
  
.blogs .container .grid-list .blog-card {
    position: relative;
    background-color: #FFF;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.blogs .container .grid-list .blog-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
}
  
.img-holder {
    position: relative;
    aspect-ratio: var(--width) / var(--height);
    overflow: hidden;
}

.img-cover {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.5s ease;
}

.blog-card:hover .img-cover {
    transform: scale(1.05);
}
  
a, img, span, button, i {
    display: block;
}
  
.blogs .container .grid-list .blog-card .card-content {
    padding: 1.8rem 1.5rem;
}
  
.blogs .h3 {
    font-size: 1.5rem;
    margin-top: 0;
}
  
.blogs :is(.h1, .h2, .h3, p) {
    font-family: "Oswald", sans-serif;
}
  
.blogs .btn {
    display: flex;
    justify-content: center;
    align-items: center;
    color: #FFFFFF;
    font-family: "Roboto", sans-serif;
    font-size: 0.95rem;
    text-align: center;
    border-radius: 6px;
    overflow: hidden;
    transition: all 0.3s ease;
    line-height: 3rem;
    padding: 0 1.2rem;
    gap: 0.8rem;
    font-weight: 600;
    cursor: pointer;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    width: 48%;
    box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
    border: none;
}
  
.blogs .add {
    background-color: #e74c3c;
    color: white;
}

.blogs .add:hover {
    background-color: #c0392b;
}
  
.blogs .container .grid-list .blog-card .card-content .btn-blue {
    background-color: #3498db;
    color: white;
}

.blogs .container .grid-list .blog-card .card-content .btn-blue:hover {
    background-color: #2980b9;
}
  
.blogs .product-title {
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 1;
    overflow: hidden;
    text-decoration: none;
    font-size: 20px;
    font-weight: 700;
    font-family: "Oswald", sans-serif;
    color: var(--black);
    margin-block-end: 12px;
}
  
.blogs .product-description {
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2;
    overflow: hidden;
    text-decoration: none;
    font-size: 16px;
    font-weight: 400;
    font-family: "Roboto", sans-serif;
    color: #555;
    text-align: left;
    line-height: 1.5;
    margin-block-end: 15px;
}
  
.blogs .price {
    display: inline-block;
    text-decoration: none;
    font-size: 22px;
    font-weight: 700;
    font-family: "Oswald", sans-serif;
    color: #e74c3c;
    margin-block-end: 20px;
    position: relative;
}

.blogs .price:before {
    content: "RS ";
    font-size: 16px;
    font-weight: 600;
}
  
.blogs .product-btn-form {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 10px;
    margin-top: 15px;
}

.product-link {
    text-decoration: underline;
    color: #3498db;
}

/* Responsive adjustments */
@media (max-width: 1024px) {
    .blogs .container .grid-list {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 768px) {
    .blogs .container .grid-list {
        grid-template-columns: 1fr;
    }
    
    .blogs .container .section-title {
        font-size: 1.8rem;
    }
    
    .blogs .product-btn-form {
        flex-direction: column;
        gap: 10px;
    }
    
    .blogs .btn {
        width: 100%;
    }
}
</style>
</head>
<body>
	<%
	/* Checking the user credentials */
	String userName = (String) session.getAttribute("username");
	String userType = (String) session.getAttribute("usertype");

	if (userType == null || !userType.equals("admin")) {
		response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");
	}
	else if (userName == null) {
		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
	}

	ProductService prodDao = new ProductService();
	List<Product> products = new ArrayList<Product>();

	String search = request.getParameter("search");
	String type = request.getParameter("type");
	String message = "All Products";
	if (search != null) {
		products = prodDao.searchAllProducts(search);
		message = "Showing Results for '" + search + "'";
	} else if (type != null) {
		products = prodDao.getAllProductsByType(type);
		message = "Showing Results for '" + type + "'";
	} else {
		products = prodDao.getAllProducts();
	}
	if (products.isEmpty()) {
		message = "No items found for the search '" + (search != null ? search : type) + "'";
		products = prodDao.getAllProducts();
	}
	%>
	<jsp:include page="header.jsp" />
	<section class="section blogs">
        <div class="container">
            <h2 class="h2 section-title"><%=message%></h2>
            <ul class="grid-list">
            	<%
				for (Product product : products) {
				%>
                <li>
                    <div class="blog-card">
                        <figure class="card-banner img-holder" style="--width: 410; --height: 260">
                            <img src="./ShowImage?pid=<%=product.getProdId()%>" width="410" height="260" loading="lazy" class="img-cover"
                                alt="<%=product.getProdName()%>" />
                        </figure>

                        <div class="card-content">
                            <h3 class="h3 product-title">
                                <%=product.getProdName()%>
                            </h3>
                            <%
								String description = product.getProdInfo();
								description = description.substring(0, Math.min(description.length(), 100));
							%>
                            <p class="product-description"><%=description%></p>
                            <h4 class="price"><%=product.getProdPrice()%></h4>
                            <form method="post" action="" class="product-btn-form">
                                <button type="submit" formaction="./RemoveProductSrv?prodid=<%=product.getProdId()%>" class="btn add"><span class="span">Remove</span></button>

                                <button type="submit" formaction="updateProduct.jsp?prodid=<%=product.getProdId()%>" class="btn btn-blue"><span class="span">Update</span></button>
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