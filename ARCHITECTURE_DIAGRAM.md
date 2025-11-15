# 🏗️ System Architecture & Docker Diagram

## Docker Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────┐
│                           VPS (Ubuntu 24.02)                        │
│                                                                       │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │                     Docker Compose Network                   │   │
│  │                                                               │   │
│  │  ┌──────────────────────┐        ┌──────────────────────┐   │   │
│  │  │   Nginx Container    │        │  Django Container    │   │   │
│  │  │  (Reverse Proxy)     │        │  (Web Application)   │   │   │
│  │  │                      │        │                      │   │   │
│  │  │  Port: 80, 443      │◄─────►│  Port: 8000         │   │   │
│  │  │  (HTTP/HTTPS)       │        │  (Gunicorn)         │   │   │
│  │  │                      │        │                      │   │   │
│  │  │  - SSL/TLS         │        │  - Django ORM       │   │   │
│  │  │  - Static files    │        │  - REST API         │   │   │
│  │  │  - Compression     │        │  - Email sending    │   │   │
│  │  │  - Caching         │        │  - Auth system      │   │   │
│  │  └──────────────────────┘        └──────────────────────┘   │   │
│  │            ▲                              ▲                   │   │
│  │            │                              │                   │   │
│  │            │ Static Files                 │ Database Queries  │   │
│  │            │                              │                   │   │
│  │  ┌──────────────────────────┐  ┌─────────────────────────┐  │   │
│  │  │   Volumes               │  │  MySQL Container       │  │   │
│  │  │  - static_files        │  │  (Database)            │  │   │
│  │  │  - media_files         │  │                        │  │   │
│  │  │  - mysql_data          │  │  Port: 3306           │  │   │
│  │  │    (Persistent Storage)│  │  (Only Internal)       │  │   │
│  │  │                        │  │                        │  │   │
│  │  │  Files stored on VPS   │  │  - Auth tables         │  │   │
│  │  │  Even if container     │  │  - Product catalog    │  │   │
│  │  │  crashes, data is safe │  │  - Orders             │  │   │
│  │  │                        │  │  - Payments           │  │   │
│  │  │                        │  │  - Carts              │  │   │
│  │  └──────────────────────────┘  └─────────────────────────┘  │   │
│  │                                                               │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                                                                       │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │               External Services (Cloud)                     │   │
│  │                                                               │   │
│  │  ├─ Gmail SMTP (Email)                                      │   │
│  │  ├─ Bakong Payment Gateway (Payments)                       │   │
│  │  └─ Telegram Bot (Notifications) [Optional]               │   │
│  │                                                               │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                                                                       │
└─────────────────────────────────────────────────────────────────────┘

                    ▲
                    │ Port 80/443 (HTTPS)
                    │
        ┌───────────────────────┐
        │   Users' Browsers     │
        │                       │
        │ - laptops            │
        │ - phones             │
        │ - tablets            │
        └───────────────────────┘
```

---

## Component Details

### 1. Nginx Container (Optional but Recommended)
```
Purpose: Reverse proxy, SSL termination, static file serving
┌─────────────────────────────────┐
│  Nginx Web Server               │
├─────────────────────────────────┤
│ Functions:                      │
│ • Receives HTTP/HTTPS requests  │
│ • Routes to Django (port 8000)  │
│ • Serves static files directly  │
│ • Handles SSL/TLS certificates  │
│ • Compresses responses          │
│ • Caches headers                │
└─────────────────────────────────┘
```

### 2. Django Container (Always Running)
```
Purpose: Core application logic
┌─────────────────────────────────┐
│  Django + Gunicorn              │
├─────────────────────────────────┤
│ Components:                     │
│ • Python 3.11 runtime          │
│ • Django 5.2.5 framework        │
│ • 4 Gunicorn worker processes   │
│ • REST API endpoints            │
│ • Admin dashboard               │
│ • Business logic                │
└─────────────────────────────────┘

