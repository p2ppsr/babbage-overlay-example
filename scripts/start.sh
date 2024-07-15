#!/bin/bash

if [ $NODE_ENV = 'production' ] || [ $NODE_ENV = 'staging' ]
then
  npm run build
  node --inspect=0.0.0.0 dist/src/index.js
  exit
fi

# echo "Runtime env vars debug"
# perl -MData::Dumper -E 'print Dumper \%ENV'

until nc -z -v -w30 overlay-services 3113
do
  echo "Waiting for database connection..."
  sleep 1
done
knex migrate:latest
node --inspect=0.0.0.0 dist/src/index.js
