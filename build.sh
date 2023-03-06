#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

rm -rf lib

bun run cep -- -c src -o lib >/dev/null

cd lib

set +x
echo 'replace DEBUG = false'
for file in $(fd -I --extension js); do
  sd 'DEBUG\s*=\s*true' 'DEBUG = false' "$file"
done
set -x

cd $DIR

GEN=$DIR/lib/_/Init/gen

$GEN/build.js
$GEN/gen.js

