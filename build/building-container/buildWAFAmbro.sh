#! /bin/bash
SCRIPT_PATH=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")


NGNIX_MODSEC_SRC_DIR=$SCRIPT_DIR/../../ngx-http-modsecurity
BUILD_TMP=$SCRIPT_DIR/build_tmp

#build modsecurity
sudo DOCKER_BUILDKIT=1 docker build --progress=plain -t waf-ambro-builder -f DockerfileWAFAmbroBuilder .

#build ngx and http modsecurity (using local code)
sudo docker run -v $BUILD_TMP:/build_tmp -v $NGNIX_MODSEC_SRC_DIR:/data/ngx-http-modsecurity -it waf-ambro-builder

#waf ambro container.
sudo DOCKER_BUILDKIT=1 docker build --progress=plain -t waf-ambro -f DockerfileWAFAmbro .
