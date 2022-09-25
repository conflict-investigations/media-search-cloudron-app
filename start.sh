#!/bin/bash

set -eu
cd /app/data

mkdir -p data/ dump/

# Create temporary log dir
mkdir -p /run/app/gunicorn/
chown -Rh cloudron:cloudron /run/app/gunicorn/
chmod -R 774 /run/app/gunicorn/

echo "=> Ensuring permissions"
chown -Rh cloudron:cloudron /app/data

# Disabled since the scheduler schould take care of this for us
# echo "=> Fetching files from the internet"
# /usr/local/bin/gosu cloudron:cloudron media_search -o

echo "=> Starting web app"
exec /usr/local/bin/gosu cloudron:cloudron \
    ${VIRTUAL_ENV}/bin/gunicorn \
        -b 0.0.0.0:8000 \
        -w 2 \
        --access-logfile /run/app/gunicorn/gunicorn-access.log \
        --error-logfile /run/app/gunicorn/gunicorn-error.log \
        'media_search.web:app'
