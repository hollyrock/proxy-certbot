# HTTPS Proxy Skeleton for Web Applications

## Overview

This repository provides a minimal, production‑oriented **HTTPS reverse proxy setup using Nginx and Certbot** for containerized web applications.  
It is designed to sit in front of an application container (for example, a Django app defined as `webapp-earth` in `docker-compose.yml`) and terminate TLS using Let’s Encrypt certificates.

The setup is intentionally lightweight so you can adapt it to different backends and environments.

## Architecture

This project uses Docker to orchestrate the following main components:

- **Nginx**: Acts as the public‑facing reverse proxy, terminating HTTPS and forwarding requests to the application container.
- **Certbot**: Obtains and renews TLS certificates from Let’s Encrypt for your domain(s).
- **Application container (e.g. `webapp-earth`)**: Your actual web application, such as a Django app running behind the proxy.

The exact container definitions and wiring are described in `docker-compose.yml`.

## Configuration

Nginx configuration for the proxy lives under the `proxy/` directory.

- **Base sample config**: `proxy/default_sample.conf`  
  Copy and adapt this file to match your environment (domains, upstream host/port, etc.).
- **Production config**: `proxy/default_prod.conf`  
  After editing the sample, rename it to `default_prod.conf`. This file is mounted into the Nginx container and used as the active configuration.

Typical changes you may need to make:

- **Server name(s)**: Replace the placeholder domain with your real domain(s).
- **Upstream application**: Point Nginx to the correct hostname and port of your app container (for example, `webapp-earth:8000`).
- **HTTP → HTTPS redirect**: Confirm or adjust the redirect behavior according to your requirements.

## Prerequisites

Before running this stack, ensure you have:

- A **domain name** pointing to the host where these containers will run (A/AAAA DNS records).
- **Docker** and **Docker Compose** installed on the host.
- Ports **80** and **443** available on the host (required for HTTP and HTTPS traffic, and for Let’s Encrypt HTTP‑01 challenges).

## How to Run

1. **Clone the repository**

   ```bash
   git clone <YOUR_REPO_URL> kicori
   cd kicori
   ```

2. **Configure Nginx**

   ```bash
   cd proxy
   cp default_sample.conf default_prod.conf
   # Edit default_prod.conf to match your domain and upstream app
   ```

3. **Review `docker-compose.yml`**

   - Confirm the service name of your application container (for example, `webapp-earth`).
   - Make sure the upstream configuration in `default_prod.conf` matches the application service and port.

4. **Start the stack**

   From the project root:

   ```bash
   docker compose up -d
   ```

   This will start Nginx, Certbot, and your application containers in the background.

5. **Access your application**

   Once the containers are up and Let's Encrypt has successfully issued a certificate, your application should be accessible via:

   ```text
   https://your-domain.example.com
   ```

## Notes and Customization

- **Certificate renewal**: Certbot is intended to handle automatic renewal of certificates. Ensure that any renewal hooks or cron/systemd timers defined in the image or `entrypoint.sh` meet your operational requirements.
- **Backend applications**: Although this environment was initially created for a **Django + Nginx + uWSGI + Certbot** stack, you can adapt it to other backends (Node.js, Flask, etc.) by adjusting the upstream configuration.
- **Security hardening**: For production, review and harden the Nginx configuration (TLS versions, ciphers, headers such as HSTS, etc.) according to your security policies.

## Troubleshooting

- **Certificates not issued**:  
  - Check that your domain’s DNS records point to the correct server.  
  - Ensure ports 80 and 443 are not blocked by a firewall or occupied by another service.
- **502/504 errors**:  
  - Verify that the application container is running and listening on the port referenced in `default_prod.conf`.  
  - Confirm the upstream configuration (host and port) is correct.

This README is meant as a starting point—feel free to extend it with details specific to your deployment or application. 
