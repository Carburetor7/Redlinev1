<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="services.impl.*, services.*,models.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>User Profile - AutoParts Hub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        .profile.container {
            max-width: 900px;
            width: 100%;
            margin: 50px auto 100px;
            padding: 0 20px;
            font-family: 'Roboto', sans-serif;
        }
        
        .wrapper {
            display: flex;
            flex-wrap: wrap;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            list-style: none;
            border-radius: 10px;
            overflow: hidden;
            background-color: #fff;
        }

        .wrapper .left {
            width: 35%;
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            padding: 40px 30px;
            text-align: center;
            color: #fff;
            position: relative;
        }
        
        .wrapper .left:before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('https://images.unsplash.com/photo-1527247043589-98e6ac08f56c') center/cover no-repeat;
            opacity: 0.1;
            z-index: 0;
        }
        
        .wrapper .left .content {
            position: relative;
            z-index: 1;
        }

        .wrapper .left img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            margin-bottom: 20px;
            border: 4px solid rgba(255, 255, 255, 0.2);
            object-fit: cover;
        }

        .wrapper .left h4 {
            margin-bottom: 10px;
            font-family: 'Oswald', sans-serif;
            font-weight: 700;
            letter-spacing: 1px;
            font-size: 24px;
            text-transform: uppercase;
        }

        .wrapper .right {
            width: 65%;
            background: #fff;
            padding: 40px 30px;
        }

        .wrapper .right .info,
        .wrapper .right .projects {
            margin-bottom: 30px;
        }

        .wrapper .right .info h3,
        .wrapper .right .projects h3 {
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f5f5f5;
            color: #2c3e50;
            text-transform: uppercase;
            letter-spacing: 2px;
            font-family: 'Oswald', sans-serif;
            font-weight: 600;
            font-size: 18px;
            position: relative;
        }
        
        .wrapper .right .info h3:after,
        .wrapper .right .projects h3:after {
            content: '';
            position: absolute;
            left: 0;
            bottom: -2px;
            width: 60px;
            height: 2px;
            background: #e74c3c;
        }

        .wrapper .right .info_data,
        .wrapper .right .projects_data {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        .wrapper .right .info_data .data,
        .wrapper .right .projects_data .data {
            width: 45%;
            margin-bottom: 15px;
        }

        .wrapper .right .info_data .data h4,
        .wrapper .right .projects_data .data h4 {
            color: #7f8c8d;
            font-size: 13px;
            margin-bottom: 5px;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 500;
        }

        .wrapper .right .info_data .data p,
        .wrapper .right .projects_data .data p {
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 10px;
            color: #2c3e50;
            line-height: 1.4;
        }

        .wrapper .btn {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            color: #fff;
            font-family: 'Oswald', sans-serif;
            font-size: 15px;
            text-align: center;
            border-radius: 6px;
            overflow: hidden;
            transition: all 0.3s ease;
            padding: 12px 24px;
            gap: 8px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border: none;
            cursor: pointer;
        }
        
        .wrapper .btn-blue {
            background-color: #e74c3c;
        }
        
        .wrapper .btn-blue:hover {
            background-color: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
        }
        
        .wrapper .btn i {
            font-size: 16px;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .wrapper {
                flex-direction: column;
            }
            
            .wrapper .left,
            .wrapper .right {
                width: 100%;
            }
            
            .wrapper .right .info_data .data, 
            .wrapper .right .projects_data .data {
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

    UserService dao = new UserService();
    User user = dao.getUserDetails(userName);
    if (user == null)
        user = new User("Test User", 98765498765L, "test@gmail.com", "ABC colony, Patna, bihar", 87659, "lksdjf");
    %>
    <%@ include file="header.jsp"%>
    <div class="container profile">
        <div class="wrapper">
            <div class="left">
                <div class="content">
                    <img src="./img/profile.jpg" alt="user">
                    <h4><%=user.getName()%></h4>
                </div>
            </div>
            <div class="right">
                <div class="info">
                    <h3>User Profile</h3>
                    <div class="info_data">
                        <div class="data">
                            <h4>Full Name</h4>
                            <p><%=user.getName()%></p>
                        </div>
                        <div class="data">
                            <h4>Email</h4>
                            <p><%=user.getEmail()%></p>
                        </div>
                    </div>
                    <div class="info_data">
                        <div class="data">
                            <h4>Phone</h4>
                            <p><%=user.getMobile()%></p>
                        </div>
                        <div class="data">
                            <h4>Address</h4>
                            <p><%=user.getAddress()%></p>
                        </div>
                    </div>
                    <div class="info_data">
                        <div class="data">
                            <h4>Pin code</h4>
                            <p><%=user.getPinCode()%></p>
                        </div>
                    </div>
                    <form method="post">
                        <button type="submit" formaction="updateProfile.jsp?userid=<%=user.getEmail()%>" class="btn btn-blue">
                            <i class="fas fa-user-edit"></i> Update Profile
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
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