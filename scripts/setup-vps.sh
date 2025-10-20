#!/bin/bash

# VPS Setup Script for phd.sharpy.dev
# This script should be run on your VPS server as root

set -e

echo "🚀 Setting up VPS for n8n deployment..."

# Update system
apt update && apt upgrade -y

# Install required packages
apt install -y curl wget git nginx

# Install Docker
if ! command -v docker &> /dev/null; then
    echo "📦 Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    systemctl enable docker
    systemctl start docker
    rm get-docker.sh
else
    echo "✅ Docker already installed"
fi

# Install Docker Compose
if ! command -v docker-compose &> /dev/null; then
    echo "📦 Installing Docker Compose..."
    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
else
    echo "✅ Docker Compose already installed"
fi

# Create deployment directory
mkdir -p /opt/phd-n8n
cd /opt/phd-n8n

# Setup SSL certificates
echo "🔒 Setting up SSL certificates..."
mkdir -p /opt/phd-n8n/ssl
chmod 700 /opt/phd-n8n/ssl
chmod 600 /opt/phd-n8n/ssl/phd.sharpy.dev.key

# Setup nginx configuration
echo "🌐 Setting up nginx..."
cp /opt/phd-n8n/nginx.conf /etc/nginx/sites-available/phd.sharpy.dev
ln -sf /etc/nginx/sites-available/phd.sharpy.dev /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# Test nginx configuration
nginx -t

# Start nginx
systemctl enable nginx
systemctl restart nginx

# Setup firewall
echo "🔥 Configuring firewall..."
ufw --force enable
ufw allow ssh
ufw allow 80
ufw allow 443
ufw allow 5678  # For direct access if needed

echo "✅ VPS setup completed!"
echo "📝 Next steps:"
echo "1. Update your GitHub repository secrets with:"
echo "   - VPS_HOST: your-server-ip"
echo "   - VPS_USERNAME: root"
echo "   - VPS_PASSWORD: your-root-password"
echo "2. Push your code to trigger the deployment"
echo "3. Your n8n instance will be available at https://phd.sharpy.dev"
echo ""
echo "🔒 SSL certificates are included in the deployment"
echo "🌐 Nginx is configured to use the Cloudflare certificates"