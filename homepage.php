<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Premium Car Rentals - CARS4U</title>
  <style>
    /* Reset APEX default styles */
    .t-Header,
    .t-NavigationBar,
    .t-Body-nav,
    .t-Body-title,
    #t_Header_navbar {
      display: none !important;
    }
    
    .t-Body-content {
      margin-left: 0 !important;
      padding: 0 !important;
    }
    
    /* Global Styles */
    :root {
      --primary-color: #0033a0;
      --secondary-color: #ff6600;
      --dark-color: #1a1a1a;
      --light-color: #f8f9fa;
      --text-color: #333;
    }
    
    body {
      font-family: 'Roboto', Arial, sans-serif;
      margin: 0;
      padding: 0;
      color: var(--text-color);
      line-height: 1.6;
    }
    
    /* Navigation Bar - Centered Layout - BIGGER VERSION */
    .navbar {
      background: linear-gradient(135deg, #1e3c72 0%, #2a5298 50%, #7db9e8 100%);
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      position: fixed;
      width: 100%;
      top: 0;
      z-index: 1000;
      padding: 15px 0;
      height: 120px;
      display: flex;
      align-items: center;
      transition: all 0.3s ease;
    }
    
    .navbar:hover {
      background: linear-gradient(135deg, #1e3c72 0%, #2a5298 70%, #7db9e8 100%);
    }
    
    .nav-container {
      display: flex;
      justify-content: center;
      align-items: center;
      max-width: 1400px;
      margin: 0 auto;
      padding: 0 40px;
      position: relative;
      width: 100%;
      height: 100%;
    }
    
    .logo {
      position: absolute;
      left: 40px;
      height: 100%;
      display: flex;
      align-items: center;
    }
    
    .logo img {
      height: 80px;
      width: auto;
      transition: all 0.3s ease;
    }
    
    .logo img:hover {
      transform: scale(1.05);
    }
    /* Slider Styles */
  .slider-container {
    margin-top: 120px;
    position: relative;
    width: 100%;
    overflow: hidden;
    height: 70vh;
  }
  .vehicles {
    background-color: var(--light-color);
    padding: 80px 20px;
    position: relative;
  }
  
  .section-header {
    text-align: center;
    margin-bottom: 50px;
  }
  
  .section-title {
    font-size: 42px;
    font-weight: 800;
    color: var(--dark-color);
    margin-bottom: 15px;
    position: relative;
    display: inline-block;
  }
  
  .section-title:after {
    content: '';
    position: absolute;
    width: 50px;
    height: 3px;
    background: var(--secondary-color);
    bottom: -10px;
    left: 50%;
    transform: translateX(-50%);
  }
  
  .section-subtitle {
    font-size: 18px;
    color: #666;
    max-width: 700px;
    margin: 0 auto 25px;
  }
  
  .section-divider {
    width: 100px;
    height: 2px;
    background: linear-gradient(to right, transparent, var(--primary-color), transparent);
    margin: 0 auto;
  }
  
  /* Vehicle Grid */
  .vehicle-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
    gap: 30px;
    max-width: 1300px;
    margin: 0 auto;
  }
  
  /* Vehicle Card */
  .vehicle-card {
    background: white;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0,0,0,0.08);
    transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    position: relative;
    border: 1px solid rgba(0,0,0,0.05);
  }
  
  .vehicle-card:hover {
    transform: translateY(-10px);
    box-shadow: 0 15px 40px rgba(0,0,0,0.15);
  }
  
  .card-badge {
    position: absolute;
    top: 15px;
    right: 15px;
    background: var(--secondary-color);
    color: white;
    padding: 5px 15px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
    z-index: 2;
    box-shadow: 0 3px 10px rgba(0,0,0,0.1);
  }
  
  .vehicle-image-container {
    position: relative;
    height: 220px;
    overflow: hidden;
  }
  
  .vehicle-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.5s ease;
  }
  
  .image-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(to bottom, transparent 60%, rgba(0,0,0,0.7));
    z-index: 1;
  }
  
  .vehicle-card:hover .vehicle-image {
    transform: scale(1.05);
  }
  
  .vehicle-info {
    padding: 25px;
  }
  
  .vehicle-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
  }
  
  .vehicle-title {
    font-size: 22px;
    font-weight: 700;
    color: var(--dark-color);
    margin: 0;
  }
  
  .vehicle-rating {
    display: flex;
    align-items: center;
    color: #FFC107;
    font-size: 14px;
  }
  
  .vehicle-rating span {
    color: #666;
    margin-left: 5px;
    font-weight: 600;
  }
  
  .vehicle-price {
    margin-bottom: 20px;
  }
  
  .price-amount {
    font-size: 24px;
    font-weight: 700;
    color: var(--primary-color);
  }
  
  .price-period {
    font-size: 14px;
    color: #666;
  }
  
  .vehicle-features {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 15px;
    margin-bottom: 25px;
  }
  
  .feature {
    display: flex;
    flex-direction: column;
    align-items: center;
    background: #f9f9f9;
    padding: 12px 5px;
    border-radius: 8px;
    font-size: 13px;
    color: #555;
    transition: all 0.3s;
  }
  
  .vehicle-card:hover .feature {
    background: #f0f0f0;
  }
  
  .feature i {
    font-size: 16px;
    margin-bottom: 5px;
    color: var(--primary-color);
  }
  
  .vehicle-actions {
    display: flex;
    gap: 10px;
  }
  
  .vehicle-button {
    background: linear-gradient(135deg, var(--primary-color) 0%, #0040a0 100%);
    color: white;
    border: none;
    padding: 14px;
    flex: 1;
    border-radius: 8px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s;
    font-size: 16px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
  }
  
  .vehicle-button:hover {
    background: linear-gradient(135deg, #00257a 0%, var(--primary-color) 100%);
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0,51,160,0.2);
  }
  
  .details-button {
    background: white;
    color: var(--primary-color);
    border: 1px solid var(--primary-color);
    padding: 14px;
    border-radius: 8px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s;
    font-size: 16px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
  }
  
  .details-button:hover {
    background: #f0f5ff;
    transform: translateY(-2px);
  }
  
  .view-all-container {
    text-align: center;
    margin-top: 50px;
  }
  
  .view-all-button {
    background: transparent;
    color: var(--primary-color);
    border: 2px solid var(--primary-color);
    padding: 12px 30px;
    border-radius: 30px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s;
    font-size: 16px;
    display: inline-flex;
    align-items: center;
    gap: 10px;
  }
  
  .view-all-button:hover {
    background: var(--primary-color);
    color: white;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,51,160,0.2);
  }
  
  /* Responsive Adjustments */
  @media (max-width: 1200px) {
    .vehicle-grid {
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    }
  }
  
  @media (max-width: 768px) {
    .section-title {
      font-size: 36px;
    }
    
    .section-subtitle {
      font-size: 16px;
    }
    
    .vehicle-features {
      grid-template-columns: repeat(3, 1fr);
    }
    
    .vehicle-actions {
      flex-direction: column;
    }
  }
  
  @media (max-width: 576px) {
    .vehicles {
      padding: 60px 15px;
    }
    
    .section-title {
      font-size: 30px;
    }
    
    .vehicle-grid {
      grid-template-columns: 1fr;
    }
    
    .vehicle-image-container {
      height: 200px;
    }
  }
  .slider {
    display: flex;
    transition: transform 0.5s ease;
    height: 100%;
  }
  
  .slide {
    min-width: 100%;
    position: relative;
  }
  
  .slide img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  
  .slide-overlay {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background: linear-gradient(to top, rgba(0,0,0,0.8), transparent);
    padding: 40px;
    color: white;
    text-align: center;
  }
  
  .slide-overlay h3 {
    font-size: 36px;
    margin-bottom: 15px;
  }
  
  .slide-overlay p {
    font-size: 18px;
    margin-bottom: 25px;
    max-width: 700px;
    margin-left: auto;
    margin-right: auto;
  }
  
  .slide-btn {
    background-color: var(--secondary-color);
    color: white;
    border: none;
    padding: 12px 30px;
    border-radius: 5px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s;
    font-size: 16px;
  }
  
  .slide-btn:hover {
    background-color: #e65c00;
    transform: translateY(-2px);
  }
  
  .slider-nav {
    position: absolute;
    bottom: 20px;
    left: 0;
    right: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 20px;
  }
  
  .slider-prev,
  .slider-next {
    background: rgba(255,255,255,0.3);
    color: white;
    border: none;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    cursor: pointer;
    transition: all 0.3s;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  
  .slider-prev:hover,
  .slider-next:hover {
    background: rgba(255,255,255,0.5);
  }
  
  .slider-dots {
    display: flex;
    gap: 10px;
  }
  
  .dot {
    width: 12px;
    height: 12px;
    border-radius: 50%;
    background: rgba(255,255,255,0.5);
    cursor: pointer;
    transition: all 0.3s;
  }
  
  .dot.active {
    background: white;
    transform: scale(1.2);
  }
  
  /* Responsive Adjustments */
  @media (max-width: 992px) {
    .slider-container {
      margin-top: 100px;
      height: 60vh;
    }
    
    .slide-overlay {
      padding: 30px;
    }
    
    .slide-overlay h3 {
      font-size: 30px;
    }
    
    .slide-overlay p {
      font-size: 16px;
    }
  }
  
  @media (max-width: 768px) {
    .slider-container {
      height: 50vh;
    }
    
    .slide-overlay {
      padding: 20px;
    }
    
    .slide-overlay h3 {
      font-size: 24px;
    }
    
    .slide-overlay p {
      font-size: 14px;
    }
    
    .slide-btn {
      padding: 10px 20px;
      font-size: 14px;
    }
  }
  
  @media (max-width: 576px) {
    .slider-container {
      height: 40vh;
    }
    
    .slide-overlay h3 {
      font-size: 20px;
    }
  }
    .nav-menu {
      display: flex;
      list-style: none;
      margin: 0 auto;
      padding: 0;
      height: 100%;
      align-items: center;
    }
    
    .nav-menu li {
      margin: 0 25px;
    }
    
    .nav-menu a {
      color: white;
      text-decoration: none;
      font-weight: 600;
      font-size: 18px;
      transition: all 0.3s;
      padding: 15px 0;
      position: relative;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }
    
    .nav-menu a:hover {
      color: #ffcc00;
    }
    
    .nav-menu a::after {
      content: '';
      position: absolute;
      width: 0;
      height: 3px;
      background: #ffcc00;
      bottom: 10px;
      left: 0;
      transition: width 0.3s;
    }
    
    .nav-menu a:hover::after {
      width: 100%;
    }
    
    .nav-actions {
      position: absolute;
      right: 40px;
      height: 100%;
      display: flex;
      align-items: center;
    }
    
    .nav-button {
      background-color: var(--secondary-color);
      color: white;
      border: none;
      padding: 16px 35px;
      border-radius: 8px;
      font-weight: 700;
      cursor: pointer;
      transition: all 0.3s;
      font-size: 18px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      text-transform: uppercase;
      letter-spacing: 1px;
    }
    
    .nav-button:hover {
      background-color: #e65c00;
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(0,0,0,0.15);
    }
    
    /* Image Hover Gallery Section */
    .image-gallery {
      margin-top: 120px;
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      height: 70vh;
      position: relative;
      overflow: hidden;
    }
    
    .gallery-item {
      position: relative;
      overflow: hidden;
      transition: all 0.5s ease;
    }
    
    .gallery-item img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.5s ease;
    }
    
    .gallery-item:hover {
      flex: 2;
    }
    
    .gallery-item:hover img {
      transform: scale(1.1);
    }
    
    .gallery-overlay {
      position: absolute;
      bottom: 0;
      left: 0;
      right: 0;
      background: linear-gradient(to top, rgba(0,0,0,0.8), transparent);
      padding: 30px;
      color: white;
      opacity: 0;
      transition: opacity 0.3s ease;
    }
    
    .gallery-item:hover .gallery-overlay {
      opacity: 1;
    }
    
    .gallery-overlay h3 {
      font-size: 24px;
      margin-bottom: 10px;
    }
    
    .gallery-overlay p {
      font-size: 16px;
      margin-bottom: 15px;
    }
    
    .gallery-btn {
      background-color: var(--secondary-color);
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 5px;
      cursor: pointer;
      transition: all 0.3s;
    }
    
    .gallery-btn:hover {
      background-color: #e65c00;
    }
    
    /* Search Container */
    .search-container {
      background: white;
      border-radius: 12px;
      max-width: 1100px;
      margin: -50px auto 0;
      padding: 30px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.15);
      position: relative;
      z-index: 100;
    }
    
    .search-tabs {
      display: flex;
      border-bottom: 1px solid #eee;
      margin-bottom: 25px;
      justify-content: center;
    }
    
    .search-tab {
      padding: 15px 30px;
      font-weight: 600;
      cursor: pointer;
      color: #666;
      border-bottom: 3px solid transparent;
      transition: all 0.3s;
    }
    
    .search-tab.active {
      color: var(--primary-color);
      border-bottom-color: var(--primary-color);
    }
    
    .search-tab:hover {
      color: var(--primary-color);
    }
    
    .search-form {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
      gap: 20px;
    }
    
    .form-group {
      margin-bottom: 20px;
    }
    
    .form-group label {
      display: block;
      margin-bottom: 10px;
      font-weight: 600;
      color: var(--dark-color);
    }
    
    .form-control {
      width: 100%;
      padding: 14px;
      border: 1px solid #ddd;
      border-radius: 6px;
      font-size: 16px;
      transition: all 0.3s;
    }
    
    .form-control:focus {
      border-color: var(--primary-color);
      box-shadow: 0 0 0 3px rgba(0,51,160,0.1);
      outline: none;
    }
    
    .search-button {
      background-color: var(--secondary-color);
      color: white;
      border: none;
      padding: 16px;
      border-radius: 6px;
      font-weight: 600;
      font-size: 18px;
      cursor: pointer;
      transition: all 0.3s;
      grid-column: 1 / -1;
      margin-top: 10px;
    }
    
    .search-button:hover {
      background-color: #e65c00;
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(0,0,0,0.15);
    }
    
    /* Vehicle Categories */
    .section-title {
      text-align: center;
      margin: 80px 0 40px;
      font-size: 36px;
      font-weight: 800;
      color: var(--dark-color);
    }
    
    .categories {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 30px;
      max-width: 1300px;
      margin: 0 auto;
      padding: 0 30px;
    }
    
    .category-card {
      background: white;
      border-radius: 12px;
      overflow: hidden;
      box-shadow: 0 5px 15px rgba(0,0,0,0.08);
      transition: all 0.3s;
      text-align: center;
      padding: 30px 20px;
      border: 1px solid #eee;
    }
    
    .category-card:hover {
      transform: translateY(-10px);
      box-shadow: 0 15px 30px rgba(0,0,0,0.15);
    }
    
    .category-icon {
      font-size: 50px;
      color: var(--primary-color);
      margin-bottom: 20px;
    }
    
    .category-card h3 {
      font-size: 24px;
      margin-bottom: 15px;
      color: var(--dark-color);
    }
    
    .category-card p {
      color: #666;
      font-size: 16px;
    }
    
    /* Featured Vehicles */
    .vehicles {
      background-color: var(--light-color);
      padding: 80px 20px;
    }
    
    .vehicle-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
      gap: 30px;
      max-width: 1300px;
      margin: 0 auto;
    }
    
    .vehicle-card {
      background: white;
      border-radius: 12px;
      overflow: hidden;
      box-shadow: 0 5px 15px rgba(0,0,0,0.08);
      transition: all 0.3s;
      border: 1px solid #eee;
    }
    
    .vehicle-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 25px rgba(0,0,0,0.15);
    }
    
    .vehicle-image {
      width: 100%;
      height: 220px;
      object-fit: cover;
    }
    
    .vehicle-info {
      padding: 25px;
    }
    
    .vehicle-title {
      font-size: 22px;
      font-weight: 700;
      margin-bottom: 12px;
      color: var(--dark-color);
    }
    
    .vehicle-price {
      color: var(--primary-color);
      font-weight: 700;
      font-size: 20px;
      margin-bottom: 20px;
    }
    
    .vehicle-features {
      display: flex;
      flex-wrap: wrap;
      gap: 12px;
      margin-bottom: 25px;
    }
    
    .feature {
      background: #f5f5f5;
      padding: 6px 12px;
      border-radius: 20px;
      font-size: 14px;
      color: #555;
    }
    
    .vehicle-button {
      background-color: var(--primary-color);
      color: white;
      border: none;
      padding: 14px;
      width: 100%;
      border-radius: 6px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s;
      font-size: 16px;
    }
    
    .vehicle-button:hover {
      background-color: #00257a;
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
    
    /* Responsive Adjustments */
    @media (max-width: 1200px) {
      .nav-menu li {
        margin: 0 20px;
      }
      
      .logo img {
        height: 70px;
      }
      
      .image-gallery {
        grid-template-columns: repeat(2, 1fr);
        height: auto;
      }
    }
    
    @media (max-width: 992px) {
      .navbar {
        height: auto;
        padding: 20px 0;
      }
      
      .logo {
        position: static;
        margin-bottom: 15px;
        height: auto;
      }
      
      .logo img {
        height: 60px;
      }
      
      .nav-menu {
        display: none;
      }
      
      .nav-container {
        flex-direction: column;
        padding: 0 20px;
      }
      
      .nav-actions {
        position: static;
        margin-top: 15px;
      }
      
      .image-gallery {
        margin-top: 100px;
      }
    }
    
    @media (max-width: 768px) {
      .search-container {
        padding: 20px;
      }
      
      .search-tabs {
        flex-wrap: wrap;
      }
      
      .search-tab {
        flex: 1;
        text-align: center;
        padding: 12px 10px;
      }
      
      .section-title {
        font-size: 30px;
        margin: 60px 0 30px;
      }
      
      .categories {
        grid-template-columns: 1fr;
        padding: 0 20px;
      }
      
      .image-gallery {
        grid-template-columns: 1fr;
        height: auto;
      }
      
      .gallery-item {
        height: 300px;
      }
    }
    
    @media (max-width: 576px) {
      .section-title {
        font-size: 28px;
      }
      
      .vehicle-grid {
        grid-template-columns: 1fr;
      }
      
      .nav-button {
        padding: 14px 25px;
        font-size: 16px;
      }
      
      .search-container {
        margin-top: -30px;
      }
    }
  </style>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;600;700&display=swap" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
</head>
<body>
  <!-- Navigation Bar -->
  <nav class="navbar">
    <div class="nav-container">
      <div class="logo">
        <img src="#APP_FILES#cars4ulogo.png" alt="CARS4U">
      </div>
      <ul class="nav-menu">
        <li><a href="f?p=171461:1:&SESSION.">Home</a></li>
        <li><a href="f?p=171461:3:&SESSION.">Master Page</a></li>
        <li><a href="f?p=171461:11">Dashboard</a></li>
        <li><a href="f?p=171461:41">Locations</a></li>
        <li><a href="#">Services</a></li>
      </ul>
      <div class="nav-actions">
        <a href="f?p=171461:9999">
          <button class="nav-button">Login</button>
        </a>
      </div>
    </div>
  </nav>

<!-- Image Slider Section -->
<div class="slider-container">
  <div class="slider">
    <div class="slide active">
      <img src="#APP_FILES#bg.png" alt="Luxury Car">
      <div class="slide-overlay">
        <h3>Premium Luxury</h3>
        <p>Experience the ultimate in comfort and style with our premium collection</p>
        <button class="slide-btn">View Fleet</button>
      </div>
    </div>
    <div class="slide">
      <img src="#APP_FILES#2.jpeg" alt="Sports Car">
      <div class="slide-overlay">
        <h3>Sports Cars</h3>
        <p>Feel the power and performance of our high-end sports vehicles</p>
        <button class="slide-btn">View Fleet</button>
      </div>
    </div>
    <div class="slide">
      <img src="#APP_FILES#bg3.png" alt="SUV">
      <div class="slide-overlay">
        <h3>SUVs & 4x4s</h3>
        <p>Perfect for adventure and family trips</p>
        <button class="slide-btn">View Fleet</button>
      </div>
    </div>
    <div class="slide">
      <img src="#APP_FILES#bg3.png" alt="Economy Car">
      <div class="slide-overlay">
        <h3>Economy Cars</h3>
        <p>Affordable and efficient options for everyday driving</p>
        <button class="slide-btn">View Fleet</button>
      </div>
    </div>
  </div>
  <div class="slider-nav">
    <button class="slider-prev"><i class="fas fa-chevron-left"></i></button>
    <div class="slider-dots">
      <span class="dot active"></span>
      <span class="dot"></span>
      <span class="dot"></span>
      <span class="dot"></span>
    </div>
    <button class="slider-next"><i class="fas fa-chevron-right"></i></button>
  </div>
</div>

  <!-- Vehicle Categories -->
  <h2 class="section-title">Browse by Category</h2>
  <div class="categories">
    <div class="category-card">
      <div class="category-icon"><i class="fas fa-car"></i></div>
      <h3>Economy Cars</h3>
      <p>Affordable and efficient</p>
    </div>
    
    <div class="category-card">
      <div class="category-icon"><i class="fas fa-car-side"></i></div>
      <h3>Premium Cars</h3>
      <p>Luxury and comfort</p>
    </div>
    
    <div class="category-card">
      <div class="category-icon"><i class="fas fa-truck-pickup"></i></div>
      <h3>SUVs & 4x4s</h3>
      <p>For all terrains</p>
    </div>
    
    <div class="category-card">
      <div class="category-icon"><i class="fas fa-car"></i></div>
      <h3>Vans & Minibuses</h3>
      <p>For groups and families</p>
    </div>
  </div>

  <!-- Featured Vehicles -->
<section class="vehicles">
  <div class="section-header">
    <h2 class="section-title">Featured Vehicles</h2>
    <p class="section-subtitle">Experience luxury and performance with our premium fleet</p>
    <div class="section-divider"></div>
  </div>
  
  <div class="vehicle-grid">
    <div class="vehicle-card">
      <div class="card-badge">Most Popular</div>
      <div class="vehicle-image-container">
        <img src="#APP_FILES#2.jpeg" alt="Rolls Royce" class="vehicle-image">
        <div class="image-overlay"></div>
      </div>
      <div class="vehicle-info">
        <div class="vehicle-header">
          <h3 class="vehicle-title">Rolls Royce Ghost</h3>
          <div class="vehicle-rating">
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="fas fa-star-half-alt"></i>
            <span>4.7</span>
          </div>
        </div>
        <div class="vehicle-price">
          <span class="price-amount">AED 12,00,000</span>
          <span class="price-period">/day</span>
        </div>
        <div class="vehicle-features">
          <div class="feature">
            <i class="fas fa-users"></i>
            <span>5 Seats</span>
          </div>
          <div class="feature">
            <i class="fas fa-cog"></i>
            <span>Automatic</span>
          </div>
          <div class="feature">
            <i class="fas fa-medal"></i>
            <span>Premium</span>
          </div>
        </div>
        <div class="vehicle-actions">
          <button class="vehicle-button" onclick="window.location.href='f?p=118163:2:&SESSION.'">
            <span>Book Now</span>
            <i class="fas fa-arrow-right"></i>
          </button>
          <button class="details-button">
            <i class="fas fa-info-circle"></i>
            Details
          </button>
        </div>
      </div>
    </div>
    
    <div class="vehicle-card">
      <div class="card-badge">Limited Edition</div>
      <div class="vehicle-image-container">
        <img src="#APP_FILES#bg3.png" alt="Lamborghini" class="vehicle-image">
        <div class="image-overlay"></div>
      </div>
      <div class="vehicle-info">
        <div class="vehicle-header">
          <h3 class="vehicle-title">Lamborghini Aventador</h3>
          <div class="vehicle-rating">
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <span>5.0</span>
          </div>
        </div>
        <div class="vehicle-price">
          <span class="price-amount">AED 8,00,000</span>
          <span class="price-period">/day</span>
        </div>
        <div class="vehicle-features">
          <div class="feature">
            <i class="fas fa-users"></i>
            <span>2 Seats</span>
          </div>
          <div class="feature">
            <i class="fas fa-cog"></i>
            <span>Automatic</span>
          </div>
          <div class="feature">
            <i class="fas fa-bolt"></i>
            <span>Sports</span>
          </div>
        </div>
        <div class="vehicle-actions">
          <button class="vehicle-button" onclick="window.location.href='f?p=118163:2:&SESSION.'">
            <span>Book Now</span>
            <i class="fas fa-arrow-right"></i>
          </button>
          <button class="details-button">
            <i class="fas fa-info-circle"></i>
            Details
          </button>
        </div>
      </div>
    </div>
    
    <div class="vehicle-card">
      <div class="card-badge">Family Choice</div>
      <div class="vehicle-image-container">
        <img src="#APP_FILES#1.png" alt="Porsche" class="vehicle-image">
        <div class="image-overlay"></div>
      </div>
      <div class="vehicle-info">
        <div class="vehicle-header">
          <h3 class="vehicle-title">Porsche Cayenne Turbo GT</h3>
          <div class="vehicle-rating">
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="far fa-star"></i>
            <span>4.2</span>
          </div>
        </div>
        <div class="vehicle-price">
          <span class="price-amount">AED 4,50,000</span>
          <span class="price-period">/day</span>
        </div>
        <div class="vehicle-features">
          <div class="feature">
            <i class="fas fa-users"></i>
            <span>5 Seats</span>
          </div>
          <div class="feature">
            <i class="fas fa-cog"></i>
            <span>Automatic</span>
          </div>
          <div class="feature">
            <i class="fas fa-car-side"></i>
            <span>SUV</span>
          </div>
        </div>
        <div class="vehicle-actions">
          <button class="vehicle-button" onclick="window.location.href='f?p=118163:2:&SESSION.'">
            <span>Book Now</span>
            <i class="fas fa-arrow-right"></i>
          </button>
          <button class="details-button">
            <i class="fas fa-info-circle"></i>
            Details
          </button>
        </div>
      </div>
    </div>
  </div>
  
 <div class="view-all-container">
  <a href="f?p=171461:47:&SESSION." class="view-all-button">
    View All Vehicles
    <i class="fas fa-chevron-right"></i>
  </a>
</div>
</section>

  <div class="t-Body">
    <div class="t-Body-content">
      <div class="t-Body-contentInner">
        <!-- APEX content can go here if needed -->
      </div>
    </div>
  </div>
</body>
</html>
<script>
  document.addEventListener('DOMContentLoaded', function() {
    const slider = document.querySelector('.slider');
    const slides = document.querySelectorAll('.slide');
    const dots = document.querySelectorAll('.dot');
    const prevBtn = document.querySelector('.slider-prev');
    const nextBtn = document.querySelector('.slider-next');
    let currentIndex = 0;
    const slideCount = slides.length;
    
    // Update slider position
    function updateSlider() {
      slider.style.transform = `translateX(-${currentIndex * 100}%)`;
      
      // Update dots
      dots.forEach((dot, index) => {
        dot.classList.toggle('active', index === currentIndex);
      });
    }
    
    // Next slide
    function nextSlide() {
      currentIndex = (currentIndex + 1) % slideCount;
      updateSlider();
    }
    
    // Previous slide
    function prevSlide() {
      currentIndex = (currentIndex - 1 + slideCount) % slideCount;
      updateSlider();
    }
    
    // Auto slide change
    let slideInterval = setInterval(nextSlide, 5000);
    
    // Reset interval on interaction
    function resetInterval() {
      clearInterval(slideInterval);
      slideInterval = setInterval(nextSlide, 5000);
    }
    
    // Event listeners
    nextBtn.addEventListener('click', () => {
      nextSlide();
      resetInterval();
    });
    
    prevBtn.addEventListener('click', () => {
      prevSlide();
      resetInterval();
    });
    
    dots.forEach((dot, index) => {
      dot.addEventListener('click', () => {
        currentIndex = index;
        updateSlider();
        resetInterval();
      });
    });
    
    // Keyboard navigation
    document.addEventListener('keydown', (e) => {
      if (e.key === 'ArrowRight') {
        nextSlide();
        resetInterval();
      } else if (e.key === 'ArrowLeft') {
        prevSlide();
        resetInterval();
      }
    });
  });
</script>
