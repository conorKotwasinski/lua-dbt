DOCKER_TAG=lua-dbt
DOCKER_BUILDKIT=1 docker build \
    --target project \
    --file Dockerfile \
    -t ${DOCKER_TAG} .
