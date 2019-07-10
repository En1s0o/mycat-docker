#!/bin/sh

usage() {
  cat <<HERE
Usage:
  build.sh --from-local-dist [--archive <archive>] [--image-name <image>]
  build.sh --from-release --mycat-url <url> [--image-name <image>]
  build.sh --help

  If the --image-name flag is not used the built image name will be 'mycat'.
HERE
  exit 1
}

while [ $# -ge 1 ]
do
key="$1"
  case $key in
    --from-local-dist)
    FROM_LOCAL="true"
    ;;
    --from-release)
    FROM_RELEASE="true"
    ;;
    --image-name)
    IMAGE_NAME="$2"
    shift
    ;;
    --archive)
    ARCHIVE="$2"
    shift
    ;;
    --mycat-url)
    MYCAT_URL="$2"
    shift
    ;;
    --help)
    usage
    ;;
    *)
    # unknown option
    ;;
  esac
  shift
done

IMAGE_NAME=${IMAGE_NAME:-mycat}

# TMPDIR must be contained within the working directory so it is part of the
# Docker context. (i.e. it can't be mktemp'd in /tmp)
TMPDIR=_TMP_

cleanup() {
    rm -rf "${TMPDIR}"
}
trap cleanup EXIT

mkdir -p "${TMPDIR}"

if [ -n "${FROM_RELEASE}" ]; then

  [ -n "${MYCAT_URL}" ] || usage

  MYCAT_DIST=${TMPDIR}/Mycat.tar.gz

  echo "Downloading ${MYCAT_URL}"
  curl -s ${MYCAT_URL} --output ${MYCAT_DIST}

elif [ -n "${FROM_LOCAL}" ]; then

  if [ -n "${ARCHIVE}" ]; then
     DIST_DIR=${ARCHIVE}
  else 
     DIST_DIR=Mycat-*.tar.gz
  fi
  MYCAT_DIST=${TMPDIR}/Mycat.tar.gz
  echo "Using mycat dist: ${DIST_DIR}"
  cp ${DIST_DIR} ${MYCAT_DIST}

else

  usage

fi

docker build --build-arg mycat_dist="${MYCAT_DIST}" -t "${IMAGE_NAME}" .
