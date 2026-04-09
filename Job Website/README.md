<<<<<<< HEAD
# Job Website - Job Posting Platform

A full-stack job posting and job search platform built with Laravel and Next.js, deployed using Docker and Docker Compose with PostgreSQL database.

**Technology:** PHP/Laravel, JavaScript/React, PostgreSQL, Docker  
**Architecture:** Containerized microservices with Docker Compose

## Overview

The Job Website is a comprehensive job portal that allows employers to post job openings and job seekers to search and apply for positions. The platform features a modern tech stack with a Laravel backend API, a React/Next.js frontend, and a PostgreSQL database, all orchestrated using Docker for easy deployment and scalability.

## Technology Stack

### Backend
- **Framework:** Laravel 11.9+
- **Language:** PHP 8.2+
- **Testing:** Pest PHP with Laravel plugins
- **Database:** PostgreSQL
- **API:** RESTful API with Laravel

### Frontend
- **Framework:** Next.js
- **Language:** JavaScript/React
- **Styling:** CSS/Tailwind CSS (if applicable)

### Infrastructure
- **Containerization:** Docker
- **Orchestration:** Docker Compose
- **Database:** PostgreSQL
- **Development Server:** Apache (optional)

## Features

- 🔍 **Job Search:** Advanced search and filtering for job postings
- 📝 **Job Posting:** Employers can create and manage job listings
- 👤 **User Management:** Registration and profile management for both job seekers and employers
- 💼 **Application Tracking:** Track job applications and candidate profiles
- 🔐 **Authentication:** Secure user authentication and authorization
- 📊 **Analytics:** Job posting performance and application metrics
- 🌐 **Responsive Design:** Mobile-friendly interface
- 🐳 **Containerized Deployment:** Easy setup and deployment with Docker

## Project Structure

```
Job Website/
├── Dockerfile                # Docker image configuration
├── docker-compose.yml        # Multi-container orchestration
├── index.php                 # Entry point (if applicable)
├── composer.json             # PHP dependencies
├── config/                   # Configuration files
│   └── apache/              # Apache configuration
├── jobsapp/                 # Main Laravel application
│   ├── artisan              # Laravel command line tool
│   ├── app/                 # Application code
│   │   └── Models/          # Eloquent models
│   ├── config/              # Laravel configuration
│   ├── database/            # Database migrations and seeders
│   ├── resources/           # Views and assets
│   ├── routes/              # Route definitions
│   ├── storage/             # File storage
│   ├── tests/               # Test suite
│   ├── bootstrap/           # Framework bootstrap
│   ├── public/              # Public assets
│   ├── composer.json        # Composer dependencies
│   ├── package.json         # Node dependencies
│   ├── vite.config.js       # Vite configuration
│   └── README.md            # Laravel app documentation
├── postgres-data/           # PostgreSQL data persistence
│   ├── base/                # Database files
│   ├── global/              # Global database objects
│   └── [other postgres dirs] # PostreSQL directories
└── README.md                # This file
```

## Getting Started

### Prerequisites

- Docker and Docker Compose installed
- At least 2GB free disk space
- Port 80, 3000, and 5432 available (for Apache, frontend, and PostgreSQL respectively)

### Installation & Setup

1. **Clone the repository:**
```bash
git clone <repository-url>
cd "Job Website"
```

2. **Build and start containers:**
```bash
docker-compose up -d --build
```

3. **Install Laravel dependencies:**
```bash
docker-compose exec app composer install
```

4. **Generate Laravel app key:**
```bash
docker-compose exec app php artisan key:generate
```

5. **Run database migrations:**
```bash
docker-compose exec app php artisan migrate
```

6. **Seed the database (optional):**
```bash
docker-compose exec app php artisan db:seed
```

7. **Build frontend assets (if applicable):**
```bash
docker-compose exec app npm install
docker-compose exec app npm run dev
```

### Services

The Docker Compose configuration includes:

- **Web Server:** Apache on port 80
- **Application:** Laravel backend at `http://localhost`
- **Database:** PostgreSQL on port 5432
- **Frontend:** (if configured) available at specified port

### Accessing the Application

- **Backend API:** http://localhost
- **Database:** `localhost:5432` (for direct connection)
- **Docker Containers:** Check status with `docker-compose ps`

## Development

### Running Commands

Execute Laravel commands:
```bash
docker-compose exec app php artisan <command>
```

Examples:
```bash
# Create a new migration
docker-compose exec app php artisan make:migration create_jobs_table

# Create a new model
docker-compose exec app php artisan make:model Job

# Run tests
docker-compose exec app php artisan test
# or with Pest
docker-compose exec app ./vendor/bin/pest
```

### Database Access

Connect to PostgreSQL directly:
```bash
docker-compose exec db psql -U postgres -d jobsapp
```

Or use a database client with:
- Host: localhost
- Port: 5432
- Username: postgres
- Password: (as defined in docker-compose.yml)

## Testing

Run the test suite with Pest:
```bash
docker-compose exec app ./vendor/bin/pest
```

Or with Laravel's built-in Test command:
```bash
docker-compose exec app php artisan test
```

## Database

### Migrations

Database schema is managed through Laravel migrations. Run migrations with:
```bash
docker-compose exec app php artisan migrate
```

Rollback migrations:
```bash
docker-compose exec app php artisan migrate:rollback
```

### Seeders

Populate the database with sample data:
```bash
docker-compose exec app php artisan db:seed
```

## Building for Production

### Build Docker Images

```bash
docker-compose -f docker-compose.yml build --no-cache
```

### Environment Configuration

Create a `.env` file from `.env.example` and configure:
- Database credentials
- API keys
- Application URL
- Mail settings

### Deployment

Push images to a container registry and deploy using:
- Kubernetes
- Docker Swarm
- AWS ECS
- Or other container orchestration platforms

## Troubleshooting

### Container Issues

View logs:
```bash
docker-compose logs -f
```

Restart services:
```bash
docker-compose restart
```

### Database Connection Issues

Verify database is running:
```bash
docker-compose ps
```

Check database migrations:
```bash
docker-compose exec app php artisan migrate:status
```

### Port Conflicts

If ports are in use, modify `docker-compose.yml`:
```yaml
ports:
  - "8080:80"      # Map to different host port
  - "5433:5432"    # Alternative PostgreSQL port
```

## Contributing

This is an academic project for Durham College. Contributions from team members are integrated through collaborative development with proper code review processes.

## Performance Considerations

- Use Docker volumes for persistent data storage
- Configure PostgreSQL connection pooling for production
- Implement caching strategies (Redis recommended)
- Use proper database indexing on frequently queried fields

## Security

- Never commit `.env` files with sensitive data
- Use strong database passwords
- Implement proper authentication and authorization
- Keep dependencies updated: `composer update` and `npm update`
- Run security audits: `composer audit` and `npm audit`

## Learning Resources

- [Laravel Documentation](https://laravel.com/docs)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)

## License

Academic project - Created for Durham College coursework

## Support

For issues, questions, or contributions related to this project, please contact the development team or create an issue in the repository.
=======
Job Website

Description:

A containerized web application that allows users to add and browse job listings.

Technologies:
- PHP
- Laravel
- Blade
- Docker
- PostgreSQL
- Git

Features:
- Browse job listings
- Add new listings
- Login in and sign up


Author:
Noor Ghani

This project was developed during the Fall 2024 semester at Durham College by Noor Ghani.
>>>>>>> 0535b048eac0f8cbecd9cb6e655b168a77b19664
