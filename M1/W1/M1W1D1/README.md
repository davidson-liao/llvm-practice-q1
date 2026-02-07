# M1W1D1 · 周一 · LLVM/C++

基建期第 1 天：LLVM 基础架构、isa/cast/dyn_cast、手写 LLVM IR。

## 在 Cursor 中执行

```bash
# 配置与构建
cmake -B build
cmake --build build

# 运行工具
./build/daytool

# 运行测试
ctest --test-dir build
```

## 目录说明

| 目录/文件 | 说明 |
|-----------|------|
| `include/` | 头文件（可选） |
| `lib/` | 库源码（isa 遍历、IR 生成等） |
| `tools/` | 可执行工具入口 |
| `test/` | 单元测试或 Lit 测试 |
| `plan.md` | 本日学习与代码任务 |

## 今日目标

- 学：Module/Function/BasicBlock、isa/cast/dyn_cast、IRBuilder、Phi。
- 写：遍历 Function 用 isa/dyn_cast 统计与匹配；IRBuilder 生成带 if-else 的 max/abs，含 Phi。