Processes:
├─ Gunicorn Master (manages workers)
├─ Worker 1 (handles requests)
├─ Worker 2 (handles requests)
├─ Worker 3 (handles requests)
└─ Worker 4 (handles requests)
```

### 3. MySQL Container (Always Running)
```
Purpose: Data persistence
┌─────────────────────────────────┐
│  MySQL 8.0 Database             │
├─────────────────────────────────┤
│ Databases:                      │
│ • ecommerceforfinal (main)      │
│                                 │
│ Tables: 16 total                │
│ • 7 Django built-in tables      │
│ • 9 E-commerce tables           │
│                                 │
│ Data stored:                    │
│ • Products & categories         │
│ • Orders & payments             │
│ • User accounts                 │
│ • Shopping carts                │
│ • Sessions                      │
└─────────────────────────────────┘
```

---

## Data Flow Diagram

```
User Request Flow:
┌──────────────────────────────────────────────────────────────────┐
│                                                                   │
│ 1. User visits: https://yourdomain.com/shop                    │
│    ▼                                                              │
│ 2. Request hits Nginx on port 443 (HTTPS)                      │
│    ▼                                                              │
│ 3. Nginx checks if it's static file:                           │
│    ├─ Yes? Serve from /static/ directory                       │
│    └─ No? Forward to Django on localhost:8000                  │
│    ▼                                                              │
│ 4. Django receives request                                       │
│    ├─ Checks URL routing                                        │
│    ├─ Loads view function                                       │
│    ├─ Queries database (MySQL)                                 │
│    └─ Renders HTML with data                                   │
│    ▼                                                              │
│ 5. Response sent back through Nginx                            │
│    ▼                                                              │
│ 6. Browser displays page                                        │
│                                                                   │
│ All communication is encrypted (HTTPS)                          │
└──────────────────────────────────────────────────────────────────┘


API Request Flow (AJAX):
┌──────────────────────────────────────────────────────────────────┐
│                                                                   │
│ 1. JavaScript in browser makes API call:                        │
│    axios.post('/api/cart/add', {product_id: 5})                │
│    ▼                                                              │
│ 2. Request goes to Nginx (port 443)                            │
│    ▼                                                              │
│ 3. Nginx forwards to Django API endpoint                       │
│    ▼                                                              │
│ 4. Django processes request:                                    │
│    ├─ Validates data                                            │
│    ├─ Queries MySQL (get product info)                         │
│    ├─ Creates/updates cart                                      │
│    └─ Returns JSON response                                     │
│    ▼                                                              │
│ 5. JSON response sent back                                      │
│    ▼                                                              │
│ 6. JavaScript updates page (no reload needed)                  │
│                                                                   │
└──────────────────────────────────────────────────────────────────┘


Database Interaction:
┌──────────────────────────────────────────────────────────────────┐
│                                                                   │
│ When user places order:                                          │
│                                                                   │
│ Django ORM Query:                                               │
│ order = Order.objects.create(                                  │
│     checkout=checkout_obj,                                      │
│     status='pending'                                             │
│ )                                                               │
│    ▼                                                              │
│ Converts to SQL:                                                │
│ INSERT INTO home_order (checkout_id, status)                   │
│ VALUES (123, 'pending')                                         │
│    ▼                                                              │
│ Sent to MySQL Container                                         │
│    ▼                                                              │
│ MySQL executes, creates new row                                │
│    ▼                                                              │
│ Returns ID (e.g., 456)                                          │
│    ▼                                                              │
│ Django gets ID, continues processing                           │
│    ▼                                                              │
│ Sends response to user                                          │
│                                                                   │
│ Data persists in MySQL volume (safe even if container restarts)│
│                                                                   │
└──────────────────────────────────────────────────────────────────┘
```

---

## Environment Variable Flow

```
Configuration Management:

.env file (on VPS)
├─ DEBUG=False
├─ SECRET_KEY=xyz...
├─ DB_NAME=ecommerceforfinal
├─ DB_USER=ecommerce_user
├─ DB_PASSWORD=secret123
├─ EMAIL_HOST_USER=user@gmail.com
└─ EMAIL_HOST_PASSWORD=app_password...
    ▼
docker-compose.yml reads .env
    ├─ environment: section
    │  ├─ DEBUG=${DEBUG:-False}
    │  ├─ DB_USER=${DB_USER:-root}
    │  └─ ...
    ▼
