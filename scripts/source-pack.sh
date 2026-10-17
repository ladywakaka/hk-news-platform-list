#!/bin/sh
# Re-encrypt ./hk-news-source into source/hk-news-source.tar.gz.enc after you change it.
# Also refreshes src/dashboard.html.enc from hk-news-source/index.html if you rebuilt it.
set -e
cd "$(dirname "$0")/.."
[ -d hk-news-source ] || { echo "Run scripts/source-unpack.sh first."; exit 1; }
K="$(security find-generic-password -a hk-news-platform-list -s hk-news-dashboard-source-key -w)"
if [ -f hk-news-source/index.html ]; then
  K="$K" openssl enc -aes-256-cbc -pbkdf2 -iter 200000 -md sha256 -salt \
    -in hk-news-source/index.html -out src/dashboard.html.enc -pass env:K
  echo "Updated src/dashboard.html.enc from hk-news-source/index.html"
fi
COPYFILE_DISABLE=1 tar --exclude='index.html' --exclude='__pycache__' -czf - hk-news-source | \
  K="$K" openssl enc -aes-256-cbc -pbkdf2 -iter 200000 -md sha256 -salt -out source/hk-news-source.tar.gz.enc -pass env:K
echo "Updated source/hk-news-source.tar.gz.enc. Commit and push to publish."
