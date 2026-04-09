set -e
cd "$(dirname "$0")/.."

flavour=dev
while [ $# -gt 0 ]; do
  case "$1" in
    --local)
      flavour=local
      shift
      ;;
    --dev)
      flavour=dev
      shift
      ;;
    --prod)
      flavour=prod
      shift
      ;;
    *)
      break
      ;;
  esac
done

case "$flavour" in
  local)
    docker compose --env-file .env --env-file .env.local -f compose.yml -f compose.local.yml up --build "$@"
    ;;
  dev)
    docker compose --env-file .env --env-file .env.dev -f compose.yml -f compose.dev.yml up "$@"
    ;;
  prod)
    docker compose --env-file .env --env-file .env.prod -f compose.yml -f compose.prod.yml up "$@"
    ;;
esac
