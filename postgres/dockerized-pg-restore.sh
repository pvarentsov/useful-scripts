#!/usr/bin/env bash

set -e

CONTAINER_NAME=$1
DB_USER=$2
DUMP_PATH=$3

# Validate arguments

if [ -z "${CONTAINER_NAME}" ] || [ -z "${DB_USER}" ] || [ -z "${DUMP_PATH}" ]
then
    echo "Usage: $(basename $0) [container name] [db user] [dump path]"
    exit 1
fi

# Restore database

cat "$DUMP_PATH" | docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER"
