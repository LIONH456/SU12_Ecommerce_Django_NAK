# EcommerceFinal Project Documentation

## 📋 Table of Contents
1. [Project Overview](#project-overview)
2. [Features Summary](#features-summary)
3. [Technology Stack](#technology-stack)
4. [Database Analysis](#database-analysis)
5. [Communication Systems](#communication-systems)
6. [Project Structure](#project-structure)
7. [Installation & Setup](#installation--setup)
8. [Docker Deployment Guide](#docker-deployment-guide-for-ubuntu-vps)
9. [Troubleshooting](#troubleshooting)

---

## Project Overview

**Project Name:** EcommerceFinal

This is a Django-based e-commerce platform that allows customers to browse products, add them to cart, proceed to checkout, and make payments. It's an online clothing store with features like QR code-based payment processing, email notifications, and Telegram bot integration.

**Purpose:** Build a complete e-commerce web application for selling clothing items online with payment gateway integration (KHQR - Bakong payment system for Cambodian currency).

---

## Features Summary

### ✅ Core Features

1. **Product Management**
   - Browse products by category
   - View product details with descriptions, prices, images
   - Product filtering and search
   - Product ratings system

2. **Shopping Cart**
   - Add/remove items from cart
   - Update quantities
   - Cart persistence
   - Total price calculation

3. **Checkout System**
   - Customer information collection (name, email, phone, address)
   - Multiple currency support (USD, KHR - Cambodian Riel)
   - Cart review before checkout

4. **Payment Processing**
   - **KHQR (Bakong) Integration** - QR code-based payment for Cambodian bank transfers
   - Payment status checking
   - Payment history tracking
   - Dynamic QR code generation

5. **Order Management**
   - Order creation and tracking
   - Order status updates (pending, completed, etc.)
   - Order details recording
   - Order history

6. **Featured Products & Sliders**
   - Homepage slider with featured collections
   - Featured products display
   - Product categories (T-Shirts, Jeans, Sweaters, Jackets, Shirts, Pants, Hoodies, Shorts)

### 📧 Email Communication
- **Gmail Integration:** Email sending via Django's email backend
- **Purpose:** Contact form responses, order confirmations (can be extended)
- **Current Implementation:** Contact page allows users to send messages
- **Recipient:** Currently set to `sample@gmail.com` (should be customized)

### 🤖 Telegram Integration
- **Library:** `python-telegram-bot==22.5`
- **Status:** Imported but not fully implemented in current views
- **Potential Use:** Bot for order notifications, customer support, payment alerts

### 🎯 Additional Features
- QR Code generation for payments
- Admin panel for managing products, orders, and customers
- REST API endpoints for frontend operations
- CORS support for cross-origin requests

---

## Technology Stack

### Backend
- **Framework:** Django 5.2.5
- **Server:** Gunicorn 23.0.0
- **API:** Django REST Framework 3.16.1
- **ORM:** Django ORM with MySQL support

### Database
- **DBMS:** MySQL (Django configured with `django.db.backends.mysql`)
- **Current Setup:** Single MySQL instance
- **Database Name:** `ecommerceforfinal`
- **Driver:** `mysqlclient==2.2.7`

### Frontend
- **Template Engine:** Django Templates
- **JavaScript Libraries:** Vue.js, Axios
- **Static Files:** CSS, JavaScript
- **Media Handling:** Django media files for product images

### External Integrations
- **Payment Gateway:** KHQR (Bakong) - for Cambodian bank payments
- **QR Code Generation:** `qrcode==8.8`
- **Telegram Bot:** `python-telegram-bot==22.5`

### Utilities
- **Email:** Django email backend (can use Gmail/SMTP)
- **Environment Config:** `python-dotenv==1.2.1`, `django-environ==0.12.0`
- **Image Processing:** `Pillow==12.0.0`
- **Date/Time:** `python-dateutil==2.9.0.post0`
- **Data Generation:** `Faker==37.12.0` (for testing/demo data)

---

## Database Analysis

### ✅ Database Management System Count: **1 (MySQL)**

The project uses:
- **MySQL 8.0.30** (based on db.sql file)
- Single database: `ecommerceforfinal`
- No additional databases currently configured

### Database Tables (16 main tables):

#### Django Built-in Tables
1. `auth_user` - User authentication
2. `auth_group` - User groups/roles
3. `auth_permission` - Permission management
4. `django_admin_log` - Admin activity logs
5. `django_content_type` - Content type framework
6. `django_migrations` - Migration tracking
7. `django_session` - Session management

#### Custom Application Tables (Core & Home Apps)
1. `home_category` - Product categories (8 categories)
2. `home_product` - Product catalog (66 products)
3. `home_slider` - Homepage sliders
4. `home_feature` - Featured products section
5. `home_cart` - Shopping cart items
6. `home_checkout` - Checkout information
7. `home_cartcheckout` - Cart-Checkout relationship
8. `home_order` - Orders (1335 orders)
9. `home_orderdetail` - Order line items (78 details)
10. `home_payment` - Payment transactions (87 payments)

### Current Issues
- Currently using `localhost` as host with no password for MySQL (Development setup)
- No database replication or backup system configured
- Single point of failure for the database

---

## Communication Systems

### 📧 Email System
- **Status:** ✅ Implemented and Working
- **Method:** Django's `send_mail()` function
- **Configuration:** Uses Django email backend settings
- **Current Use Case:** Contact form on website
- **Location:** `Home/views.py` - `email_sender()` function
- **Email Sent To:** `sample@gmail.com` (configurable)
- **Requirements:** Configure SMTP settings in `settings.py`

### 🤖 Telegram System
- **Status:** ⚠️ Imported but Not Fully Implemented
- **Library:** `python-telegram-bot==22.5`
- **Implementation Location:** `Home/views.py` - imports present
- **Current Use:** Not actively used in current views
- **Potential Implementation:**
  - Order notification bot
  - Payment status alerts
  - Customer support bot
  - Promotional messages

### 💳 Payment Notification
- **KHQR QR Code:** Generated and displayed during checkout
- **Status Checking:** API call to Bakong API to verify payment
- **Location:** `check_payment_status()` function in views.py

---

## Project Structure

```
EcommerceFinal/                    # Project root
├── manage.py                       # Django management script
├── requirements.txt                # Python dependencies
├── db.sql                         # Database dump/schema
├── db.sqlite3                     # SQLite database (unused in production)
│
├── EcommerceFinal/                # Main project settings
│   ├── settings.py                # Django configuration
│   ├── urls.py                    # URL routing
│   ├── wsgi.py                    # WSGI application
│   ├── asgi.py                    # ASGI application
│   └── __init__.py
│
├── Home/                          # Main app (Products, Cart, Orders)
│   ├── models.py                  # Database models
│   ├── views.py                   # Business logic
│   ├── urls.py                    # URL patterns
│   ├── admin.py                   # Django admin
│   ├── migrations/                # Database migrations
│   └── static/                    # Static files
│       ├── css/                   # Stylesheets
│       ├── js/                    # JavaScript files
│       └── image/                 # Product and UI images
│
├── Core/                          # Optional utilities app
│   ├── models.py
│   ├── views.py
│   ├── management/
│   │   └── commands/              # Custom Django commands
│   └── migrations/
│
├── media/                         # User-uploaded files
│   └── qrcodes/                   # Generated QR code images
│
└── templates/                     # HTML templates
    ├── base.html                  # Base template
    ├── index.html                 # Homepage
    ├── shop.html                  # Product listing
    ├── productdetail.html         # Product details
    ├── cart.html                  # Shopping cart
    ├── checkout.html              # Checkout form
    ├── payment.html               # Payment page
    ├── success.html               # Payment success
    └── contact.html               # Contact form
```

---

## Installation & Setup

### Prerequisites
- Python 3.8+ installed
- MySQL 8.0+ server running
- Git (for version control)
- pip (Python package manager)

### Step 1: Clone/Setup Project
```bash
cd /path/to/EcommerceFinal
```

### Step 2: Create Virtual Environment
```bash
python -m venv venv

# On Windows
venv\Scripts\activate

# On Linux/Mac
source venv/bin/activate
```

### Step 3: Install Dependencies
```bash
pip install -r requirements.txt
```

### Step 4: Configure Database
1. Create MySQL database:
```sql
CREATE DATABASE ecommerceforfinal CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
```

2. Create MySQL user:
```sql
CREATE USER 'ecommerce_user'@'localhost' IDENTIFIED BY 'secure_password_here';
GRANT ALL PRIVILEGES ON ecommerceforfinal.* TO 'ecommerce_user'@'localhost';
FLUSH PRIVILEGES;
```

3. Update `settings.py` with your database credentials

### Step 5: Apply Migrations
```bash
python manage.py migrate
```

### Step 6: Create Superuser
```bash
python manage.py createsuperuser
```

### Step 7: Load Initial Data
```bash
mysql -u root -p ecommerceforfinal < db.sql
```

### Step 8: Collect Static Files
```bash
python manage.py collectstatic --noinput
```

### Step 9: Run Development Server
```bash
python manage.py runserver 0.0.0.0:8000
```

---

## Docker Deployment Guide (For Ubuntu VPS)

This is the **MOST IMPORTANT SECTION** for hosting on Ubuntu 24.02 LTS with Docker.

### Prerequisites for VPS
- Ubuntu 24.02 LTS server
- SSH access to the server
- Domain name (optional but recommended)
- SSL certificate (recommended)

### Installation Steps

#### Step 1: Update VPS System
```bash
sudo apt-get update
sudo apt-get upgrade -y
```

#### Step 2: Install Docker
```bash
sudo apt-get install -y docker.io docker-compose
sudo systemctl start docker
sudo systemctl enable docker

# Add current user to docker group (optional, avoids sudo)
sudo usermod -aG docker $USER
newgrp docker
```

#### Step 3: Clone Project to VPS
```bash
cd /home/yourusername
git clone <your-repo-url> ecommerce
cd ecommerce
```

#### Step 4: Configure Environment Variables
Create `.env` file:
```bash
cp .env.example .env
nano .env  # Edit with your settings
```

Edit `.env` with:
```
DEBUG=False
SECRET_KEY=your-secret-key-here
DJANGO_ALLOWED_HOSTS=your-domain.com,www.your-domain.com,localhost
DB_ENGINE=django.db.backends.mysql
DB_NAME=ecommerceforfinal
DB_USER=ecommerce_user
DB_PASSWORD=your_secure_password_here
DB_HOST=db
DB_PORT=3306
EMAIL_BACKEND=django.core.mail.backends.smtp.EmailBackend
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=your-email@gmail.com
EMAIL_HOST_PASSWORD=your-app-password-here
```

#### Step 5: Build and Run Docker
```bash
# Build images
docker-compose build

# Start all services
docker-compose up -d

# Check logs
docker-compose logs -f web
docker-compose logs -f db
```

#### Step 6: Initialize Database
```bash
# Apply migrations
docker-compose exec web python manage.py migrate

# Create superuser
docker-compose exec web python manage.py createsuperuser

# Collect static files
docker-compose exec web python manage.py collectstatic --noinput

# Load initial data (optional)
docker-compose exec db mysql -u root -p -e "source /docker-entrypoint-initdb.d/init.sql"
```

#### Step 7: Setup Nginx Reverse Proxy (Optional but Recommended)
```bash
sudo apt-get install -y nginx

# Create nginx config at /etc/nginx/sites-available/ecommerce
sudo nano /etc/nginx/sites-available/ecommerce
```

Add:
```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /static/ {
        alias /path/to/ecommerce/Home/static/;
    }

    location /media/ {
        alias /path/to/ecommerce/media/;
    }
}
```

Enable site:
```bash
sudo ln -s /etc/nginx/sites-available/ecommerce /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

#### Step 8: Setup SSL Certificate (Optional but Recommended)
```bash
sudo apt-get install -y certbot python3-certbot-nginx
sudo certbot --nginx -d your-domain.com
```

---

## Docker Deployment Files

### Docker Files You'll Create

See the following files in the project:
- `Dockerfile` - Application container configuration
- `docker-compose.yml` - Multi-container orchestration
- `entrypoint.sh` - Container startup script
- `.env.example` - Environment variables template
- `.dockerignore` - Files to exclude from Docker build

---

## Troubleshooting

### Common Issues

#### 1. **Database Connection Error**
```
Error: Can't connect to MySQL server
```
**Solution:**
- Check if MySQL container is running: `docker-compose ps`
- Verify DB credentials in `.env` file
- Wait 10-15 seconds for MySQL to fully start

#### 2. **Port Already in Use**
```
Error: bind: address already in use
```
**Solution:**
```bash
# Find process using port 8000
lsof -i :8000

# Kill process
kill -9 <PID>

# Or use different port in docker-compose.yml
```

#### 3. **Migration Fails**
```
Error: Relation does not exist
```
**Solution:**
```bash
docker-compose down
docker-compose up -d
docker-compose exec web python manage.py migrate --fake-initial
```

#### 4. **Static Files Not Loading**
```
Solution:
docker-compose exec web python manage.py collectstatic --noinput
```

#### 5. **Email Not Sending**
```
Solution:
- Enable "Less secure app access" in Gmail
- Or use Gmail App Passwords
- Check SMTP settings in .env
- Verify EMAIL_HOST_USER and EMAIL_HOST_PASSWORD
```

### Viewing Logs
```bash
# All services
docker-compose logs

# Specific service
docker-compose logs web
docker-compose logs db

# Follow logs in real-time
docker-compose logs -f web
```

### Useful Docker Commands
```bash
# Stop all containers
docker-compose down

# Restart services
docker-compose restart

# View running containers
docker-compose ps

# Execute command in running container
docker-compose exec web python manage.py shell

# View resource usage
docker stats
```

---

## Important Notes for Beginners

### What is Docker?
Docker is a containerization technology that packages your entire application (code, dependencies, database) into isolated "containers" that run the same way anywhere - on your laptop, on a VPS, or in the cloud.

### Why Use Docker?
1. **Consistency:** Works the same on your PC as on the VPS
2. **Isolation:** Web app and database don't interfere with other applications
3. **Easy Deployment:** Just run `docker-compose up`
4. **Easy Scaling:** Add more containers if needed
5. **No Installation Hell:** No need to manually install Python, MySQL, etc. on VPS

### Components Explained
- **Dockerfile:** Blueprint for creating the application container
- **docker-compose.yml:** Orchestration file that starts multiple containers (web + database)
- **MySQL Container:** Running in Docker, isolated and secure
- **Django Container:** Your application server
- **Nginx Container (optional):** Reverse proxy for routing traffic

### Basic Workflow
1. **Development:** Write code, test locally with `docker-compose up`
2. **Push to VPS:** Git push your code
3. **Deploy:** SSH to VPS, git pull, `docker-compose up -d`
4. **Monitor:** Check logs with `docker-compose logs -f`

---

## Support & Next Steps

### What to Do After Deployment
1. ✅ Test the website at your domain
2. ✅ Create admin account: `docker-compose exec web python manage.py createsuperuser`
3. ✅ Add products via admin panel: `yoursite.com/admin`
4. ✅ Test shopping cart and checkout
5. ✅ Test email notifications
6. ✅ Monitor logs regularly

### Further Improvements
- Setup automated backups for MySQL
- Configure Telegram bot for notifications
- Setup email notifications for orders
- Add SSL certificate (free with Let's Encrypt)
- Setup CI/CD pipeline for automatic deployments
- Add CDN for static files
- Setup monitoring and alerting

---

**Created:** November 2025
**Project:** EcommerceFinal - Django E-Commerce Platform
**Version:** 1.0.0