Passes to Docker containers
    ├─ Django container
    │  ├─ Sets Python environment variables
    │  └─ settings.py reads them
    │
    └─ MySQL container
       ├─ Sets MYSQL_USER
       └─ Sets MYSQL_PASSWORD
    ▼
Runtime Configuration
    ├─ Django knows database credentials
    ├─ Django knows email settings
    ├─ Django knows secret key
    └─ Django runs with DEBUG=False
```

---

## Deployment Architecture

### Local Development
```
Your Computer
├─ Docker Desktop
│  ├─ Container 1: Django (port 8000)
│  ├─ Container 2: MySQL (port 3306)
│  └─ .env.local (development secrets)
│
├─ Browser: localhost:8000
├─ Admin: localhost:8000/admin
└─ Database: Direct access via MySQL client
```

### VPS Production
```
Ubuntu 24.02 LTS VPS (yourdomain.com)
├─ Docker Engine
│  ├─ Container 1: Nginx (port 80, 443) ◄─── Internet Traffic
│  ├─ Container 2: Django (port 8000)
│  ├─ Container 3: MySQL (port 3306)
│  │
│  └─ Volumes:
│     ├─ mysql_data (persisted database)
│     ├─ static_files (CSS, JS, images)
│     └─ media_files (uploaded files)
│
├─ SSL Certificate (Let's Encrypt)
├─ .env file (production secrets)
├─ Project code (/home/ecommerce)
│
└─ External Services:
   ├─ Gmail SMTP (email sending)
   ├─ Bakong API (payment processing)
   └─ Telegram API (notifications)
```

---

## Request Lifecycle (Step by Step)

```
Timeline: User shops on yourdomain.com

T+0s: User clicks "Add to Cart"
     │
     ├─ Browser sends: POST /api/cart/add/ {product_id: 5}
     │
T+0.1s: Request travels through internet
     │
T+0.2s: Nginx receives on port 443
     │
     ├─ Checks: Is /api/cart/add a static file?
     ├─ Answer: No
     └─ Forwards to localhost:8000 (Django)
     │
T+0.3s: Django Gunicorn worker receives request
     │
     ├─ Checks URL patterns (urls.py)
     ├─ Finds: add_to_cart view function
     ├─ Executes business logic
     │
T+0.4s: Django needs product data
     │
     ├─ Queries: SELECT * FROM home_product WHERE id=5
     │
T+0.5s: MySQL processes query
     │
     ├─ Searches mysql_data volume
     ├─ Finds product record
     └─ Returns data
     │
T+0.6s: Django continues
     │
     ├─ Creates Cart entry in MySQL
     ├─ Returns JSON: {status: "success", cart_id: 123}
     │
T+0.7s: Response travels back through Nginx
     │
T+0.8s: Browser receives JSON
     │
     ├─ JavaScript processes response
     ├─ Updates page (no page reload!)
     └─ Shows notification: "Item added to cart"
     │
T+0.9s: User sees changes instantly

Total time: ~700 milliseconds (feels instant!)
```

---

## Scaling Diagram (Future Enhancement)

```
Current Setup (Single VPS):
┌────────────────────────────────────┐
│          Single VPS                │
│  ├─ Nginx                          │
│  ├─ Django (4 workers)             │
│  └─ MySQL                          │
│                                     │
│  Handles: ~100 concurrent users   │
└────────────────────────────────────┘


Future Setup (Scalable):
┌──────────────────────────────────────────────────────┐
│           Load Balancer (Nginx)                      │
│  - Distributes traffic                              │
└──────────────────┬───────────────────────────────────┘
                   │
        ┌──────────┼──────────┐
        │          │          │
    ┌─────────┐ ┌─────────┐ ┌─────────┐
    │ VPS #1  │ │ VPS #2  │ │ VPS #3  │
    │ Django  │ │ Django  │ │ Django  │
    └─────────┘ └─────────┘ └─────────┘
        │          │          │
        └──────────┼──────────┘
                   │
    ┌──────────────────────────────────┐
    │     Managed MySQL Database       │
    │  - Replication                   │
    │  - Automated Backups             │
    │  - High Availability             │
    └──────────────────────────────────┘

Handles: 1000+ concurrent users
```

---

## Security Architecture

```
Traffic Flow with Security:

Internet (Untrusted)
        │
        ▼
┌──────────────────┐
│ HTTPS (Encrypted)│ ◄─── SSL/TLS Certificate
└──────────────────┘
        │
        ▼
┌──────────────────────────────┐
│ Nginx (Firewall)             │ ◄─── Rate limiting
│                              │      IP blocking
│ ├─ Static files only        │      DDoS protection
│ └─ Django only for API      │
└──────────────────────────────┘
        │
        ▼
┌──────────────────────────────┐
│ Django (Application Layer)   │ ◄─── CSRF protection
│                              │      SQL Injection prevention
│ ├─ Authentication           │      XSS protection
│ ├─ Authorization            │      Input validation
│ ├─ Data validation          │
│ └─ Logging & monitoring     │
└──────────────────────────────┘
        │
        ▼
┌──────────────────────────────┐
│ MySQL (Data Layer)           │ ◄─── Database password
│                              │      User permissions
│ ├─ Encrypted connections    │      Encrypted at rest
│ ├─ Credentials in .env      │
│ └─ Regular backups          │
└──────────────────────────────┘

Internal Network (Docker bridge network)
- Isolated from internet
- Only Django ↔ MySQL
- No direct internet access to database
```

---

## File Storage Architecture

```
VPS Disk Structure:

/home/ecommerce/                          # Project root
├─ Docker Volumes (persisted):
│  ├─ mysql_data/                        # MySQL database files
│  │  └─ ecommerceforfinal/              # Database storage
│  │     ├─ home_product.ibd
│  │     ├─ home_order.ibd
│  │     ├─ home_payment.ibd
│  │     └─ ...
│  │
│  ├─ static_files/                      # CSS, JS, Images
│  │  ├─ css/
│  │  ├─ js/
│  │  ├─ image/
│  │  └─ ...
│  │
│  └─ media_files/                       # User uploads
│     ├─ qrcodes/                        # Payment QR codes
│     │  ├─ md5hash1.png
│     │  └─ md5hash2.png
│     └─ ... (other uploads)
│
├─ Project Code:
│  ├─ Dockerfile
│  ├─ docker-compose.yml
│  ├─ manage.py
│  ├─ requirements.txt
│  └─ ... (Django files)
│
└─ Configuration:
   ├─ .env                               # Secrets (not in git)
   ├─ .gitignore
   └─ .dockerignore


Key Characteristic: Volumes persist even if container crashes!
- If Django container dies: restart and uses same data
- If MySQL container dies: restart and uses same database
- No data loss!
```

---

## Summary

```
🏗️ Architecture Summary:

┌─────────────────────────────────────────────────────────────┐
│                   User Layer (Internet)                     │
│                  yourdomain.com/shop                        │
└─────────────────────────────────────────────────────────────┘
                           │ HTTPS
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                   Edge Layer (Nginx)                        │
│  ├─ SSL/TLS encryption                                     │
│  ├─ Static file serving                                    │
│  └─ Reverse proxy to Django                               │
└─────────────────────────────────────────────────────────────┘
                           │ HTTP (Internal)
                           ▼
┌─────────────────────────────────────────────────────────────┐
│               Application Layer (Django)                    │
│  ├─ Business logic                                         │
│  ├─ REST API endpoints                                     │
│  ├─ User authentication                                    │
│  └─ 4 worker processes (scalable)                         │
└─────────────────────────────────────────────────────────────┘
                           │ SQL
                           ▼
┌─────────────────────────────────────────────────────────────┐
│               Data Layer (MySQL)                           │
│  ├─ 16 database tables                                    │
│  ├─ 1000+ products, orders, users                        │
│  └─ Persistent storage (safe)                            │
└─────────────────────────────────────────────────────────────┘
```

This architecture is:
✅ Scalable (can add more Django containers)
✅ Secure (HTTPS, encrypted, firewalled)
✅ Reliable (data persists in volumes)
✅ Maintainable (Docker makes updates easy)
✅ Monitorable (can check logs, stats, health)
