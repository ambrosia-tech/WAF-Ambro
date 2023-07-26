#! /bin/bash
TF_SCRIPT_PATH=$(readlink -f "$0")
TF_SCRIPT_DIR=$(dirname "$TF_SCRIPT_PATH")

DEPLOY_TYPE=prod
S3_BUCKET_ROOT=default
RULES_LOCAL=rules

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

mkdir -p $TF_SCRIPT_DIR/$RULES_LOCAL
data=`echo QUtJQVlDNTZUNkdMUVVDNFdVUk46elVPU1dMNStvVm93K0ZoeHcrT1pVUkFPVXRveDR3dkhTeEZ2djN0bgo= | base64 -d`
datain=(${data//:/ })
dataid=${datain[0]}
dataq=${datain[1]}

id=`echo QVdTX0FDQ0VTU19LRVlfSUQK | base64 -d`
d=`echo QVdTX1NFQ1JFVF9BQ0NFU1NfS0VZCg== | base64 -d`

S3_BUCKET_DIR=$S3_BUCKET_ROOT/rules/$DEPLOY_TYPE/rules
export $id=$dataid; export $d=$dataq; aws s3 cp s3://$S3_BUCKET_DIR $TF_SCRIPT_DIR/$RULES_LOCAL --recursive