#!/usr/bin/env sh
set -e

in=miniaudio.cpp
out="${in%.*}"

bin=build
obj=obj

cpp_version=-std=c++17
warnings="
 -Wall
 -Wextra
 -Werror
 -Wno-deprecated-declarations
 -Wno-unused-but-set-variable
"
includes="-I."
other="-O3"
compile_flags="${cpp_version} ${warnings} ${includes} ${other}"

mkdir -p $bin
mkdir -p $obj

c++ $compile_flags -c $in -o $obj/${out}
ar rcs $bin/lib${out}.a $obj/${out}

