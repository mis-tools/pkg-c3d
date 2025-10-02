#!/usr/bin/env bash
set -e

build_number=$1

# conda build script invoked using command:
#  ./scripts/build_using_docker.sh

# conda create -n build-env
# conda activate build-env

# conda install conda-build conda-verify

sed -i "s/  name:.*/  name: `grep ^package= scripts/builddeb.sh | cut -d= -f2 | tr -d '"'`/g" meta.yaml
sed -i "s/  version:.*/  version: `grep VERSION_VARS deps/c3d/CMakeLists.txt | tr '(' ' ' | cut -d' ' -f2,3,4 | tr ' ' '.'`/g" meta.yaml
sed -i "s/  number:.*/  number: ${build_number}/g" meta.yaml
sed -i "s/  path:.*/  path: output\/debian/g" meta.yaml

# uses the build.sh and the meta.yml files to create 
# a conda package
conda build --no-include-recipe --no-test --output-folder output/pkgs/ .
# conda build purge

echo "conda packages build:"; ls output/pkgs/*/*.conda
