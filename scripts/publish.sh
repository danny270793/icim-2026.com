set -e
cd "$(dirname "$0")/.."

# Same default as compose.dev.yml / compose.prod.yml
IMAGE="${IMAGE:-ghcr.io/danny270793/icim-2026.com/backend}"
TAG="${TAG:-latest}"
DOCKERFILE="${DOCKERFILE:-dockerfile}"

while [ $# -gt 0 ]; do
  case "$1" in
    -t | --tag)
      TAG="$2"
      shift 2
      ;;
    -h | --help)
      echo "Usage: $0 [-t|--tag TAG]"
      echo ""
      echo "Build project dockerfile and push to GHCR."
      echo "Override with env: IMAGE, TAG, DOCKERFILE"
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

echo "Building ${IMAGE}:${TAG}"
docker build -f "$DOCKERFILE" -t "${IMAGE}:${TAG}" .

echo "Pushing ${IMAGE}:${TAG}"
docker push "${IMAGE}:${TAG}"
