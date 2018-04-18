#!/usr/bin/env bash

export STATIC_ROOT="$DEPLOYMENT_TARGET/static"

function python () {
  "/d/home/python364x86/python.exe" "$@"
}

echo "Installing pip dependencies"

python3 -m pip3 install -r requirements.txt -q

echo "Cleaning up css/js files"

rm -r static/css
rm -r static/js

echo "Collecting static files"

python manage.py collectstatic --noinput --clear

echo "Running migrations"

python manage.py migrate

echo "Cleaning up deployment target"

rm -r $DEPLOYMENT_TARGET/driver

echo "Copying files to deployment target"

cp -R driver $DEPLOYMENT_TARGET/
cp web.config $DEPLOYMENT_TARGET/

echo "Making logs directory"

mkdir -p $DEPLOYMENT_TARGET/logs
