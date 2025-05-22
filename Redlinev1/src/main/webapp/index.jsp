<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="services.impl.*, services.*,models.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AutoParts Hub</title>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<style>
/* Auto Parts Product Display Styling */
.products.container{
    max-width: 1280px;
    margin: 0 auto;
    padding: 0 20px;
}

.products a{
    text-decoration: none;
    font-size: 18px;
    font-weight: 600;
    font-family: 'Montserrat', sans-serif;
    color: var(--black);
    transition: color 0.25s ease;
}

.products a:hover{
    color: var(--red);
    cursor: pointer;
}

.products li{
    list-style: none;
}

.section.products{
    padding-block: 4rem;
    background-color: var(--gray-2);
}
  
.products .container .section-title {
    position: relative;
    text-align: center;
    margin-bottom: 3rem;
    color: var(--black);
    font-family: 'Montserrat', sans-serif;
    font-size: 2.2rem;
    font-weight: 700;
    letter-spacing: -0.5px;
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
    background-color: var(--red);
    border-radius: var(--radius-3);
}
  
.products .grid-list {
    display: grid;
    gap: 2.5rem;
    padding: 0;
    margin: 0;
}

.products .container .grid-list {
    grid-template-columns: repeat(3, 1fr);
}
  
.products .container .grid-list .product-card {
    position: relative;
    background-color: var(--white);
    border-radius: var(--radius-10);
    overflow: hidden;
    box-shadow: 0 8px 25px var(--black-3);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.products .container .grid-list .product-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 15px 30px var(--black-5);
}
  
.img-holder {
    position: relative;
    aspect-ratio: var(--width) / var(--height);
    overflow: hidden;
    border-bottom: 1px solid var(--gray-2);
}

.img-holder:before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(0deg, var(--black-3) 0%, rgba(0,0,0,0) 50%);
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
    padding: 1.8rem 1.5rem;
}
  
.products .h3 {
    font-size: var(--fs-5);
    margin-top: 0;
}
  
.products :is(.h1, .h2, .h3, p) {
    font-family: 'Montserrat', sans-serif;
}
  
.products .btn {
    display: flex;
    justify-content: center;
    align-items: center;
    color: var(--white);
    font-family: 'Roboto', sans-serif;
    font-size: 0.95rem;
    text-align: center;
    border-radius: var(--radius-5);
    overflow: hidden;
    transition: all 0.3s ease;
    line-height: 3rem;
    width: auto;
    min-width: 130px;
    padding: 0 1.2rem;
    gap: 0.8rem;
    font-weight: 600;
    border: none;
    cursor: pointer;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}
  
.products .add {
    background-color: var(--dark-blue);
    position: relative;
    overflow: hidden;
    z-index: 1;
}

.products .add:hover {
    background-color: var(--blue);
    box-shadow: 0 5px 15px var(--light-blue);
}
  
.products .container .grid-list .product-card .card-content .btn-blue {
    background-color: var(--red);
    position: relative;
    overflow: hidden;
    z-index: 1;
}

.products .container .grid-list .product-card .card-content .btn-blue:hover {
    background-color: #c03529;
    box-shadow: 0 5px 15px rgba(220, 53, 34, 0.3);
}
  
.products .product-title {
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 1;
    overflow: hidden;
    text-decoration: none;
    font-size: 20px;
    font-weight: 700;
    font-family: 'Montserrat', sans-serif;
    color: var(--black);
    margin-block-end: 12px;
    position: relative;
}
  
.products .product-description {
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2;
    overflow: hidden;
    text-decoration: none;
    font-size: 16px;
    font-weight: 400;
    font-family: 'Roboto', sans-serif;
    color: var(--gray-3);
    text-align: left;
    line-height: 1.5;
    margin-block-end: 15px;
}
  
.products .price {
    display: inline-block;
    text-decoration: none;
    font-size: 22px;
    font-weight: 700;
    font-family: 'Montserrat', sans-serif;
    color: var(--red);
    margin-block-end: 20px;
    position: relative;
}

.products .price:before {
    content: "RS ";
    font-size: 16px;
    font-weight: 600;
}
  
.products .product-btn-form {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 12px;
}

/* Part number badge */
.product-card::before {
    content: "Part #";
    position: absolute;
    top: 10px;
    right: 10px;
    background-color: var(--dark-blue);
    color: var(--white);
    padding: 5px 10px;
    font-size: 12px;
    font-weight: 600;
    border-radius: var(--radius-5);
    z-index: 2;
    font-family: 'Montserrat', sans-serif;
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
        font-size: 1.8rem;
    }
    
    .products .product-btn-form {
        flex-direction: column;
        gap: 10px;
    }
    
    .products .btn {
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

	boolean isValidUser = true;

	if (userType == null || userName == null || !userType.equals("customer")) {

		isValidUser = false;
	}

	ProductService prodDao = new ProductService();
	List<Product> products = new ArrayList<Product>();

	String search = request.getParameter("search");
	String type = request.getParameter("type");
	String message = "All Auto Parts";
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
		message = "No parts found for the search '" + (search != null ? search : type) + "'";
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
				%>
                <li>
                    <div class="product-card">
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
                            <form method="post" class="product-btn-form">
                            	<%
									if (cartQty == 0) {
								%>
                                <button type="submit" formaction="./AddtoCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=1" class="btn add"><span class="span">Add to
                                        Cart</span></button>

                                <button type="submit" formaction="./AddtoCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=1" class="btn btn-blue buy"><span class="span">Buy
                                        Now</span></button>
                                <%
									} else {
								%>
								 <button type="submit" formaction="./AddtoCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=0" class="btn add"><span class="span">Remove From
                                        Cart</span></button>

                                <button type="submit" formaction="cartDetails.jsp" class="btn btn-blue buy"><span class="span">Checkout</span></button>
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