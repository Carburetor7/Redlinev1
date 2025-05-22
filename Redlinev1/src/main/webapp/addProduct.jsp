<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add New Part - AutoParts Hub</title>
<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<style>
    .add-product.container {
        max-width: 1280px;
        margin: 50px auto 100px;
        padding: 15px;
        font-family: 'Roboto', sans-serif;
    }

    /* Row styles */
    .add-product .row {
        margin: 5px 2px;
        display: flex;
        flex-wrap: wrap;
    }
    
    .add-product .sub-row {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        margin-bottom: 15px;
    }

    /* Form styles */
    .add-product form {
        width: 100%;
        max-width: 700px;
        margin: 0 auto;
        border-radius: 8px;
        background-color: #fff;
        padding: 30px;
        box-shadow: 0 5px 25px rgba(0,0,0,0.1);
    }

    /* Form group styles */
    .add-product .form-group {
        margin-bottom: 20px;
    }

    /* Heading styles */
    .add-product h2 {
        color: #2c3e50;
        margin-bottom: 30px;
        font-family: 'Oswald', sans-serif;
        font-weight: 700;
        font-size: 28px;
        text-transform: uppercase;
        text-align: center;
        position: relative;
        padding-bottom: 15px;
    }
    
    .add-product h2:after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 80px;
        height: 3px;
        background: #e74c3c;
    }

    /* Label styles */
    .add-product label {
        font-weight: 600;
        color: #2c3e50;
        display: block;
        margin-bottom: 8px;
        font-size: 15px;
    }

    /* Input styles */
    .add-product input[type="text"],
    .add-product input[type="number"],
    .add-product select,
    .add-product textarea {
        width: 100%;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: 6px;
        box-sizing: border-box;
        font-family: 'Roboto', sans-serif;
        font-size: 14px;
        transition: border-color 0.3s, box-shadow 0.3s;
    }
    
    .add-product input[type="text"]:focus,
    .add-product input[type="number"]:focus,
    .add-product select:focus,
    .add-product textarea:focus {
        border-color: #3498db;
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        outline: none;
    }
    
    .add-product textarea {
        min-height: 120px;
        resize: vertical;
    }

    /* File input styles - simplified */
    .add-product .file-input-container {
        margin-top: 10px;
    }
    
    .add-product input[type="file"] {
        margin-top: 10px;
    }
    
    .add-product .file-name {
        margin-top: 10px;
        font-size: 13px;
        color: #7f8c8d;
    }

    /* Button styles */
    .add-product .btn {
        padding: 12px 24px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-size: 16px;
        font-weight: 600;
        font-family: 'Oswald', sans-serif;
        text-transform: uppercase;
        letter-spacing: 1px;
        transition: all 0.3s ease;
    }

    /* Button danger styles */
    .add-product .btn-reset {
        background-color: #7f8c8d;
        color: white;
    }
    
    .add-product .btn-reset:hover {
        background-color: #95a5a6;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(127, 140, 141, 0.3);
    }

    /* Button success styles */
    .add-product .btn-success {
        background-color: #e74c3c;
        color: white;
    }
    
    .add-product .btn-success:hover {
        background-color: #c0392b;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
    }

    /* Column */
    .add-product .col-md-6 {
        flex: 1;
        min-width: 250px;
    }
    
    /* Success message */
    .success-message {
        color: #27ae60;
        background-color: rgba(39, 174, 96, 0.1);
        padding: 15px;
        border-radius: 6px;
        text-align: center;
        margin-bottom: 20px;
        font-weight: 500;
    }
    
    /* Text center */
    .text-center {
        text-align: center;
    }
    
    /* Add product link */
    .add-product-link {
        text-decoration: underline;
        color: #3498db;
    }
    
    /* Responsive adjustments */
    @media (max-width: 768px) {
        .add-product .sub-row {
            flex-direction: column;
            gap: 15px;
        }
        
        .add-product form {
            padding: 20px;
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
	<%
	String message = request.getParameter("message");
	%>
	<div class="container add-product">
        <div class="row">
            <form action="./AddProductSrv" method="post" enctype="multipart/form-data">
                <h2>Add New Part</h2>
                <% if (message != null) { %>
                <div class="success-message"><%=message%></div>
                <% } %>
                
                <div class="sub-row">
                    <div class="col-md-6 form-group">
                        <label for="product-name">Part Name</label>
                        <input type="text" placeholder="Enter part name" name="name" id="product-name" required>
                    </div>
                    <div class="col-md-6 form-group">
                        <label for="product-type">Category</label>
                        <select name="type" id="product-type" required>
                            <option value="">Select a category</option>
                            <option value="engine">Engine Parts</option>
                            <option value="brakes">Brake Systems</option>
                            <option value="suspension">Suspension</option>
                            <option value="electrical">Electrical</option>
                           
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="product-description">Part Description</label>
                    <textarea name="info" id="product-description" placeholder="Enter detailed description of the part, including specifications and compatibility" required></textarea>
                </div>
                
                <div class="sub-row">
                    <div class="col-md-6 form-group">
                        <label for="unit-price">Unit Price (₹)</label>
                        <input type="number" placeholder="Enter unit price" name="price" id="unit-price" min="0" step="0.01" required>
                    </div>
                    <div class="col-md-6 form-group">
                        <label for="stock-quantity">Stock Quantity</label>
                        <input type="number" placeholder="Enter stock quantity" name="quantity" id="stock-quantity" min="0" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="product-image">Part Image</label>
                    <div class="file-input-container">
                        <input type="file" name="image" id="product-image" accept="image/*" required>
                    </div>
                </div>
                
                <div class="sub-row">
                    <div class="col-md-6 text-center">
                        <button type="reset" class="btn btn-reset">
                            <i class="fas fa-undo"></i> Reset
                        </button>
                    </div>
                    <div class="col-md-6 text-center">
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-plus-circle"></i> Add Part
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>