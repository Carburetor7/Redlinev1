<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="services.impl.*, services.*,models.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Part - AutoParts Hub</title>
<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<style>
.update.container {
    width: 100%;
    max-width: 900px;
    margin: 50px auto 100px;
    padding: 30px;
    font-family: 'Roboto', sans-serif;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

.update .text-center {
    text-align: center;
}

.update .form-group {
    margin-bottom: 20px;
}

/* Form-specific styles */
.update #formHeader {
    margin-bottom: 25px;
}

.update #formTitle {
    color: #2c3e50;
    font-family: 'Oswald', sans-serif;
    font-weight: 700;
    font-size: 28px;
    text-transform: uppercase;
    letter-spacing: 1px;
    margin-top: 15px;
    position: relative;
    padding-bottom: 15px;
    display: inline-block;
}

.update #formTitle:after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 60px;
    height: 3px;
    background: #e74c3c;
}

.update #formMessage {
    color: #3498db;
    margin-top: 15px;
    font-weight: 500;
}

.update .form-control {
    width: 100%;
    padding: 12px 15px;
    border-radius: 6px;
    border: 1px solid #ddd;
    font-family: 'Roboto', sans-serif;
    font-size: 15px;
    transition: all 0.3s ease;
}

.update .form-control:focus {
    border-color: #3498db;
    box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
    outline: none;
}

.update textarea.form-control {
    min-height: 120px;
    resize: vertical;
}

.update .form-row {
    display: flex;
    flex-wrap: wrap;
    margin-bottom: 20px;
    gap: 20px;
}

.update .form-group-half {
    flex: 1;
    min-width: 250px;
}

.update .form-group-third {
    flex: 1;
}

.update label {
    display: block;
    margin-bottom: 8px;
    font-weight: 600;
    color: #2c3e50;
    font-size: 15px;
}

.update .btn {
    padding: 12px 24px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 16px;
    font-weight: 600;
    font-family: 'Oswald', sans-serif;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    transition: all 0.3s ease;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    min-width: 150px;
}

.update .btn-danger {
    background-color: #7f8c8d;
    color: #fff;
}

.update .btn-danger:hover {
    background-color: #95a5a6;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(127, 140, 141, 0.3);
}

.update .btn-success {
    background-color: #e74c3c;
    color: #fff;
}

.update .btn-success:hover {
    background-color: #c0392b;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
}

.update .row-data {
    gap: 20px;
}

.update .product-image-container {
    text-align: center;
    margin-bottom: 20px;
}

.update .product-image {
    border-radius: 8px;
    border: 1px solid #eee;
    object-fit: cover;
    max-height: 150px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
}

.update .file-input-container {
    margin-top: 20px;
    border: 2px dashed #ddd;
    padding: 25px;
    text-align: center;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.3s ease;
}

.update .file-input-container:hover {
    border-color: #3498db;
    background-color: rgba(52, 152, 219, 0.05);
}

.update .file-input-icon {
    font-size: 30px;
    color: #95a5a6;
    margin-bottom: 10px;
}

.update input[type="file"] {
    margin-top: 10px;
}

/* Responsive styles */
@media (max-width: 768px) {
    .update .container {
        padding: 20px;
    }
    
    .update .form-row.text-center {
        flex-direction: column;
        gap: 15px;
    }
    
    .update .btn {
        width: 100%;
    }
}
</style>
</head>
<body>
    <%
    /* Checking the user credentials */
    String utype = (String) session.getAttribute("usertype");
    String uname = (String) session.getAttribute("username");
    String prodid = request.getParameter("prodid");
    Product product = new ProductService().getProductDetails(prodid);
    if (prodid == null || product == null) {
        response.sendRedirect("updateProductById.jsp?message=Please Enter a valid part ID");
        return;
    } else if (utype == null || !utype.equals("admin")) {
        response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");
        return;
    } else if (uname == null) {
        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
        return;
    }
    %>
    
    <jsp:include page="header.jsp" />
    <%
    String message = request.getParameter("message");
    %>
    <div class="container update">
        <div class="row" id="formRow">
            <form action="./UpdateProductSrv" method="post" id="updateForm" enctype="multipart/form-data">
                <div id="formHeader" class="text-center">
                    <div class="product-image-container">
                        <img src="./ShowImage?pid=<%=product.getProdId()%>" alt="<%=product.getProdName()%>" class="product-image" />
                    </div>
                    <h2 id="formTitle">Update Part Details</h2>
                    <% if (message != null) { %>
                    <p id="formMessage"><%=message%></p>
                    <% } %>
                </div>
                
                <input type="hidden" name="pid" class="form-control" value="<%=product.getProdId()%>" required>
                
                <div class="form-row row-data">
                    <div class="form-group-half">
                        <label for="productName">Part Name</label>
                        <input type="text" placeholder="Enter part name" name="name" class="form-control" value="<%=product.getProdName()%>" required>
                    </div>
                    <div class="form-group-half">
                        <% String ptype = product.getProdType(); %>
                        <label for="productType">Category</label>
                        <select name="type" id="productType" class="form-control" required>
                            <option value="engine" <%="engine".equalsIgnoreCase(ptype) ? "selected" : "" %>>Engine Parts</option>
                            <option value="brakes" <%="brakes".equalsIgnoreCase(ptype) ? "selected" : "" %>>Brake Systems</option>
                            <option value="suspension" <%="suspension".equalsIgnoreCase(ptype) ? "selected" : "" %>>Suspension</option>
                            <option value="electrical" <%="electrical".equalsIgnoreCase(ptype) ? "selected" : "" %>>Electrical</option>
                            
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="productDescription">Part Description</label>
                    <textarea name="info" class="form-control text-align-left" id="productDescription" placeholder="Enter detailed description of the part, including specifications and compatibility" required><%=product.getProdInfo()%></textarea>
                </div>
                
                <div class="form-row row-data">
                    <div class="form-group-half">
                        <label for="unitPrice">Unit Price (₹)</label>
                        <input type="number" value="<%=product.getProdPrice()%>" placeholder="Enter unit price" name="price" class="form-control" id="unitPrice" required>
                    </div>
                    <div class="form-group-half">
                        <label for="stockQuantity">Stock Quantity</label>
                        <input type="number" value="<%=product.getProdQuantity()%>" placeholder="Enter stock quantity" class="form-control" id="stockQuantity" name="quantity" min="0" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="product-image">Update Part Image</label>
                    <div class="file-input-container">
                        <i class="fas fa-cloud-upload-alt file-input-icon"></i>
                        <p>Click to upload a new image or drag & drop</p>
                        <input type="file" name="image" id="product-image">
                    </div>
                </div>
                
                <div class="form-row text-center row-data">
                    <div class="form-group-third">
                        <button formaction="adminViewProduct.jsp" class="btn btn-danger">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                    </div>
                    <div class="form-group-third">
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-save"></i> Update Part
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>