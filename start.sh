#!/bin/bash

set -eu
cd /app/data

mkdir -p data/ dump/

# Create temporary log dir
mkdir -p /var/log/gunicorn/
chown -Rh cloudron:cloudron /var/log/gunicorn/
chmod -R 774 /var/log/gunicorn/

mkdir -p /run/app/
ln -sf /var/log/gunicorn /run/app/gunicorn
chown -Rh cloudron:cloudron /run/app/gunicorn/

echo "=> Ensuring permissions"
chown -Rh cloudron:cloudron /app/data
chown -Rh cloudron:cloudron /app/code

echo "=> Fetching files from the internet"
/usr/local/bin/gosu cloudron:cloudron media_search -o

echo "=> Starting web app"
exec /usr/local/bin/gosu cloudron:cloudron \
    ${VIRTUAL_ENV}/bin/gunicorn \
        -b 0.0.0.0:8000 \
        -w 2 \
        --access-logfile /var/log/gunicorn/gunicorn-access.log \
        --error-logfile /var/log/gunicorn/gunicorn-error.log \
        'media_search.web:app'
