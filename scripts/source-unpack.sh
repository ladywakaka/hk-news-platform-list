#!/bin/sh
# Decrypt and unpack the private source into ./hk-news-source (ignored by git).
# Needs the key in your macOS Keychain (item "hk-news-dashboard-source-key").
set -e
cd "$(dirname "$0")/.."
K="$(security find-generic-password -a hk-news-platform-list -s hk-news-dashboard-source-key -w)" \
  openssl enc -d -aes-256-cbc -pbkdf2 -iter 200000 -md sha256 \
  -in source/hk-news-source.tar.gz.enc -pass env:K | tar -xzf -
echo "Unpacked to ./hk-news-source. Rebuild with: cd hk-news-source && python3 build.py"
