# 🚀 Complete Step-by-Step Guide: Host Your Django E-Commerce on Ubuntu VPS with Docker

> **This guide is written for ABSOLUTE BEGINNERS. Every step is explained.**

---

## 📚 Table of Contents

1. [Prerequisites](#prerequisites)
2. [What You Need to Know](#what-you-need-to-know)
3. [Part 1: Setup Your VPS](#part-1-setup-your-vps)
4. [Part 2: Install Docker](#part-2-install-docker)
5. [Part 3: Get Your Project Ready](#part-3-get-your-project-ready)
6. [Part 4: Configure Environment](#part-4-configure-environment)
7. [Part 5: Deploy with Docker](#part-5-deploy-with-docker)
8. [Part 6: Setup Domain & SSL](#part-6-setup-domain--ssl)
9. [Part 7: Monitor & Maintain](#part-7-monitor--maintain)
10. [Troubleshooting](#troubleshooting)

---

## Prerequisites

Before you start, you need:

- ✅ A VPS running **Ubuntu 24.02 LTS** (from providers like DigitalOcean, Linode, AWS, etc.)
- ✅ SSH access to your VPS (usually provided by your VPS provider)
- ✅ An SSH client (Terminal on Mac/Linux, PuTTY or Windows Terminal on Windows)
- ✅ Your project code (this repository)
- ✅ A domain name (optional, but recommended)
- ✅ Basic terminal knowledge

---

## What You Need to Know

### What is Docker?

Docker is like a **magical box** that contains everything your application needs:
- Python 3.11
- All Python packages
- MySQL database
- Configuration files

When you ship this box to your VPS, it works **exactly the same** as on your computer. No more "it works on my machine" problems!

### What is Docker Compose?

Docker Compose is a tool that helps manage multiple Docker boxes working together:
- Django web application box
- MySQL database box
- (Optional) Nginx reverse proxy box

### Why This Is Great

1. **Easy to Deploy:** Just 3 commands and you're live
2. **Easy to Update:** Fix a bug, push to VPS, restart containers
3. **Easy to Backup:** Database is in a volume
4. **Easy to Scale:** Can run multiple application containers

---

## Part 1: Setup Your VPS

### Step 1.1: Connect to Your VPS via SSH

**On Mac/Linux Terminal:**
```bash
ssh root@your-vps-ip-address
# For example: ssh root@192.168.1.100
```

**On Windows Terminal/PuTTY:**
- Open PuTTY
- Host Name: `your-vps-ip-address`
- Port: `22`
- Click Open

When prompted, enter:
- Login: `root`
- Password: Your VPS password (provided by provider)

### Step 1.2: Update System Packages

Once connected, run these commands to update your system:

```bash
apt-get update
apt-get upgrade -y
```

This downloads the latest security updates. The `-y` flag means "Yes" automatically.

**What it does:** Updates your system's package list and installs all available updates.

---

## Part 2: Install Docker

### Step 2.1: Install Docker Engine

```bash
apt-get install -y docker.io
```

### Step 2.2: Install Docker Compose

```bash
apt-get install -y docker-compose
```

### Step 2.3: Start Docker Service

```bash
systemctl start docker
systemctl enable docker
```

- `start` - Starts Docker now
- `enable` - Makes Docker start automatically on VPS reboot

### Step 2.4: Verify Installation

```bash
docker --version
docker-compose --version
```

Both should show version numbers. If yes, you're good!

### Step 2.5: Add Your User to Docker Group (Optional)

This lets you run Docker commands without `sudo`:

```bash
usermod -aG docker $USER
newgrp docker
```

---

## Part 3: Get Your Project Ready

### Step 3.1: Clone Your Project

Navigate to home directory and clone your repository:

```bash
cd /home
git clone <your-github-repo-url> ecommerce
cd ecommerce
```

**Replace `<your-github-repo-url>`** with your actual GitHub repository URL.

For example:
```bash
git clone https://github.com/MengSonly17/Ecommerce_midterm_group2.git ecommerce
cd ecommerce
```

### Step 3.2: Verify Project Files

Check that all Docker files are present:

```bash
ls -la
```

You should see:
- ✅ `Dockerfile` - Recipe for building app container
- ✅ `docker-compose.yml` - Configuration for all containers
- ✅ `.env.example` - Template for environment variables
- ✅ `requirements.txt` - Python dependencies
- ✅ `manage.py` - Django management script

---

## Part 4: Configure Environment

### Step 4.1: Create .env File

Copy the example .env file:

```bash
cp .env.example .env
```

### Step 4.2: Edit the .env File

Open the file with a text editor:

```bash
nano .env
```

**How to use nano editor:**
- Type/paste content
- Press `Ctrl + X` to save
- Press `Y` for yes
- Press `Enter` to confirm filename

### Step 4.3: Configure Database

Find these lines and change them:

```env
# Database Configuration
DB_ENGINE=django.db.backends.mysql
DB_NAME=ecommerceforfinal
DB_USER=ecommerce_user
DB_PASSWORD=CHANGE_THIS_TO_STRONG_PASSWORD
DB_HOST=db
DB_PORT=3306
DB_ROOT_PASSWORD=CHANGE_THIS_TO_STRONG_PASSWORD
```

**Example with strong passwords (use these as inspiration, create your own):**
```env
DB_PASSWORD=Mysql@2025!StrongPwd#123
DB_ROOT_PASSWORD=RootDb@2025!StrongPwd#456
```

### Step 4.4: Configure Django Settings

Find and update these lines:

```env
# Django Settings
DEBUG=False                                          # Set to False for production
SECRET_KEY=generate-a-strong-secret-key-here        # Change this!
DJANGO_ALLOWED_HOSTS=your-domain.com,www.your-domain.com,localhost
```

**How to generate a strong SECRET_KEY:**

```bash
python3 -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
```

Copy the output and paste it in `.env` for `SECRET_KEY`.

### Step 4.5: Configure Email (Gmail)

To enable email sending, configure Gmail:

1. Go to **myaccount.google.com**
2. Click **Security** on the left
3. Enable **2-Step Verification** if not already enabled
4. Go back to Security, find **App passwords**
5. Select **Mail** and **Windows Computer**
6. Google will generate a 16-character password

Now update `.env`:

```env
EMAIL_BACKEND=django.core.mail.backends.smtp.EmailBackend
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=your-email@gmail.com              # Your Gmail address
EMAIL_HOST_PASSWORD=xxxx xxxx xxxx xxxx            # 16-char password from above
```

### Step 4.6: Save and Exit

In nano:
- Press `Ctrl + X`
- Press `Y`
- Press `Enter`

---

## Part 5: Deploy with Docker

### Step 5.1: Build Docker Images

This creates the "blueprint" for your containers:

```bash
docker-compose build
```

**What it does:**
- Downloads Python 3.11 image
- Installs all packages from requirements.txt
- Prepares the application image

This may take 5-10 minutes. ☕

### Step 5.2: Start All Containers

```bash
docker-compose up -d
```

Flags:
- `up` - Start containers
- `-d` - Run in background (detached mode)

### Step 5.3: Check Container Status

```bash
docker-compose ps
```

You should see:
```
NAME              STATUS
ecommerce_db      Up 10 seconds
ecommerce_web     Up 5 seconds
```

Both should say "Up". If you see "Exited", there's an error.

### Step 5.4: Apply Database Migrations

```bash
docker-compose exec web python manage.py migrate
```

This creates all database tables. Should take 10-20 seconds.

### Step 5.5: Create Admin User

```bash
docker-compose exec web python manage.py createsuperuser
```

Follow the prompts:
- Username: `admin`
- Email: Your email
- Password: Strong password (won't be visible as you type)

### Step 5.6: Collect Static Files

```bash
docker-compose exec web python manage.py collectstatic --noinput
```

This gathers all CSS, JavaScript, images for the web server.

### Step 5.7: Load Initial Data (Optional)

If you have sample products in `db.sql`:

```bash
docker-compose exec db mysql -u ecommerce_user -p ecommerceforfinal < db.sql
```

When prompted for password, enter the `DB_PASSWORD` from your `.env` file.

---

## Part 6: Access Your Application

### Step 6.1: Get Your VPS IP

If you don't know your VPS IP, find it:

```bash
hostname -I
```

It will show something like: `192.168.1.100`

### Step 6.2: Access the Application

Open a web browser and go to:

```
http://your-vps-ip:8000
```

You should see your e-commerce website!

### Step 6.3: Access Admin Panel

Go to:

```
http://your-vps-ip:8000/admin
```

Login with the admin user you created.

---

## Part 7: Setup Domain & SSL

### Step 7.1: Point Domain to VPS IP

1. Go to your domain registrar (Namecheap, GoDaddy, etc.)
2. Find DNS settings
3. Add an `A` record pointing to your VPS IP
4. Wait 5-10 minutes for DNS to update

### Step 7.2: Install Nginx Reverse Proxy

Nginx will handle traffic and SSL certificates:

```bash
apt-get install -y nginx certbot python3-certbot-nginx
```

### Step 7.3: Create Nginx Configuration

Create a config file:

```bash
nano /etc/nginx/sites-available/ecommerce
```

Paste this configuration (modify domain name):

```nginx
server {
    listen 80;
    server_name your-domain.com www.your-domain.com;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /static/ {
        alias /home/ecommerce/Home/static/;
    }

    location /media/ {
        alias /home/ecommerce/media/;
    }
}
```

Save: `Ctrl + X`, `Y`, `Enter`

### Step 7.4: Enable Site

```bash
ln -s /etc/nginx/sites-available/ecommerce /etc/nginx/sites-enabled/ecommerce
nginx -t
systemctl restart nginx
```

- `ln -s` creates a link
- `nginx -t` tests configuration
- `restart` reloads nginx

### Step 7.5: Get SSL Certificate (FREE)

```bash
certbot --nginx -d your-domain.com -d www.your-domain.com
```

Follow prompts:
- Enter your email
- Accept terms (A)
- Choose auto-renewal (yes)

### Step 7.6: Verify

Visit: `https://your-domain.com`

You should see:
- 🔒 Green lock (secure)
- Your website running
- No warnings

---

## Part 8: Monitor & Maintain

### Checking Logs

**View application logs:**
```bash
docker-compose logs -f web
```

**View database logs:**
```bash
docker-compose logs -f db
```

Press `Ctrl + C` to exit.

### Restarting Services

**Restart all:**
```bash
docker-compose restart
```

**Restart just web:**
```bash
docker-compose restart web
```

**Restart just database:**
```bash
docker-compose restart db
```

### Stopping Services

**Stop everything (keeps data):**
```bash
docker-compose down
```

**Stop and remove everything (WARNING - data deleted):**
```bash
docker-compose down -v
```

### Backing Up Database

**Export database:**
```bash
docker-compose exec db mysqldump -u ecommerce_user -p ecommerceforfinal > backup.sql
```

**Restore database:**
```bash
docker-compose exec db mysql -u ecommerce_user -p ecommerceforfinal < backup.sql
```

### Updating Code

1. Pull latest changes:
```bash
git pull origin main
```

2. Rebuild containers:
```bash
docker-compose build
```

3. Restart:
```bash
docker-compose up -d
```

4. Apply migrations (if any):
```bash
docker-compose exec web python manage.py migrate
```

---

## Troubleshooting

### Problem: "Connection refused" when accessing website

**Solution:**
```bash
# Check if containers are running
docker-compose ps

# If not running, start them
docker-compose up -d

# Check logs for errors
docker-compose logs web
```

### Problem: Database won't connect

**Solution:**
```bash
# Check database logs
docker-compose logs db

# Verify database container is healthy
docker-compose ps

# Restart database
docker-compose restart db

# Wait 10 seconds and try again
```

### Problem: Static files (CSS/JS) not loading

**Solution:**
```bash
# Collect static files
docker-compose exec web python manage.py collectstatic --noinput

# Restart web service
docker-compose restart web
```

### Problem: Email not sending

**Solution:**
1. Verify `.env` EMAIL settings are correct
2. Check Gmail "Allow less secure apps" is enabled
3. Use Gmail App Password (16 characters), not regular password
4. Test with:
```bash
docker-compose exec web python manage.py shell
# In shell, run:
from django.core.mail import send_mail
send_mail("Test", "Message", "from@gmail.com", ["to@gmail.com"])
```

### Problem: Out of disk space

**Solution:**
```bash
# Check disk usage
df -h

# Remove unused Docker images
docker image prune -a

# Remove unused volumes
docker volume prune
```

### Problem: Application is slow

**Solution:**
```bash
# Check resource usage
docker stats

# Scale up workers (edit docker-compose.yml, change --workers 4 to 8)
# Then rebuild and restart
docker-compose build
docker-compose up -d
```

---

## 🎯 Quick Reference Commands

```bash
# Start everything
docker-compose up -d

# Stop everything
docker-compose down

# View logs
docker-compose logs -f web

# Enter container shell
docker-compose exec web bash

# Run Django commands
docker-compose exec web python manage.py <command>

# Database backup
docker-compose exec db mysqldump -u ecommerce_user -p ecommerceforfinal > backup.sql

# Restart services
docker-compose restart

# Check status
docker-compose ps
```

---

## 🎓 Learning Resources

- **Docker Documentation:** https://docs.docker.com/
- **Docker Compose:** https://docs.docker.com/compose/
- **Django Documentation:** https://docs.djangoproject.com/
- **Ubuntu Help:** https://help.ubuntu.com/

---

## 📞 Getting Help

If something breaks:

1. Check logs: `docker-compose logs -f web`
2. Search the error message online
3. Ask on Stack Overflow with the error message
4. Check Docker/Django official documentation

---

## 🎉 Congratulations!

You've successfully deployed your Django e-commerce application on a VPS using Docker!

**Next Steps:**
- Monitor your application regularly
- Make backups weekly
- Keep your VPS updated: `apt-get update && apt-get upgrade`
- Add more features and content
- Monitor performance and scale if needed

---

**Happy hosting! 🚀**
