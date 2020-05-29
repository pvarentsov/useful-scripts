#!/usr/bin/env bash

set -e

CONTAINER_NAME=$1
DB_USER=$2
DUMP_FOLDER=$3

# Validate arguments

if [ -z "${CONTAINER_NAME}" ] || [ -z "${DB_USER}" ] || [ -z "${DUMP_FOLDER}" ]
then
    echo "Usage: $(basename $0) [container name] [db user] [dump folder]"
    exit 1
fi

# Generate full path of the dump file

PARSED_DUMP_FOLDER=$(
  set -e
  cd "$DUMP_FOLDER"
  pwd
)

DUMP_PATH="$PARSED_DUMP_FOLDER"/pgdump_`date +%d-%m-%Y"_"%H_%M_%S`.sql

# Dump database

docker exec -t "$CONTAINER_NAME" pg_dumpall -c -U "$DB_USER" > "$DUMP_PATH"

echo "Dump saved in $DUMP_PATH"
