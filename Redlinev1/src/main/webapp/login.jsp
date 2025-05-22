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
    <title>Sign In - AutoParts Hub</title>
    <link rel="stylesheet" href="./css/style.css">
    <style>
        .login {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f5f5;
            padding: 50px 0;
        }
        
        .login.container {
            max-width: 430px;
            width: 100%;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            margin: 50px auto 100px;
            overflow: hidden;
        }
        
        .container .registration {
            display: none;
        }
        
        .container .form {
            padding: 2.5rem;
        }
        
        .form header {
            font-size: 2rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 1.5rem;
            font-family: 'Oswald', sans-serif;
            text-transform: uppercase;
            color: #2c3e50;
            position: relative;
            padding-bottom: 12px;
        }
        
        .form header:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: #e74c3c;
        }
        
        .form input {
            height: 60px;
            width: 100%;
            padding: 0 15px;
            font-size: 16px;
            margin-bottom: 1.3rem;
            border: 1px solid #ddd;
            border-radius: 6px;
            outline: none;
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        
        .login .form input:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }
        
        .login .form a {
            font-size: 15px;
            color: #3498db;
            text-decoration: none;
            transition: color 0.3s;
        }
        
        .login .form a:hover {
            color: #e74c3c;
            text-decoration: underline;
        }
        
        .login .form input.button {
            color: #fff;
            background: #e74c3c;
            font-size: 1.1rem;
            font-weight: 600;
            letter-spacing: 1px;
            margin-top: 1.7rem;
            cursor: pointer;
            transition: 0.3s;
            text-transform: uppercase;
            font-family: 'Oswald', sans-serif;
            border: none;
        }
        
        .login .form input.button:hover {
            background: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
        }
        
        .login-link {
            text-align: center;
            margin-top: 20px;
            font-size: 15px;
        }
        
        .login-link a {
            color: #3498db;
            font-weight: 500;
            text-decoration: none;
        }
        
        .login-link a:hover {
            color: #e74c3c;
            text-decoration: underline;
        }
        
        .success-message {
            background-color: rgba(39, 174, 96, 0.1);
            color: #27ae60;
            padding: 12px;
            border-radius: 6px;
            text-align: center;
            margin-bottom: 20px;
            font-weight: 500;
        }
        
        .error-message {
            background-color: rgba(231, 76, 60, 0.1);
            color: #e74c3c;
            padding: 12px;
            border-radius: 6px;
            text-align: center;
            margin-bottom: 20px;
            font-weight: 500;
        }
        
        /* Form icon styling */
        .input-field {
            position: relative;
            margin-bottom: 1.3rem;
        }
        
        .input-field i {
            position: absolute;
            top: 50%;
            right: 15px;
            transform: translateY(-50%);
            color: #95a5a6;
        }
        
        .input-field input {
            margin-bottom: 0;
        }
        
        /* Container background decoration */
        .login-container {
            position: relative;
            overflow: hidden;
        }
        
        @media (max-width: 480px) {
            .login.container {
                width: 90%;
            }
            
            .form {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <%
    String message = request.getParameter("message");
    %>
    <div class="login">
        <div class="container login">
            <div class="login form">
                <header>Sign In</header>
                <%
                if (message != null && !message.isEmpty()) {
                    if (message.equals("valid")) {
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
                <form action="./LoginSrv" method="post">
                    <div class="input-field">
                        <input name="username" type="text" placeholder="Enter your email" required>
                        <i class="fas fa-envelope"></i>
                    </div>
                    <div class="input-field">
                        <input name="password" type="password" placeholder="Enter your password" required>
                        <i class="fas fa-lock"></i>
                    </div>
                    <input type="submit" class="button" value="LOGIN">
                </form>
                <div class="login-link">
                    Don't have an account? <a href="Register.jsp">Register Now</a>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>