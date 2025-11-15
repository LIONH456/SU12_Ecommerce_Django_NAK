# Use official Python image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# Set work directory
WORKDIR /app

# Install system dependencies (compatible with Ubuntu 24.04 LTS)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    g++ \
    pkg-config \
    default-libmysqlclient-dev \
    mariadb-client \
    libmariadb-dev \
    python3-dev \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip, setuptools, and wheel
RUN pip install --upgrade pip setuptools wheel

# Copy requirements file
COPY requirements.txt /app/

# Install Python dependencies
RUN pip install -r requirements.txt

# Copy project files
COPY . /app/

# Copy entrypoint script and make it executable BEFORE changing user
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Create necessary directories
RUN mkdir -p /app/media/qrcodes
RUN mkdir -p /app/staticfiles
RUN mkdir -p /app/logs

# Set proper ownership for all app files
RUN chown -R root:root /app && chmod -R 755 /app

# Expose port
EXPOSE 8000

# Run as root (or remove the USER line below if you had it)
# CMD is better than ENTRYPOINT for this use case
CMD ["/app/entrypoint.sh"]

