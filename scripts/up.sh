set -e

cd "$(dirname "$0")/.."

docker compose --env-file .env --env-file .env.local -f compose.yml -f compose.local.yml up
