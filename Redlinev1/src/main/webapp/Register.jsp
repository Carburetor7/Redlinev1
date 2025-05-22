<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" />
    <title>Create Account - AutoParts Hub</title>
    <link rel="stylesheet" href="./css/style.css">
    <style>
        .register {
            font-family: "Roboto", sans-serif;
            background-color: #f5f5f5;
            padding: 50px 0;
        }

        .register.container {
            position: relative;
            max-width: 700px;
            width: 100%;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin: 50px auto 100px;
        }
        
        .register.container header {
            font-size: 2rem;
            color: #2c3e50;
            font-weight: 700;
            text-align: center;
            margin-bottom: 20px;
            font-family: "Oswald", sans-serif;
            text-transform: uppercase;
            letter-spacing: 1px;
            position: relative;
            padding-bottom: 15px;
        }
        
        .register.container header:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: #e74c3c;
        }
        
        .register.container .form {
            margin-top: 30px;
        }
        
        .register .form .input-box {
            width: 100%;
            margin-top: 20px;
        }
        
        .register .input-box label {
            color: #2c3e50;
            font-weight: 500;
            font-size: 15px;
            display: block;
            margin-bottom: 5px;
        }
        
        .register .form :where(.input-box input, .select-box) {
            position: relative;
            height: 50px;
            width: 100%;
            outline: none;
            font-size: 1rem;
            color: #555;
            margin-top: 8px;
            border: 1px solid #ddd;
            border-radius: 6px;
            padding: 0 15px;
            transition: all 0.3s ease;
        }
        
        .register .input-box input:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }
        
        .register .form .column {
            display: flex;
            column-gap: 15px;
        }
        
        .register .form .gender-box {
            margin-top: 20px;
        }
        
        .register .gender-box h3 {
            color: #2c3e50;
            font-size: 1rem;
            font-weight: 500;
            margin-bottom: 8px;
        }
        
        .register .form :where(.gender-option, .gender) {
            display: flex;
            align-items: center;
            column-gap: 50px;
            flex-wrap: wrap;
        }
        
        .register .form .gender {
            column-gap: 5px;
        }
        
        .register .gender input {
            accent-color: #e74c3c;
        }
        
        .register .form :where(.gender input, .gender label) {
            cursor: pointer;
        }
        
        .register .gender label {
            color: #555;
        }
        
        .register .address :where(input, .select-box) {
            margin-top: 15px;
        }
        
        .register .select-box select {
            height: 100%;
            width: 100%;
            outline: none;
            border: none;
            color: #555;
            font-size: 1rem;
        }
        
        .register .form button {
            height: 55px;
            width: 100%;
            color: #fff;
            font-size: 1.1rem;
            font-weight: 600;
            margin-top: 30px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            background: #e74c3c;
            border-radius: 6px;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-family: "Oswald", sans-serif;
        }
        
        .register .form button:hover {
            background: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
        }
        
        .register-link {
            text-align: center;
            margin-top: 20px;
            font-size: 15px;
        }
        
        .register-link a {
            color: #3498db;
            font-weight: 500;
            text-decoration: none;
        }
        
        .register-link a:hover {
            color: #e74c3c;
            text-decoration: underline;
        }
        
        .success-message {
            background-color: rgba(39, 174, 96, 0.1);
            color: #27ae60;
            padding: 15px;
            border-radius: 6px;
            text-align: center;
            margin: 20px 0;
            font-weight: 500;
        }
        
        .error-message {
            background-color: rgba(231, 76, 60, 0.1);
            color: #e74c3c;
            padding: 15px;
            border-radius: 6px;
            text-align: center;
            margin: 20px 0;
            font-weight: 500;
        }
        
        /* Icon styling */
        .input-box {
            position: relative;
        }
        
        .input-box i {
            position: absolute;
            right: 15px;
            top: 42px;
            color: #95a5a6;
        }
        
        /* Responsive */
        @media screen and (max-width: 500px) {
            .register .form .column {
                flex-wrap: wrap;
            }
            
            .register .form :where(.gender-option, .gender) {
                row-gap: 15px;
            }
            
            .register.container {
                padding: 20px;
                width: 90%;
            }
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp"%>
    <%
    String message = request.getParameter("message");
    %>
    <section class="register">
        <div class="container register">
            <header>Create Your Account</header>
            <%
            if (message != null && !message.isEmpty()) {
                if (message.equals("User Registered Successfully!")) {
            %>	
                    <p class="success-message"><%= message %></p>
            <%
                } else {
            %>
                    <p class="error-message"><%= message %></p>
            <%
                }
            }
            %>
            <form action="./RegisterServlet" method="post" class="form">
                <div class="input-box">
                    <label>Full Name</label>
                    <input name="username" type="text" placeholder="Enter your full name" required />
                    <i class="fas fa-user"></i>
                </div>
                <div class="input-box">
                    <label>Email Address</label>
                    <input name="email" type="email" placeholder="Enter your email address" required />
                    <i class="fas fa-envelope"></i>
                </div>
                <div class="column">
                    <div class="input-box">
                        <label>Phone Number</label>
                        <input name="mobile" type="number" placeholder="Enter your phone number" required />
                        <i class="fas fa-phone"></i>
                    </div>
                    <div class="input-box">
                        <label>Pin Code</label>
                        <input name="pincode" type="number" placeholder="Enter your pin code" required />
                        <i class="fas fa-map-pin"></i>
                    </div>
                </div>
             
                <div class="input-box address">
                    <label>Address</label>
                    <input name="address" type="text" placeholder="Enter your complete address" required />
                    <i class="fas fa-home"></i>
                </div>
                <div class="column">
                    <div class="input-box">
                        <label>Password</label>
                        <input name="password" type="password" placeholder="Create a secure password" required />
                        <i class="fas fa-lock"></i>
                    </div>
                    <div class="input-box">
                        <label>Confirm Password</label>
                        <input name="confirmPassword" type="password" placeholder="Confirm your password" required />
                        <i class="fas fa-check-circle"></i>
                    </div>
                </div>
                <button type="submit">CREATE ACCOUNT</button>
            </form>
            <div class="register-link">
                Already have an account? <a href="login.jsp">Sign In</a>
            </div>
        </div>
    </section>
    <%@ include file="footer.jsp"%>
</body>
</html>