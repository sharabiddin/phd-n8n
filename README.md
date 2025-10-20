# n8n PhD Project

n8n workflow automation platform for local development and VPS deployment.

## Local Development

### Prerequisites
- Docker and Docker Compose
- Git

### Quick Start
```bash
git clone <your-repo-url>
cd phd-n8n
cp .env.example .env
npm start
```

Access n8n at: http://localhost:5678
- **Username**: admin
- **Password**: SecurePassword123!

### Available Commands
```bash
npm start          # Start n8n and PostgreSQL
npm stop           # Stop all services
npm run logs       # View n8n logs
npm run restart    # Restart services
npm run clean      # Reset all data
```

## VPS Deployment

### Prerequisites
- Ubuntu/Debian VPS server
- Domain pointing to your server (phd.sharpy.dev)
- GitHub repository

### Setup Steps

#### 1. Prepare Your VPS
```bash
# On your VPS server as root
curl -fsSL https://raw.githubusercontent.com/your-username/phd-n8n/main/scripts/setup-vps.sh | bash
```

#### 2. Configure GitHub Secrets
In your GitHub repository, add these secrets:
- `VPS_HOST`: Your server IP address
- `VPS_USERNAME`: `root`
- `VPS_PASSWORD`: Your root password

#### 3. Deploy
Push to main branch or manually trigger the deployment workflow.

### Production URLs
- **n8n Editor**: https://phd.sharpy.dev
- **Webhooks**: https://phd.sharpy.dev/webhook/
- **API**: https://phd.sharpy.dev/api/

## Configuration

### Environment Variables
See `.env.example` for local development and `.env.production` for production settings.

### Key Production Changes
- **Domain**: phd.sharpy.dev
- **Protocol**: HTTPS
- **Secure Cookies**: Enabled
- **SSL**: Let's Encrypt certificate

## File Structure
```
├── .github/workflows/
│   └── deploy.yml          # GitHub Actions deployment
├── scripts/
│   └── setup-vps.sh        # VPS setup script
├── docker-compose.yml      # Docker services
├── nginx.conf             # Nginx configuration
├── .env.example           # Local environment template
├── .env.production        # Production environment template
└── README.md              # This file
```

## Security Notes
1. Change default passwords before deployment
2. Generate secure encryption keys
3. Configure proper CORS settings
4. Use HTTPS in production
5. Keep environment files secure

## Troubleshooting

### Local Development
```bash
# Check container status
docker-compose ps

# View logs
npm run logs

# Reset everything
npm run clean && npm start
```

### Production
```bash
# SSH to your server
ssh root@your-server-ip

# Check deployment
cd /opt/phd-n8n
docker-compose ps
docker-compose logs

# Check nginx
nginx -t
systemctl status nginx
```

## Support
- Local access: http://localhost:5678
- Production access: https://phd.sharpy.dev
- Default credentials: admin / SecurePassword123!