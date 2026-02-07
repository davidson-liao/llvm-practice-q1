# M1W2D1 · 第2周 周一 · LLVM/C++

基建期第 2 周第 1 天：在 W1D1 基础上深化 LLVM 架构、isa/cast、手写 IR。

## 在 Cursor 中执行

```bash
cmake -B build && cmake --build build
./build/daytool
ctest --test-dir build
```

## 目录说明

| 目录/文件 | 说明 |
|-----------|------|
| `include/` | 头文件 |
| `lib/` | 库源码 |
| `tools/` | 可执行工具 |
| `test/` | 测试 |
| `plan.md` | 本日学习与任务（可对照 M1/W1/M1W1D1） |
