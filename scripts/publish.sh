set -e
cd "$(dirname "$0")/.."

if [ -f .env ]; then
  set -a
  # shellcheck disable=SC1091
  . ./.env
  set +a
fi

IMAGE="${IMAGE:-ghcr.io/danny270793/icim-2026.com/backend}"
VERSION="${VERSION:-latest}"

while [ $# -gt 0 ]; do
  case "$1" in
    -t | --version)
      VERSION="$2"
      shift 2
      ;;
    -h | --help)
      echo "Usage: $0 [-t|--version VERSION]"
      echo ""
      echo "Build project dockerfile and push to GHCR."
      echo "IMAGE and VERSION are read from .env; override with env or -t/--version."
      echo ""
      echo "Login once per machine:"
      echo '  echo $GITHUB_TOKEN | docker login ghcr.io -u USERNAME --password-stdin'
      exit 0
      ;;
    *)
      echo "Unknown option: $1 (try --help)" >&2
      exit 1
      ;;
  esac
done

bump_semver_patch() {
  local v="$1"
  if [[ "$v" =~ ^(v?)([0-9]+)\.([0-9]+)\.([0-9]+)$ ]]; then
    printf '%s%s.%s.%s' "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}" "${BASH_REMATCH[3]}" "$((${BASH_REMATCH[4]} + 1))"
  else
    printf '%s' "$v"
  fi
}

_base_version="$VERSION"
VERSION="$(bump_semver_patch "$VERSION")"
if [[ "$_base_version" != "$VERSION" ]]; then
  echo "Version ${VERSION} (semver patch +1 from ${_base_version})"
fi

echo "Building ${IMAGE}:${VERSION}"
docker build --platform linux/amd64 -f dockerfile -t "${IMAGE}:${VERSION}" -t "${IMAGE}:latest" .

echo "Pushing ${IMAGE}:${VERSION}"
docker push "${IMAGE}:${VERSION}"
docker push "${IMAGE}:latest"

if [[ "$_base_version" != "$VERSION" ]] && [ -f .env ]; then
  tmp="$(mktemp)"
  while IFS= read -r line || [ -n "$line" ]; do
    if [[ "$line" =~ ^VERSION= ]]; then
      printf 'VERSION=%s\n' "$VERSION"
    else
      printf '%s\n' "$line"
    fi
  done < ".env" > "$tmp" && mv "$tmp" .env
fi
