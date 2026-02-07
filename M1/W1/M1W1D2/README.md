# M1W1D2 · 周二 · MLIR ODS

基建期第 2 天：TableGen 语法、定义自定义 Op、Attribute 与 Type 系统。

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
| `lib/` | Dialect/Op 实现、Attribute/Type Storage |
| `tools/` | 可执行工具 |
| `test/` | Lit 或 GTest |
| `plan.md` | 本日学习与代码任务 |

## 今日目标

- 学：TableGen/ODS、Operand/Attribute/Result、Traits、Verifier、自定义 Attribute/Type。
- 写：2～3 个 ODS Op（如 my_dialect.add/const）、自定义 Attribute 或 Type、Storage 类。
