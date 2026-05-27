#!/bin/bash
mkdir -p build
pushd build

COMMON_FLAGS="-fpermissive"

# Debug builds
g++ -g $COMMON_FLAGS ../sim86.cpp -o sim86_gcc_debug
clang++ -g -fuse-ld=lld $COMMON_FLAGS ../sim86.cpp -o sim86_clang_debug

# Release builds
g++ -O2 -g $COMMON_FLAGS ../sim86.cpp -o sim86_gcc_release
clang++ -O3 -g -fuse-ld=lld $COMMON_FLAGS ../sim86.cpp -o sim86_clang_release

# Shared library (debug)
g++ -g -shared -fPIC $COMMON_FLAGS ../sim86_lib.cpp -o libsim86_shared_debug.so

# Shared library (release)
g++ -O2 -g -shared -fPIC $COMMON_FLAGS ../sim86_lib.cpp -o libsim86_shared_release.so

# Copy shared libs
cp libsim86_shared*.so ../shared/

# Build test
g++ -g $COMMON_FLAGS ../shared/shared_library_test.cpp -o shared_library_test \
    -I../shared -L. -lsim86_shared_debug -Wl,-rpath,'$ORIGIN'

popd
