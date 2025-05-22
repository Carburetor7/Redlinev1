<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="services.impl.*, services.*,models.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Update Profile - AutoParts Hub</title>
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        .register {
            font-family: 'Roboto', sans-serif;
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
            font-size: 28px;
            color: #2c3e50;
            font-weight: 700;
            text-align: center;
            font-family: 'Oswald', sans-serif;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 20px;
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
            font-weight: 600;
            font-size: 15px;
            display: block;
            margin-bottom: 8px;
        }
        
        .register .form :where(.input-box input, .select-box) {
            position: relative;
            height: 50px;
            width: 100%;
            outline: none;
            font-size: 16px;
            color: #555;
            margin-top: 8px;
            border: 1px solid #ddd;
            border-radius: 6px;
            padding: 0 15px;
            transition: all 0.3s ease;
            font-family: 'Roboto', sans-serif;
        }
        
        .register .input-box input:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }
        
        .register .form .column {
            display: flex;
            column-gap: 15px;
        }
        
        .register .form button {
            height: 55px;
            width: 100%;
            color: #fff;
            font-size: 16px;
            font-weight: 600;
            margin-top: 30px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s ease;
            background: #e74c3c;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-family: 'Oswald', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .register .form button:hover {
            background: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
        }
        
        .register .form button i {
            font-size: 18px;
        }
        
        .register-link {
            text-decoration: underline;
            color: #3498db;
        }
        
        /* Input icon styling */
        .input-container {
            position: relative;
        }
        
        .input-icon {
            position: absolute;
            top: 50%;
            right: 15px;
            transform: translateY(-50%);
            color: #95a5a6;
        }
        
        /* Read-only field styling */
        .register .input-box input[readonly] {
            background-color: #f5f5f5;
            color: #7f8c8d;
            cursor: not-allowed;
        }
        
        /* Success and error messages */
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
        
        /* Responsive */
        @media screen and (max-width: 500px) {
            .register .form .column {
                flex-wrap: wrap;
                gap: 15px;
            }
            
            .register.container {
                padding: 20px;
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

    UserService dao = new UserService();
    User user = dao.getUserDetails(userName);
    if (user == null)
        user = new User("Test User", 987654765765L, "test@gmail.com", "banewosr", 87659, "lksdjf");
    %>
    <%@ include file="header.jsp"%>
    <%
    String message = request.getParameter("message");
    %>
    <section class="container register">
        <header>Update Profile</header>
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
        <form action="./UpdateProfileSrv" method="post" class="form">
            <div class="input-box">
                <label>Full Name</label>
                <div class="input-container">
                    <input name="username" type="text" placeholder="Enter your full name" value="<%=user.getName()%>" required />
                    <i class="fas fa-user input-icon"></i>
                </div>
            </div>
            <div class="input-box">
                <label>Email Address</label>
                <div class="input-container">
                    <input name="email" type="text" placeholder="Enter your email address" value="<%=user.getEmail()%>" readonly />
                    <i class="fas fa-envelope input-icon"></i>
                </div>
            </div>
            <div class="column">
                <div class="input-box">
                    <label>Phone Number</label>
                    <div class="input-container">
                        <input name="mobile" type="number" placeholder="Enter your phone number" value="<%=user.getMobile()%>" required />
                        <i class="fas fa-phone input-icon"></i>
                    </div>
                </div>
                <div class="input-box">
                    <label>Pin Code</label>
                    <div class="input-container">
                        <input name="pincode" type="number" placeholder="Enter your pin code" value="<%=user.getPinCode()%>" required />
                        <i class="fas fa-map-pin input-icon"></i>
                    </div>
                </div>
            </div>
            
            <div class="input-box address">
                <label>Address</label>
                <div class="input-container">
                    <input name="address" type="text" placeholder="Enter your complete address" value="<%=user.getAddress()%>" required />
                    <i class="fas fa-home input-icon"></i>
                </div>
            </div>
            <button type="submit"><i class="fas fa-save"></i> SAVE CHANGES</button>
        </form>
    </section>
    <%@ include file="footer.jsp"%>
    
    <script>
        // Add active class to profile link in header
        document.addEventListener('DOMContentLoaded', function() {
            // Find all links in nav-list
            const navLinks = document.querySelectorAll('.nav-list a');
            
            // Loop through them to find the profile link
            navLinks.forEach(function(link) {
                if (link.textContent.includes('Profile') || link.classList.contains('profile-link')) {
                    // Add active class to this link
                    link.classList.add('active');
                    
                    // Add the styling if it doesn't exist in header.jsp
                    if (!document.getElementById('active-link-style')) {
                        const style = document.createElement('style');
                        style.id = 'active-link-style';
                        style.textContent = `
                            .nav-list a.active {
                                color: #e74c3c !important;
                                position: relative;
                            }
                            
                            .nav-list a.active:after {
                                content: '';
                                position: absolute;
                                bottom: -5px;
                                left: 0;
                                width: 100%;
                                height: 2px;
                                background-color: #e74c3c;
                            }
                        `;
                        document.head.appendChild(style);
                    }
                }
            });
        });
    </script>
</body>

</html>