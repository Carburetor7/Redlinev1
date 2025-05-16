<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="services.impl.*, services.*,models.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Remove Part - AutoParts Hub</title>
<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<style>
/* Container styles */
.remove.container {
    max-width: 1280px;
    margin: 50px auto 100px;
    padding: 0 20px;
    font-family: 'Roboto', sans-serif;
}

/* Form styles */
.remove form {
    width: 100%;
    max-width: 500px;
    margin: 0 auto;
    border-radius: 8px;
    background: #fff;
    padding: 30px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

/* Heading styles */
.remove h3 {
    color: #2c3e50;
    margin-bottom: 25px;
    font-family: 'Oswald', sans-serif;
    font-weight: 700;
    font-size: 28px;
    text-transform: uppercase;
    letter-spacing: 1px;
    text-align: center;
    position: relative;
    padding-bottom: 15px;
}

.remove h3:after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 60px;
    height: 3px;
    background: #e74c3c;
}

/* Label styles */
.remove label {
    font-weight: 600;
    color: #2c3e50;
    display: block;
    margin-bottom: 8px;
    font-size: 15px;
}

/* Input styles */
.remove input[type="text"] {
    width: 100%;
    padding: 12px 15px;
    border: 1px solid #ddd;
    border-radius: 6px;
    box-sizing: border-box;
    font-size: 16px;
    margin-bottom: 20px;
    transition: all 0.3s ease;
    font-family: 'Roboto', sans-serif;
}

.remove input[type="text"]:focus {
    border-color: #3498db;
    box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
    outline: none;
}

/* Message styles */
.remove .message {
    margin: 15px 0;
    padding: 12px 15px;
    border-radius: 6px;
    text-align: center;
    font-weight: 500;
}

.remove .success-message {
    background-color: rgba(39, 174, 96, 0.1);
    color: #27ae60;
}

.remove .error-message {
    background-color: rgba(231, 76, 60, 0.1);
    color: #e74c3c;
}

/* Button container */
.remove .button-container {
    display: flex;
    justify-content: space-between;
    margin-top: 25px;
    gap: 15px;
}

/* Button styles */
.remove .btn {
    flex: 1;
    padding: 12px 24px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 16px;
    font-weight: 600;
    font-family: 'Oswald', sans-serif;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
    text-decoration: none;
    gap: 8px;
}

/* Button info styles */
.remove .btn-info {
    background-color: #7f8c8d;
    color: white;
}

.remove .btn-info:hover {
    background-color: #95a5a6;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(127, 140, 141, 0.3);
}

/* Button danger styles */
.remove .btn-danger {
    background-color: #e74c3c;
    color: white;
}

.remove .btn-danger:hover {
    background-color: #c0392b;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
}

/* Form icon */
.remove .input-container {
    position: relative;
}

.remove .input-icon {
    position: absolute;
    top: 50%;
    right: 15px;
    transform: translateY(-50%);
    color: #95a5a6;
}

/* Warning message */
.remove .warning {
    margin-top: 15px;
    padding: 15px;
    background-color: rgba(243, 156, 18, 0.1);
    border-left: 4px solid #f39c12;
    color: #7f8c8d;
    font-size: 14px;
    line-height: 1.5;
    border-radius: 4px;
}

.remove .warning i {
    color: #f39c12;
    margin-right: 10px;
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .remove form {
        padding: 20px;
    }
    
    .remove .button-container {
        flex-direction: column;
    }
    
    .remove .btn {
        width: 100%;
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
    <div class="container remove">
        <form action="./RemoveProductSrv" method="post">
            <h3>Remove Part</h3>
            <% if (message != null) { %>
            <div class="message <%= message.contains("successfully") ? "success-message" : "error-message" %>">
                <%= message %>
            </div>
            <% } %>
            
            <label for="product-id">Part ID</label>
            <div class="input-container">
                <input type="text" placeholder="Enter the part ID to remove" name="prodid" id="product-id" required>
                <i class="fas fa-tools input-icon"></i>
            </div>
            
            <div class="warning">
                <i class="fas fa-exclamation-triangle"></i> Warning: This action cannot be undone. The part will be permanently removed from the database.
            </div>
            
            <div class="button-container">
                <a href="adminViewProduct.jsp" class="btn btn-info">
                    <i class="fas fa-arrow-left"></i> Cancel
                </a>
                <button type="submit" class="btn btn-danger">
                    <i class="fas fa-trash-alt"></i> Remove Part
                </button>
            </div>
        </form>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>