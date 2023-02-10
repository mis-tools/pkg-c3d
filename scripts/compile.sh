#!/usr/bin/env bash
set -e
#set -x
script_dir=$(dirname "$0")
cwd=`pwd`

old_method=true
if [[ "$old_method" == true ]]; then
    # use a hardcoded version of itk, downloaded
    # as a tar ball and compiled from source
    #itk_version="4.5.0"
    itk_version="4.7.2"
    #itk_version=4.8.2
    #itk_version=5.2.1
    itk_dir_prefix="InsightToolkit"
    outputdir=$2
    source ${script_dir}/dwn_itk.sh $itk_dir_prefix $itk_version $outputdir

    itk_dir="$outputdir/$itk_dir_prefix-$itk_version"
else
    # use git submodule checkout version of itk,
    # needs to have added itk as git submodule deps/ITK
    itk_dir="deps/ITK"
fi

# build dependencies
build_script=$1
source $build_script $itk_dir

# make c3d
mkdir -p $outputdir/build
cd $outputdir/build
cmake $cwd/deps/c3d/ \
-DCMAKE_INSTALL_PREFIX=../install \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_C_COMPILER=/usr/bin/gcc \
-DCMAKE_CXX_COMPILER=/usr/bin/g++ \
-DCMAKE_CXX_FLAGS="-fpermissive" \
-DCMAKE_EXE_LINKER_FLAGS="-static" \
-DITK_DIR=$cwd/$itk_dir/build

n=`nproc`
make -j $n install
cd $cwd
