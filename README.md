# Sign 2 English

A sign-language-to-English translation platform.

# Prerequisites

Ensure you have the following tools installed:

- [Docker](https://www.docker.com/get-started/)
- [GNU Make](https://www.gnu.org/software/make/): Recommended for command shortcuts.
- [npm](https://www.npmjs.com/): Recommended for local frontend development.
- [Poetry](https://python-poetry.org/docs/#installation): Recommended for local backend development.

# How to Use

Use these commands to manage your local development environment:

## Start the Local Environment

```bash
make up
```

## Follow Console Logs

```bash
make logs
```

## Stop the Local Environment

It's recommend to stop the local environment to release system resources when not developing.

```bash
make down
```

# Access the Services

Once the containers are running and healthy, you can access:

- Frontend pages: http://localhost:3000
- Backend API: http://localhost:8000
  - API Documentation (Swagger): http://localhost:8000/docs

# Development Guide

## Hot Reloading

Both services are configured with Docker Volumes. Any changes made to files in `frontend/` or `backend/src/` will trigger an automatic reload in the browser or server.

## Updating Dependencies

If you modify `package.json` or `pyproject.toml`, you must rebuild the images to update the internal Docker volumes:

```bash
make down && make build && make up
```

## Health Monitoring

We use native Docker health checks. You can verify if services are ready by running:

```bash
docker ps
```

Wait for the status to change from (starting) to (healthy).

# Project Structure

```Plaintext
.
├── frontend/
├── backend/
├── docker-compose.yml
└── Makefile
```
