<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>About Us - AutoParts Hub</title>
<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<style>
@import url('https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap');
        
section.about-section {
  position: relative;
  z-index: 0;
  padding-top: 80px;
  padding-bottom: 100px;
  font-family: 'Roboto', sans-serif;
  background-image: url(https://images.unsplash.com/photo-1612353413950-6c40f1401e54?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80) !important;
  background-size: cover;
  background-position: center;
}

section.about-section::after {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
  background-color: rgba(44, 62, 80, 0.85);
  z-index: 1;
}

.container {
  max-width: 1280px;
  margin-left: auto;
  margin-right: auto;
  padding-left: 20px;
  padding-right: 20px;
  position: relative;
  z-index: 2;
}

.section-header {
  margin-bottom: 60px;
  text-align: center;
}

.section-header h2 {
  color: #FFF;
  font-weight: 700;
  font-size: 3em;
  margin-bottom: 20px;
  font-family: 'Oswald', sans-serif;
  text-transform: uppercase;
  letter-spacing: 1px;
  position: relative;
  padding-bottom: 15px;
  display: inline-block;
}

.section-header h2:after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 80px;
  height: 3px;
  background: #e74c3c;
}

.section-header p {
  color: #FFF;
  font-size: 1.1em;
  max-width: 800px;
  margin: 0 auto;
  line-height: 1.6;
}

.row {
  display: flex;
  flex-wrap: wrap;
  align-items: stretch;
  justify-content: space-between;
  gap: 40px;
}

.contact-info {
  width: calc(50% - 20px);
}

.contact-info-item {
  display: flex;
  margin-bottom: 40px;
  background-color: rgba(255, 255, 255, 0.05);
  padding: 25px;
  border-radius: 8px;
  transition: all 0.3s ease;
}

.contact-info-item:hover {
  background-color: rgba(255, 255, 255, 0.1);
  transform: translateY(-5px);
}

.contact-info-icon {
  height: 70px;
  width: 70px;
  background-color: #fff;
  text-align: center;
  border-radius: 50%;
  margin-right: 20px;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
}

.contact-info-icon i {
  font-size: 28px;
  color: #e74c3c;
}

.contact-info-content {
  flex: 1;
}

.contact-info-content h4 {
  color: #3498db;
  font-size: 1.4em;
  margin-bottom: 10px;
  font-family: 'Oswald', sans-serif;
  font-weight: 600;
  letter-spacing: 0.5px;
}

.contact-info-content p {
  color: #FFF;
  font-size: 1em;
  line-height: 1.5;
}

.contact-form {
  background-color: #fff;
  padding: 40px;
  width: calc(50% - 20px);
  border-radius: 8px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
}

.contact-form h2 {
  font-weight: 700;
  font-size: 2em;
  margin-bottom: 20px;
  color: #2c3e50;
  font-family: 'Oswald', sans-serif;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  position: relative;
  padding-bottom: 15px;
}

.contact-form h2:after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  width: 60px;
  height: 3px;
  background: #e74c3c;
}

.contact-form .input-box {
  position: relative;
  width: 100%;
  margin-bottom: 25px;
}

.contact-form .input-box input,
.contact-form .input-box textarea {
  width: 100%;
  padding: 12px 15px;
  font-size: 16px;
  border: 1px solid #ddd;
  border-radius: 6px;
  outline: none;
  resize: none;
  font-family: 'Roboto', sans-serif;
  transition: all 0.3s ease;
}

.contact-form .input-box input:focus,
.contact-form .input-box textarea:focus {
  border-color: #3498db;
  box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
}

.contact-form .input-box textarea {
  min-height: 120px;
}

.contact-form .input-box label {
  position: absolute;
  top: 12px;
  left: 15px;
  color: #7f8c8d;
  pointer-events: none;
  transition: all 0.3s ease;
  font-size: 16px;
  background-color: transparent;
}

.contact-form .input-box input:focus ~ label,
.contact-form .input-box textarea:focus ~ label,
.contact-form .input-box input:valid ~ label,
.contact-form .input-box textarea:valid ~ label {
  top: -10px;
  left: 10px;
  font-size: 12px;
  font-weight: 600;
  color: #3498db;
  background-color: white;
  padding: 0 5px;
}

.contact-form .input-box input[type="submit"] {
  width: 100%;
  background: #e74c3c;
  color: #FFF;
  border: none;
  cursor: pointer;
  padding: 14px;
  font-size: 18px;
  font-weight: 600;
  border-radius: 6px;
  transition: all 0.3s ease;
  font-family: 'Oswald', sans-serif;
  text-transform: uppercase;
  letter-spacing: 1px;
}

.contact-form .input-box input[type="submit"]:hover {
  background: #c0392b;
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
}

/* Company history section */
.company-history {
  background-color: #fff;
  padding: 80px 0;
}

.history-container {
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 20px;
}

.history-header {
  text-align: center;
  margin-bottom: 60px;
}

