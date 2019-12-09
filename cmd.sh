#!/usr/bin/env bash
set -e
echo "hello in bash"

if [ "$ENV" = 'DEV' ]; then
    echo "Running Development Server"
    exec python "app.py"
elif [ "$ENV" = 'UNIT' ]; then
    echo "Running Unit Tests"
    exec python "test.py"
else
    echo "Running Production Server"
    exec uwsgi --http 0.0.0.0:9090 --wsgi-file /app/app.py --callable app --stats 0.0.0.0:9191
fi