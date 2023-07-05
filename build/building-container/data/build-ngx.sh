#! /bin/bash
SCRIPT_PATH=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

BUILD_TMP=/build_tmp
NGNIX_BIN=$BUILD_TMP/nginx-bin
NGNIX_MODSEC_SRC=/data/ngx-http-modsecurity
NGNIX_SRC=/tmp/release/nginx

LIB_DIR=$BUILD_TMP/libs
MODSEC_CONFIG_DIR=$BUILD_TMP/modsec

mkdir -p $NGNIX_BIN
rm -rf $NGNIX_BIN/*

mkdir -p $LIB_DIR
rm -rf $LIB_DIR/*

cd $NGNIX_SRC
./configure --prefix=$NGNIX_BIN --with-http_ssl_module --with-http_v2_module --with-compat --add-dynamic-module=$NGNIX_MODSEC_SRC
make
make install

mkdir -p $MODSEC_CONFIG_DIR
rm -rf $MODSEC_CONFIG_DIR/*
curl -sSL https://raw.githubusercontent.com/SpiderLabs/ModSecurity/v3/master/modsecurity.conf-recommended \
         -o $MODSEC_CONFIG_DIR/modsecurity.conf

curl -sSL https://raw.githubusercontent.com/SpiderLabs/ModSecurity/v3/master/unicode.mapping \
         -o $MODSEC_CONFIG_DIR/unicode.mapping

cp /usr/local/modsecurity/lib/libmodsecurity* $LIB_DIR/
cp /usr/local/lib/liblmdb.so /$LIB_DIR/


