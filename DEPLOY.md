# n8n Local Development Setup

## Prerequisites

- Docker and Docker Compose installed
- Git repository initialized

## Quick Setup

### 1. Clone and Setup Environment
```bash
git clone <your-repo-url>
cd phd-n8n
cp .env.example .env
```

### 2. Configure Environment Variables
Edit the `.env` file with your preferred settings:
```bash
# Update authentication credentials
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=your_secure_password

# Generate secure keys (32 characters each)
N8N_ENCRYPTION_KEY=your_32_character_encryption_key
N8N_USER_MANAGEMENT_JWT_SECRET=your_jwt_secret_key
```

### 3. Start the Application
```bash
npm start
```

### 4. Access n8n
Open your browser and go to: http://localhost:5678

Log in with your configured credentials (default: admin/password)

## Available Commands

### Start Services
```bash
npm start          # Start n8n and PostgreSQL in detached mode
```

### Stop Services
```bash
npm stop           # Stop all services
```

### View Logs
```bash
npm run logs       # Follow n8n logs in real-time
```

### Restart Services
```bash
npm run restart    # Restart all services
```

### Clean Reset
```bash
npm run clean      # Stop services and remove all data volumes
```

## Configuration

### Environment Variables

The application uses these key environment variables (see `.env.example`):

- `N8N_BASIC_AUTH_USER` - Username for basic authentication
- `N8N_BASIC_AUTH_PASSWORD` - Password for basic authentication
- `N8N_HOST` - Host address (localhost for local development)
- `N8N_PORT` - Port number (5678)
- `N8N_PROTOCOL` - Protocol (http for local, https for production)
- `WEBHOOK_URL` - Full webhook URL
- `DATABASE_TYPE` - Database type (postgresdb)
- `N8N_ENCRYPTION_KEY` - 32-character encryption key
- `N8N_USER_MANAGEMENT_JWT_SECRET` - JWT secret for user management

### Database Configuration

PostgreSQL is automatically configured via Docker Compose:
- **Database**: n8n
- **User**: n8n
- **Password**: n8n
- **Host**: postgres (internal Docker network)
- **Port**: 5432

## Data Persistence

- n8n data is stored in the `n8n_data` Docker volume
- PostgreSQL data is stored in the `postgres_data` Docker volume
- Use `npm run clean` to remove all data and start fresh

## Troubleshooting

### View All Logs
```bash
docker-compose logs -f
```

### Check Running Containers
```bash
docker-compose ps
```

### Reset Everything
```bash
npm run clean
npm start
```

### Manual Database Access
```bash
docker-compose exec postgres psql -U n8n -d n8n
```

## Security Notes

1. **Change default passwords** - Update credentials in `.env` before first run
2. **Generate secure keys** - Create random 32-character strings for encryption keys
3. **Environment files** - Never commit `.env` file to version control
4. **Network access** - Application is accessible only on localhost by default

## URLs

- **n8n Editor**: http://localhost:5678/
- **Webhooks**: http://localhost:5678/webhook/
- **API**: http://localhost:5678/api/

## Development Tips

- Use `npm run logs` to monitor application behavior
- The PostgreSQL database persists data between restarts
- Use `npm run clean` for a completely fresh start
- Environment variables can be modified in `.env` (restart required)