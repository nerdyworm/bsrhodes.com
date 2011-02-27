#!/bin/sh

set -e

GIT_REPO=$HOME/Documents/Workspace/bsrhodes.com
TMP_GIT_CLONE=$HOME/tmp/website
PUBLIC_WWW=$HOME/.s3w3
S3_BUCKET=bsrhodes.com

# setup s3
s3fs $S3_BUCKET $PUBLIC_WWW -o use_rrs=1 -o default_acl=public-read

git clone $GIT_REPO $TMP_GIT_CLONE
jekyll --no-auto $TMP_GIT_CLONE $PUBLIC_WWW
rm -Rf $TMP_GIT_CLONE

# unmount s3
fusermount -u $PUBLIC_WWW

exit
