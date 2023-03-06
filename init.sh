#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

cd $DIR
./init.pkg.sh

cd $DIR/src/_/Pg/init
./uint.coffee

cd $DIR/src/_/Redis/init
./merge.coffee

cd $DIR
bun run cep -- -c src -o lib >/dev/null
./lib/_/Init/gen/build.js
./run.sh ./lib/_/Init/main.js
