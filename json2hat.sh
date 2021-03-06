#!/bin/bash
# clear; DBG=1 SH_LOCAL_JSON_PATH=./j.json SH_DSN='sortinghat:pwd@tcp(localhost:13306)/sortinghat?charset=utf8' ./json2hat.sh prod
# clear; DBG=1 SH_DSN="`cat ./secrets/SH_DSN.local.secret`" ./json2hat.sh prod
if [ -z "$1" ]
then
  echo "Please specify env as a 1st arg: prod|test|local"
  exit 1
fi
env="${1}"
if [ -z "${ES_URL}" ]
then
  export ES_URL="`cat ./secrets/ES_URL.${env}.secret`"
fi
if [ -z "${SH_DSN}" ]
then
  export SH_DSN="`cat ./secrets/SH_DSN.${env}.secret`"
fi
export REPO_ACCESS="`cat ./secrets/REPO_ACCESS.secret`"
export DRY_RUN=''
export SKIP_BOTS=1
# export SKIP_BOTS=''
export NO_PROFILE_UPDATE=1
export REPLACE=''
# export REPLACE=1
export ONLY_GGH_USERNAME=1
export ONLY_GGH_NAME=''
# export NAME_MATCH=0|1|2
export NAME_MATCH=1
export ORGS_RO=1
export MISSING_ORGS_CSV="missing_cncf_orgs.csv"
./json2hat
