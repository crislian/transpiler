#! /bin/shell


# Download the installer and run the following commands in your terminal
# bash Miniconda3-latest-Linux-x86_64.sh  # For Linux

# # Initialize conda
# conda init

# # Close and reopen the terminal, then create and activate your environment
# conda create -n myenv
# conda activate myenv

# # Install the compilers package
# conda install -c conda-forge compilers
# # unicode/ucnv.h file
# conda install icu

export llvm_root=`pwd`

cmake -S llvm-project-19.1.0.src/llvm -G Ninja \
-B build \
-DCMAKE_BUILD_TYPE=Release \
-DLLVM_ENABLE_RTTI=ON \
-DLLVM_TARGETS_TO_BUILD="Native" \
-DLLVM_ENABLE_PROJECTS="clang;lld;lldb" \
-DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind"

cmake --build build

cmake --install build --prefix "release-install"

cmake -S $llvm_src/llvm -G Ninja \
-B llvm-build \
-DCMAKE_BUILD_TYPE=Debug \
-DLLVM_ENABLE_RTTI=ON \
-DLLVM_TARGETS_TO_BUILD="Native" \
-DCMAKE_C_COMPILER="$llvm_root/release-install/bin/clang" \
-DCMAKE_CXX_COMPILER="$llvm_root/release-install/bin/clang++" \
-DLLVM_USE_LINKER="$llvm_root/release-install/bin/ld64.lld"

cmake -S $llvm_src/llvm -G Ninja \
-B llvm-build \
-DCMAKE_BUILD_TYPE=Release \
-DLLVM_ENABLE_RTTI=ON \
-DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind" \
-DLLVM_ENABLE_PROJECTS="clang;lld;lldb" \
-DLLVM_TARGETS_TO_BUILD="Native"