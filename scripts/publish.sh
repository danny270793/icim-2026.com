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

echo "Building ${IMAGE}:${VERSION}"
docker build -f dockerfile -t "${IMAGE}:${VERSION}" .

echo "Pushing ${IMAGE}:${VERSION}"
docker push "${IMAGE}:${VERSION}"
