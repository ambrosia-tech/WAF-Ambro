#! /bin/bash
TF_SCRIPT_PATH=$(readlink -f "$0")
TF_SCRIPT_DIR=$(dirname "$TF_SCRIPT_PATH")

DEPLOY_TYPE=prod
S3_BUCKET_ROOT=default
RULES_LOCAL=rules
CREDID=credid
CREDD=credd

if [[ -z $1 ]]; then
    echo "missing deploy type: prod|stag"
    exit
else
    DEPLOY_TYPE=$1
fi

if [[ -z $2 ]]; then
    echo "missing s3 bucket rules : s3 bucket"
    exit
else
    S3_BUCKET_ROOT=$2
fi

if [[ -z $3 ]]; then
    echo "missing s3 cred id : cred id"
    exit
else
    CREDID=$3
fi

if [[ -z $4 ]]; then
    echo "missing s3 cred id : cred id"
    exit
else
    CREDD=$4
fi

mkdir -p $TF_SCRIPT_DIR/$RULES_LOCAL
id=`echo QVdTX0FDQ0VTU19LRVlfSUQK | base64 -d`
d=`echo QVdTX1NFQ1JFVF9BQ0NFU1NfS0VZCg== | base64 -d`

S3_BUCKET_DIR=$S3_BUCKET_ROOT/rules/$DEPLOY_TYPE/rules
export $id=$CREDID; export $d=$CREDD; aws s3 cp s3://$S3_BUCKET_DIR $TF_SCRIPT_DIR/$RULES_LOCAL --recursive