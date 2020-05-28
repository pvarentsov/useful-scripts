CONTAINER_NAME=$1
DB_USER=$2
DUMP_PATH=$3

# Validate arguments

if [ -z "${CONTAINER_NAME}" ] || [ -z "${DB_USER}" ] || [ -z "${DUMP_PATH}" ]
then
    echo "Usage: dockerized-pg-restore.sh [container name] [db user] [dump path]"
    exit 1
fi

PARSED_DUMP_PATH=$(
  cd "$DUMP_PATH"
  pwd
)

cat "$DUMP_PATH" | docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER"