# n8n Heroku Deployment Guide

## Prerequisites

- [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) installed
- Docker installed (for local development)
- Git repository initialized

## Quick Deployment Steps

### 1. Create Heroku App
```bash
heroku create your-app-name
```

### 2. Set Container Stack
```bash
heroku stack:set container -a your-app-name
```

### 3. Add PostgreSQL Database
```bash
heroku addons:create heroku-postgresql:mini -a your-app-name
```

### 4. Set Environment Variables
```bash
# Basic Auth
heroku config:set N8N_BASIC_AUTH_ACTIVE=true -a your-app-name
heroku config:set N8N_BASIC_AUTH_USER=admin -a your-app-name
heroku config:set N8N_BASIC_AUTH_PASSWORD=your_secure_password -a your-app-name

# Host Configuration
heroku config:set N8N_HOST=your-app-name.herokuapp.com -a your-app-name
heroku config:set N8N_PROTOCOL=https -a your-app-name
heroku config:set WEBHOOK_URL=https://your-app-name.herokuapp.com/ -a your-app-name

# Database
heroku config:set DATABASE_TYPE=postgresdb -a your-app-name
heroku config:set DB_POSTGRESDB_SCHEMA=public -a your-app-name

# Security Keys (generate random 32-character strings)
heroku config:set N8N_ENCRYPTION_KEY=your_32_character_encryption_key -a your-app-name
heroku config:set N8N_USER_MANAGEMENT_JWT_SECRET=your_jwt_secret_key -a your-app-name

# Timezone
heroku config:set GENERIC_TIMEZONE=UTC -a your-app-name
```

### 5. Deploy to Heroku
```bash
git add .
git commit -m "Deploy n8n to Heroku"
git push heroku main
```

### 6. Open Your App
```bash
heroku open -a your-app-name
```

## Local Development

### Start Local Environment
```bash
npm run dev
```

### Stop Local Environment
```bash
npm run stop
```

### View Local Logs
```bash
npm run logs
```

## Configuration

### Environment Variables

The app uses the following environment variables:

- `N8N_BASIC_AUTH_USER` - Username for basic authentication
- `N8N_BASIC_AUTH_PASSWORD` - Password for basic authentication
- `N8N_HOST` - Your Heroku app domain
- `N8N_PROTOCOL` - Use `https` for production
- `WEBHOOK_URL` - Full webhook URL for your app
- `DATABASE_TYPE` - Set to `postgresdb` for PostgreSQL
- `N8N_ENCRYPTION_KEY` - 32-character encryption key
- `N8N_USER_MANAGEMENT_JWT_SECRET` - JWT secret for user management

### Database Configuration

Heroku automatically populates these from the PostgreSQL addon:
- `DATABASE_URL` - Complete database connection string
- Additional `DB_POSTGRESDB_*` variables are auto-configured

## Troubleshooting

### View Heroku Logs
```bash
heroku logs --tail -a your-app-name
```

### Check Config Variables
```bash
heroku config -a your-app-name
```

### Restart App
```bash
heroku restart -a your-app-name
```

### Scale Up/Down
```bash
heroku ps:scale web=1 -a your-app-name
```

## Security Notes

1. **Change default passwords** - Update `N8N_BASIC_AUTH_PASSWORD` before deployment
2. **Generate secure keys** - Create random strings for encryption and JWT secrets
3. **Use HTTPS** - Always set `N8N_PROTOCOL=https` in production
4. **Environment variables** - Never commit `.env` file to version control

## URLs

- **App URL**: https://your-app-name.herokuapp.com/
- **n8n Editor**: https://your-app-name.herokuapp.com/
- **Webhooks**: https://your-app-name.herokuapp.com/webhook/

## Cost Estimation

- **Heroku Dyno**: $7/month (Basic)
- **PostgreSQL**: $9/month (Mini)
- **Total**: ~$16/month

For higher traffic, consider upgrading to Standard dynos and Standard PostgreSQL plans.