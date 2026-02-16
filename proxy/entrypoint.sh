#!/bin/sh

# Fix permissions for static and media files
# Note: chown is likely failing due to bind mount restrictions.
# Relying on chmod for read access by nginx user.
#chmod -R 755 /vol/web/static
#chmod -R 755 /vol/web/docs

# Start Nginx
nginx -g 'daemon off;'