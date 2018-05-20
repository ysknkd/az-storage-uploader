#!/bin/sh

set -e

# ---- BEGIN CHECK ARGUMENTS
if [ -z $1 ] || [ -z $2 ]; then
  echo ''
  echo 'Usage:'
  echo '  ./az-storage-upload.sh <path_to_directory> <container_name>'
  echo ''
  exit 1
fi

rootdir=`echo $1 | sed -e 's/\/*$//g'`
container_name=$2

# ---- END CHECK ARGUMENTS

# ---- BEGIN CHECK AZURE ACCOUNT
# 
# Using Azure CLI 2.0 with Azure Storage
#   https://docs.microsoft.com/ja-jp/azure/storage/common/storage-azure-cli
# 
exists_account=false

if [ ! -z $AZURE_STORAGE_CONNECTION_STRING ]; then
  echo 'Exists Azure Storage Connection String'
  echo $AZURE_STORAGE_CONNECTION_STRING
  exists_account=true
elif [ ! -z $AZURE_STORAGE_ACCOUNT ] && [ ! -z $AZURE_STORAGE_ACCESS_KEY ]; then
  echo 'Exists Azure Storage Account'
  exists_account=true
fi

if ! $exists_account; then
  echo ''
  echo 'Please export the your Azure Account.'
  echo ''
  echo '  export AZURE_STORAGE_ACCOUNT=<storage_account_name>'
  echo '  export AZURE_STORAGE_ACCESS_KEY=<storage_account_key>'
  echo ''
  echo '  or'
  echo ''
  echo '  export AZURE_STORAGE_CONNECTION_STRING="<connection_string>"'
  echo ''
  echo '  Official document here. https://docs.microsoft.com/azure/storage/common/storage-azure-cli'
  echo ''
  exit 1
fi
# ---- END CHECK AZURE ACCOUNT

# ---- BEGIN functions
upload_files () {
  for file in $(ls $1); do

    fpath=$1/$file

    if [ -d $fpath ]; then
      upload_files $fpath
    else
      echo ''
      echo "Uploading ... '${fpath#$rootdir/}'"
      az storage blob upload --file $fpath --container-name $container_name --name ${fpath#$rootdir/}
    fi
  done
}
# ---- END functions

upload_files $rootdir

