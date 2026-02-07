#!/bin/bash
set -e
export PS1='\W\$ '

# 基础路径配置
BASE_DIR="/mnt/llvm_workspace"
LLVM_SRC="$BASE_DIR/llvm-project"
BUILD_DIR="$LLVM_SRC/build"
CCACHE_DIR="$BASE_DIR/.ccache"

echo "🔧 步骤 1: 环境基础配置..."
sudo apt update -qq && sudo apt install -y cmake ninja-build ccache libz-dev libtinfo-dev lld g++ -qq

mkdir -p $CCACHE_DIR
ln -sf $CCACHE_DIR ~/.ccache
export CCACHE_DIR=$CCACHE_DIR
ccache -M 100G

# --- 3. CMake 智能判断逻辑 ---
mkdir -p $BUILD_DIR
cd $BUILD_DIR

# 判断 build.ninja 是否存在。
# 如果存在，说明已经配置过环境，直接跳过 cmake 步骤
if [ -f "build.ninja" ]; then
    echo "✅ 检测到已有构建配置 (build.ninja)，跳过 CMake 阶段..."
else
    echo "⚙️ 正在执行全量 CMake 配置..."
    cmake -G Ninja ../llvm \
        -DCMAKE_BUILD_TYPE=RelWithDebInfo \
        -DLLVM_ENABLE_PROJECTS="clang;mlir" \
        -DLLVM_TARGETS_TO_BUILD="X86;NVPTX" \
        -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
        -DLLVM_CCACHE_BUILD=ON \
        -DLLVM_USE_SPLIT_DWARF=ON \
        -DLLVM_USE_LINKER=lld \
        -DLLVM_PARALLEL_LINK_JOBS=1 
fi

# --- 4. 执行编译 ---
CORES=16
echo "🚀 正在调动 $CORES 核进行增量编译/检查..."
# 注意：直接运行 ninja 即可，它会自动处理剩余工作
ninja clang llc mlir-opt

echo "✅ 任务完成！"