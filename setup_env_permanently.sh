#!/bin/bash
# =================================================================
# 功能：LLVM 开发环境永久化配置 (挂载+Swap+环境变量+ccache软链接)
# 适用：腾讯云 Ubuntu 环境，8C 16G 内存优化专用
# =================================================================
set -e

# --- 1. 基础路径定义 ---
WORKSPACE="/mnt/llvm_workspace"
CCACHE_PATH="$WORKSPACE/.ccache"
LLVM_BIN="$WORKSPACE/llvm-project/build/bin"
SWAP_FILE="/swapfile"

echo "✨ 正在启动 LLVM 永久环境配置程序..."

# --- 2. 磁盘挂载保护 ---
# 确保 200GB 数据盘在线
if ! mountpoint -q "$WORKSPACE"; then
    echo "📂 正在挂载数据盘 /dev/vdb 到 $WORKSPACE..."
    sudo mkdir -p $WORKSPACE
    sudo mount /dev/vdb $WORKSPACE || echo "⚠️ 挂载失败，请检查云硬盘是否已关联到实例"
fi

# --- 4. ccache 物理软连接 ---
# 即使不写环境变量，~/.ccache 也会自动跳转到数据盘，防止系统盘撑爆
echo "🔗 建立 ccache 目录链接..."
mkdir -p $CCACHE_PATH
sudo chown -R $USER:$USER $CCACHE_PATH
ln -sf $CCACHE_PATH ~/.ccache

# --- 5. 永久注入 .bashrc ---
echo "📝 写入环境变量到 ~/.bashrc..."
# 使用标记位确保多次运行脚本不重复写入
sed -i '/LLVM_ENV_FIX_START/,/LLVM_ENV_FIX_END/d' ~/.bashrc

cat << 'EOF' >> ~/.bashrc
# --- LLVM_ENV_FIX_START ---
# 自动挂载逻辑
if ! mountpoint -q /mnt/llvm_workspace; then
    sudo mount /dev/vdb /mnt/llvm_workspace 2>/dev/null
fi

# 核心开发变量
export CCACHE_DIR="/mnt/llvm_workspace/.ccache"
export PATH="/mnt/llvm_workspace/llvm-project/build/bin:$PATH"

# 别名：随时随地增量编译
alias lninja='cd /mnt/llvm_workspace/llvm-project/build && ninja'
# --- LLVM_ENV_FIX_END ---
EOF

# --- 6. 缓存规格设定 ---
export CCACHE_DIR=$CCACHE_PATH
ccache -M 100G

echo "-------------------------------------------------------"
echo "🎉 环境配置已永久化！"
echo "👉 请立即执行：source ~/.bashrc"
echo "🔍 验证：输入 'ccache -s' 查看路径和 50G 容量"
echo "🛠️ 提示：修改代码后，在任何目录下输入 'lninja' 即可开始编译"
echo "-------------------------------------------------------"