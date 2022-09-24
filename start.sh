#!/bin/bash

set -eu
cd /app/data

mkdir -p data/ dump/

echo "=> Ensuring permissions"
chown -Rh cloudron:cloudron /app/data
chown -Rh cloudron:cloudron /app/code

echo "=> Fetching files from the internet"
/usr/local/bin/gosu cloudron:cloudron media_search -o

echo "=> Starting web app"
exec /usr/local/bin/gosu cloudron:cloudron ${VIRTUAL_ENV}/bin/gunicorn -b 0.0.0.0:8000 -w 2 'media_search.web:app'