.history-header h2 {
  color: #2c3e50;
  font-family: 'Oswald', sans-serif;
  font-weight: 700;
  font-size: 2.5em;
  text-transform: uppercase;
  letter-spacing: 1px;
  margin-bottom: 20px;
  position: relative;
  padding-bottom: 15px;
  display: inline-block;
}

.history-header h2:after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 60px;
  height: 3px;
  background: #e74c3c;
}

.history-content {
  display: flex;
  gap: 50px;
  align-items: center;
}

.history-image {
  flex: 1;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

.history-image img {
  width: 100%;
  height: auto;
  display: block;
}

.history-text {
  flex: 1;
}

.history-text h3 {
  color: #3498db;
  font-family: 'Oswald', sans-serif;
  font-size: 1.8em;
  margin-bottom: 20px;
  font-weight: 600;
}

.history-text p {
  color: #555;
  font-size: 1.1em;
  line-height: 1.7;
  margin-bottom: 20px;
}

@media (max-width: 991px) {
  section.about-section {
    padding-top: 60px;
    padding-bottom: 60px;
  }
  
  .row {
    flex-direction: column;
    gap: 30px;
  }
  
  .contact-info {
    width: 100%;
  }
  
  .contact-form {
    width: 100%;
  }
  
  .history-content {
    flex-direction: column;
  }
  
  .history-image {
    margin-bottom: 30px;
  }
}

@media (max-width: 768px) {
  .section-header h2 {
    font-size: 2.5em;
  }
  
  .contact-info-item {
    flex-direction: column;
    align-items: center;
    text-align: center;
  }
  
  .contact-info-icon {
    margin-right: 0;
    margin-bottom: 15px;
  }
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />
	<section class="about-section">
        <div class="container">
            <div class="section-header">
                <h2>About Redline</h2>
                <p>At Redline, we're passionate about providing high-quality automotive parts with exceptional service. For over 15 years, we've been helping drivers find the exact parts they need at competitive prices, with expert advice and fast delivery.</p>
            </div>
            
            <div class="row">
                <div class="contact-info">
                    <div class="contact-info-item">
                        <div class="contact-info-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        
                        <div class="contact-info-content">
                            <h4>Our Location</h4>
                            <p>44600 Kamal Pokhari, Kathamandu, Nepal</p>
                        </div>
                    </div>
                    
                    <div class="contact-info-item">
                        <div class="contact-info-icon">
                            <i class="fas fa-phone-alt"></i>
                        </div>
                        
                        <div class="contact-info-content">
                            <h4>Call Us</h4>
                            <p>988321345</p>
                            <p>Monday-Friday: 8am-6pm • Saturday: 9am-4pm</p>
                        </div>
                    </div>
                    
                    <div class="contact-info-item">
                        <div class="contact-info-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        
                        <div class="contact-info-content">
                            <h4>Email Us</h4>
                            <p>support@redline.com</p>
                            <p>sales@redline.com</p>
                        </div>
                    </div>
                </div>
                
                <div class="contact-form">
                    <form action="https://api.web3forms.com/submit" method="POST" id="contact-form">
                        <input type="hidden" name="access_key" value="c1ebbdcf-2889-46a7-9bd6-074ba7911f5e">
                        <h2>Get In Touch</h2>
                        
                        <div class="input-box">
                            <input type="text" required="true" name="name" id="name">
                            <label for="name">Full Name</label>
                        </div>
                        
                        <div class="input-box">
                            <input type="email" required="true" name="email" id="email">
                            <label for="email">Email Address</label>
                        </div>
                        
                        <div class="input-box">
                            <textarea required="true" name="message" id="message"></textarea>
                            <label for="message">Your Message</label>
                        </div>
                        
                        <div class="input-box">
                            <input type="submit" value="SEND MESSAGE">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
    
    <section class="company-history">
        <div class="history-container">
            <div class="history-header">
                <h2>Our Journey</h2>
            </div>
            
            <div class="history-content">
                <div class="history-image">
                    <img src="https://images.unsplash.com/photo-1493238792000-8113da705763?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80" alt="Auto Parts Workshop">
                </div>
                
                <div class="history-text">
                    <h3>Driving Excellence Since 2008</h3>
                    <p>Redline began with a simple mission: to provide high-quality automotive parts at fair prices with exceptional customer service. What started as a small family-owned shop has grown into a trusted nationwide supplier of OEM and aftermarket parts.</p>
                    <p>Our team of certified automotive experts carefully selects each product in our inventory, ensuring that every part meets or exceeds industry standards. We understand that your vehicle deserves the best, which is why we never compromise on quality.</p>
                    <p>Today, we serve thousands of satisfied customers across the country, from DIY enthusiasts to professional mechanics and auto shops. Our commitment to excellence drives everything we do, from sourcing the best parts to providing expert advice and support.</p>
                </div>
            </div>
        </div>
    </section>
    
    <jsp:include page="footer.jsp" />
    <script src="https://web3forms.com/client/script.js" async defer></script>
</body>
</html>