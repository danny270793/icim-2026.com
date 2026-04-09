#!/usr/bin/env bash
set -e
cd "$(dirname "$0")/.."

flavour=dev
dry_run=0
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
    --dry-run)
      dry_run=1
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

if [ "$dry_run" -eq 1 ]; then
  echo "=== Environment files (Compose order; later file wins on duplicate keys) ==="
  for f in "${env_files[@]}"; do
    echo "--- ${f} ---"
    if [ -f "$f" ]; then
      cat "$f"
    else
      echo "(missing)"
    fi
    echo
  done
  echo "Host environment still affects Compose interpolation (exported vars). Showing file contents only above."
  echo
  echo "=== docker compose config (merged, interpolated) ==="
  docker compose "${compose_args[@]}" config
  echo
  echo "=== Command that would run ==="
  printf '%q ' docker compose "${compose_args[@]}" "${up_cmd[@]}"
  if [ $# -gt 0 ]; then
    printf '%q ' "$@"
  fi
  echo
  exit 0
fi

docker compose "${compose_args[@]}" "${up_cmd[@]}" "$@"
