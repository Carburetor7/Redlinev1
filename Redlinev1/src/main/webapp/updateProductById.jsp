<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="services.impl.*, services.*,models.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find Part - AutoParts Hub</title>
<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<style>
.update {
    font-family: 'Roboto', sans-serif;
}

.update.container {
    max-width: 600px;
    margin: 80px auto 100px;
    padding: 0 20px;
}

.update .row {
    margin-left: -2px;
    margin-right: -2px;
}

.update .form-wrapper {
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    padding: 40px;
}

.update .form-header {
    text-align: center;
    margin-bottom: 30px;
}

.update .form-header h3 {
    color: #2c3e50;
    font-family: 'Oswald', sans-serif;
    font-weight: 700;
    font-size: 28px;
    text-transform: uppercase;
    letter-spacing: 1px;
    margin-bottom: 15px;
    position: relative;
    padding-bottom: 15px;
}

.update .form-header h3:after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 60px;
    height: 3px;
    background: #e74c3c;
}

.update .form-message {
    color: #3498db;
    font-weight: 500;
    margin-top: 15px;
}

.update .form-group {
    margin-bottom: 25px;
}

.update .form-group label {
    display: block;
    margin-bottom: 8px;
    font-weight: 600;
    color: #2c3e50;
    font-size: 15px;
}

.update .form-control {
    width: 100%;
    padding: 12px 15px;
    border: 1px solid #ddd;
    border-radius: 6px;
    box-sizing: border-box;
    font-family: 'Roboto', sans-serif;
    font-size: 15px;
    transition: all 0.3s ease;
    padding-left: 40px;
}

.update .form-control:focus {
    border-color: #3498db;
    box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
    outline: none;
}

.update .input-icon-wrapper {
    position: relative;
}

.update .input-icon {
    position: absolute;
    left: 15px;
    top: 50%;
    transform: translateY(-50%);
    color: #95a5a6;
}

.update .btn-group {
    display: flex;
    justify-content: space-between;
    margin-top: 30px;
}

.update .btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 12px 24px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 15px;
    text-align: center;
    text-decoration: none;
    transition: all 0.3s ease;
    font-weight: 600;
    font-family: 'Oswald', sans-serif;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    gap: 8px;
    flex: 1;
    margin: 0 10px;
}

.update .btn-info {
    background-color: #7f8c8d;
    color: #fff;
}

.update .btn-info:hover {
    background-color: #95a5a6;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(127, 140, 141, 0.3);
}

.update .btn-danger {
    background-color: #e74c3c;
    color: #fff;
}

.update .btn-danger:hover {
    background-color: #c0392b;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
}

.update .search-icon {
    font-size: 60px;
    color: #34495e;
    margin-bottom: 20px;
    opacity: 0.1;
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .update.container {
        padding: 0 15px;
    }
    
    .update .form-wrapper {
        padding: 30px 20px;
    }
    
    .update .btn-group {
        flex-direction: column;
        gap: 15px;
    }
    
    .update .btn {
        margin: 0;
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
    response.sendRedirect("login.jsp?message=Access Denied, Login As Admin!!");
    return;
} else if (userName == null) {
    response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
    return;
}
%>

<jsp:include page="header.jsp" />
<%
String message = request.getParameter("message");
%>
<div class="container update">
    <div class="row">
        <form action="updateProduct.jsp" method="post" class="col-md-4 offset-md-4 form-wrapper">
            <div class="form-header">
                <i class="fas fa-search search-icon"></i>
                <h3>Find Part to Update</h3>
                <% if (message != null) { %>
                <p class="form-message"><%= message %></p>
                <% } %>
            </div>
            <div class="form-group">
                <label for="prodId">Part ID</label>
                <div class="input-icon-wrapper">
                    <i class="fas fa-tools input-icon"></i>
                    <input type="text" id="prodId" name="prodid" placeholder="Enter the part ID you want to update" class="form-control" required>
                </div>
            </div>
            <div class="btn-group">
                <a href="adminViewProduct.jsp" class="btn btn-info">
                    <i class="fas fa-arrow-left"></i> Cancel
                </a>
                <button type="submit" class="btn btn-danger">
                    <i class="fas fa-search"></i> Find Part
                </button>
            </div>
        </form>
    </div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>