#!/bin/bash
# 如果你想连这一步都省了，可以在腾讯云购买机器的页面，找到 “高级设置” -> “自定义脚本” (User Data)，把挂载逻辑放进去：
# 这段代码会在机器启动时自动执行
mkdir -p /mnt/llvm_workspace
mount /dev/vdb /mnt/llvm_workspace