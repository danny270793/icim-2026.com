#!/usr/bin/env bash
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
    env_files=(.env .env.local)
    compose_files=(compose.yml compose.local.yml)
    up_cmd=(up --build)
    ;;
  dev)
    env_files=(.env .env.dev)
    compose_files=(compose.yml compose.dev.yml)
    up_cmd=(up)
    ;;
  prod)
    env_files=(.env .env.prod)
    compose_files=(compose.yml compose.prod.yml)
    up_cmd=(up)
    ;;
  *)
    echo "Unknown flavour: $flavour" >&2
    exit 1
    ;;
esac

compose_args=()
for f in "${env_files[@]}"; do
  compose_args+=(--env-file "$f")
done
compose_args+=(-f "${compose_files[0]}" -f "${compose_files[1]}")

docker compose "${compose_args[@]}" "${up_cmd[@]}" "$@"
