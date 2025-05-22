<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="services.impl.*, services.*,models.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout - AutoParts Hub</title>
<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<style>
.payment {
    font-family: 'Roboto', sans-serif;
    background-color: #f5f5f5;
}

/* Container styles */
.payment.container {
    max-width: 1280px;
    margin: 50px auto 100px;
    padding: 0 20px;
}

/* Row styles */
.payment .row {
    margin-top: 15px;
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 20px;
    margin-bottom: 20px;
}

/* Form styles */
.payment form {
    width: 100%;
    max-width: 600px;
    margin: 0 auto;
    border-radius: 10px;
    padding: 30px;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

/* Form group styles */
.payment .form-group {
    margin-bottom: 20px;
    width: 100%;
}

/* Text center */
.payment .text-center {
    text-align: center;
}

/* Heading styles */
.payment h2 {
    color: #2c3e50;
    font-family: 'Oswald', sans-serif;
    font-weight: 700;
    font-size: 28px;
    text-transform: uppercase;
    letter-spacing: 1px;
    margin-bottom: 25px;
    position: relative;
    padding-bottom: 15px;
    display: inline-block;
}

.payment h2:after {
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
.payment label {
    font-weight: 600;
    color: #2c3e50;
    display: block;
    margin-bottom: 8px;
    font-size: 15px;
}

/* Input styles */
.payment input[type="text"],
.payment input[type="number"] {
    width: 100%;
    padding: 12px 15px;
    border: 1px solid #ddd;
    border-radius: 6px;
    box-sizing: border-box;
    font-family: 'Roboto', sans-serif;
    font-size: 15px;
    transition: all 0.3s ease;
}

.payment input[type="text"]:focus,
.payment input[type="number"]:focus {
    border-color: #3498db;
    box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
    outline: none;
}

/* Input container with icon */
.payment .input-container {
    position: relative;
}

.payment .input-icon {
    position: absolute;
    right: 15px;
    top: 50%;
    transform: translateY(-50%);
    color: #95a5a6;
}

/* Card brand icons */
.payment .card-brands {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-bottom: 25px;
}

.payment .card-brand {
    font-size: 30px;
    color: #7f8c8d;
    transition: all 0.3s ease;
}

.payment .card-brand.visa {
    color: #1a1f71;
}

.payment .card-brand.mastercard {
    color: #eb001b;
}

.payment .card-brand.amex {
    color: #2e77bc;
}

.payment .card-brand.discover {
    color: #ff6000;
}

/* Button styles */
.payment button {
    width: 100%;
    padding: 14px;
    border: none;
    border-radius: 6px;
    background-color: #e74c3c;
    color: white;
    font-weight: 600;
    cursor: pointer;
    font-family: 'Oswald', sans-serif;
    font-size: 16px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
}

/* Button hover effect */
.payment button:hover {
    background-color: #c0392b;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
}

/* Security info */
.payment .security-info {
    text-align: center;
    margin-top: 20px;
    color: #7f8c8d;
    font-size: 13px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 5px;
}

.payment .security-info i {
    color: #27ae60;
}

/* Column styling */
.payment .col-md-12 {
    width: 100%;
}

.payment .col-md-6 {
    width: calc(50% - 10px);
}

/* Expiry fields container */
.payment .expiry-fields {
    display: flex;
    gap: 15px;
}

.payment .expiry-fields .form-group {
    flex: 1;
}

/* CVV tooltip */
.payment .cvv-help {
    position: relative;
    display: inline-block;
    margin-left: 5px;
    cursor: help;
}

.payment .cvv-help i {
    color: #3498db;
    font-size: 14px;
}

.payment .cvv-tooltip {
    position: absolute;
    bottom: 100%;
    left: 50%;
    transform: translateX(-50%);
    width: 200px;
    background-color: #34495e;
    color: white;
    text-align: center;
    padding: 8px;
    border-radius: 4px;
    font-size: 12px;
    opacity: 0;
    visibility: hidden;
    transition: all 0.3s ease;
    pointer-events: none;
    margin-bottom: 5px;
}

.payment .cvv-tooltip:after {
    content: '';
    position: absolute;
    top: 100%;
    left: 50%;
    transform: translateX(-50%);
    border-width: 5px;
    border-style: solid;
    border-color: #34495e transparent transparent transparent;
}

.payment .cvv-help:hover .cvv-tooltip {
    opacity: 1;
    visibility: visible;
}

/* Responsive styles */
@media (max-width: 768px) {
    .payment form {
        padding: 20px;
    }
    
    .payment .row {
        flex-direction: column;
    }
    
    .payment .expiry-fields {
        flex-direction: column;
        gap: 20px;
    }
    
    .payment .col-md-6 {
        width: 100%;
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

    String sAmount = request.getParameter("amount");
    double amount = 0;

    if (sAmount != null) {
        amount = Double.parseDouble(sAmount);
    }
    %>
    <jsp:include page="header.jsp" />
    <div class="container payment">
        <div class="row">
            <form action="./OrderServlet" method="post">
                <div class="form-group text-center">
                    <h2>Secure Payment</h2>
                    <div class="card-brands">
                        <i class="fab fa-cc-visa card-brand visa"></i>
                        <i class="fab fa-cc-mastercard card-brand mastercard"></i>
                        <i class="fab fa-cc-amex card-brand amex"></i>
                        <i class="fab fa-cc-discover card-brand discover"></i>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group">
                        <label for="cardholder">Name on Card</label>
                        <div class="input-container">
                            <input type="text" placeholder="Enter cardholder's full name" name="cardholder" id="cardholder" required>
                            <i class="fas fa-user input-icon"></i>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-12">
                        <label for="cardnumber">Card Number</label>
                        <div class="input-container">
                            <input type="number" placeholder="4242 4242 4242 4242" name="cardnumber" id="cardnumber" required>
                            <i class="fas fa-credit-card input-icon"></i>
                        </div>
                    </div>
                </div>
                <div class="expiry-fields">
                    <div class="form-group">
                        <label for="expmonth">Expiry Month</label>
                        <div class="input-container">
                            <input type="number" placeholder="MM" name="expmonth" id="expmonth" size="2" max="12" min="1" required>
                            <i class="fas fa-calendar-alt input-icon"></i>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="expyear">Expiry Year</label>
                        <div class="input-container">
                            <input type="number" placeholder="YYYY" name="expyear" id="expyear" size="4" min="2024" required>
                            <i class="fas fa-calendar-alt input-icon"></i>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label for="cvv">
                            CVV Code
                            <span class="cvv-help">
                                <i class="fas fa-question-circle"></i>
                                <span class="cvv-tooltip">The 3 or 4-digit security code on the back of your card</span>
                            </span>
                        </label>
                        <div class="input-container">
                            <input type="number" placeholder="123" name="cvv" id="cvv" size="3" min="100" max="9999" required>
                            <i class="fas fa-lock input-icon"></i>
                        </div>
                        <input type="hidden" name="amount" value="<%=amount%>">
                    </div>
                    <div class="form-group">
                        <button type="submit">
                            <i class="fas fa-lock"></i> Pay ₹<%=amount%>
                        </button>
                        <div class="security-info">
                            <i class="fas fa-shield-alt"></i> Your payment information is secure
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <%@ include file="footer.jsp"%>
</body>
</html>