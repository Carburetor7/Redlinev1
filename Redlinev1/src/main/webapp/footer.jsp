<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Footer</title>
    <script src="https://kit.fontawesome.com/1165876da6.js" crossorigin="anonymous"></script>
    <style>
        footer {
            background: #2c3e50;
            padding-top: 50px;
            font-family: 'Oswald', sans-serif;
            font-size: 16px;
            color: white;
        }

        footer .container {
            max-width: 1280px;
            margin-inline: auto;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            padding: 0 20px;
        }

        .footer-content {
            width: 33.3%;
            padding: 0 15px;
            margin-bottom: 30px;
        }

        .footer-content h3 {
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 20px;
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 1px;
            position: relative;
            padding-bottom: 10px;
        }
        
        .footer-content h3:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 50px;
            height: 3px;
            background: #e74c3c;
        }

        .footer-content p {
            margin: auto;
            padding: 7px;
            line-height: 1.6;
            font-family: 'Roboto', sans-serif;
            font-size: 15px;
        }

        .footer-content ul {
            text-align: center;
        }

        .footer-content .list {
            padding: 0;
        }

        .footer-content .list li {
            width: auto;
            text-align: center;
            list-style-type: none;
            padding: 7px;
            position: relative;
            transition: transform 0.3s ease;
        }
        
        .footer-content .list li:hover {
            transform: translateY(-3px);
        }

        .footer-content .list li::before {
            content: '';
            position: absolute;
            transform: translate(-50%, -50%);
            left: 50%;
            top: 100%;
            width: 0;
            height: 2px;
            background: #e74c3c;
            transition-duration: .3s;
        }

        .footer-content .list li:hover::before {
            width: 70px;
        }

        .footer-content .social-icons {
            text-align: center;
            padding: 0;
            margin-top: 10px;
        }

        .footer-content .social-icons li {
            display: inline-block;
            text-align: center;
            padding: 8px;
            margin: 0 5px;
        }

        .footer-content .social-icons i {
            color: white;
            font-size: 24px;
            transition: transform 0.3s ease, color 0.3s ease;
        }
        
        .footer-content .social-icons i:hover {
            transform: scale(1.2);
        }

        footer a {
            text-decoration: none;
            color: white;
            font-family: 'Roboto', sans-serif;
            transition: color 0.3s ease;
        }

        footer a:hover {
            color: #e74c3c;
        }

        footer .social-icons i:hover {
            color: #e74c3c;
        }

        footer .bottom-bar {
            background: #e74c3c;
            text-align: center;
            padding: 15px 0;
            margin-top: 30px;
        }

        footer .bottom-bar p {
            color: white;
            margin: 0;
            font-size: 14px;
            padding: 0;
            font-weight: 500;
            letter-spacing: 0.5px;
        }
        
        @media (max-width: 768px) {
            .footer-content {
                width: 100%;
                margin-bottom: 30px;
            }
            
            footer .container {
                flex-direction: column;
            }
        }
    </style>
</head>

<body>
    <footer>
        <div class="container">
            <div class="footer-content">
                <h3>Contact Us</h3>
                <p>Email: redline@gmail.com</p>
                <p>Phone: 9824232424 </p>
                <p>Address: Kamal Pokhari, Kathmandu</p>
            </div>
            <div class="footer-content">
                <h3>Quick Links</h3>
                <ul class="list">
                    <li><a href="">Parts Catalog</a></li>
                    <li><a href="">About Us</a></li>
                    <li><a href="">Login</a></li>
                    <li><a href="">Register</a></li>
                    <li><a href="">Contact</a></li>
                </ul>
            </div>
            <div class="footer-content">
                <h3>Follow Us</h3>
                <ul class="social-icons">
                    <li><a href=""><i class="fab fa-facebook"></i></a></li>
                    <li><a href=""><i class="fab fa-twitter"></i></a></li>
                    <li><a href=""><i class="fab fa-instagram"></i></a></li>
                    <li><a href=""><i class="fab fa-linkedin"></i></a></li>
                </ul>
            </div>
        </div>
        <div class="bottom-bar">
            <p>&copy; 2025 Redline. All rights reserved</p>
        </div>
    </footer>
</body>

</html>