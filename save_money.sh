#!/bin/bash
BUILD_DIR="/mnt/llvm_workspace/llvm-project/build"
WORKSPACE="/mnt/llvm_workspace"

echo "🌙 准备下班，正在执行工业级清理程序..."

if [ -d "$BUILD_DIR" ]; then
    # 1. 备份 Cursor 索引文件 (非常重要，否则下次打开 Cursor 会全红报错)
    cp "$BUILD_DIR/compile_commands.json" "$WORKSPACE/compile_commands.json.bak" 2>/dev/null
    
    # 2. 精准删除中间件
    # 删掉 .o (目标文件) 和 .a (静态库)，它们体积最大且重编成本最低
    find "$BUILD_DIR" -type f \( -name "*.o" -o -name "*.a" \) -delete
    
    # 💡 关键修改：处理 .dwo 文件 (调试符号)
    # 如果你明天想用 gdb/lldb 调试，请保留 .dwo；如果你只想运行，请把下面这行前面的 # 删掉
    # find "$BUILD_DIR" -name "*.dwo" -delete
    
    # 3. 检查 ccache 是否在数据盘
    # 默认 ccache 可能在 ~/.ccache (系统盘)，如果不迁移，明天就得从 0% 命中率开始
    if [ ! -d "$WORKSPACE/.ccache" ]; then
        echo "⚠️ 警告: ccache 似乎在系统盘，建议搬迁到数据盘以保留缓存数据。"
    fi

    echo "✅ 瘦身完成！bin/ 目录下的二进制工具已完整保留。"
fi

echo "--------------------------------------------------"
echo "📊 当前磁盘占用情况："
df -h "$WORKSPACE" | grep "$WORKSPACE"
echo "--------------------------------------------------"
echo "👉 接下来请执行： [创建快照] -> [确认 100%] -> [销毁实例]"