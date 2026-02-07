# M1W1D5 · 周五 · 工程 / 测试

基建期第 5 天：CMake 自动化、GTest 单元测试、Lit + FileCheck 回归测试。

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
| `lib/` | 本周 Dialect/Pass 代码 |
| `tools/` | 可执行工具 |
| `test/` | GTest、Lit + FileCheck |
| `plan.md` | 本日学习与代码任务 |

## 今日目标

- 学：add_mlir_dialect_library、mlir_tablegen、GTest、Lit/FileCheck。
- 写：完善 CMake、1～2 个 GTest、Lit 测试、可选性能基线。
