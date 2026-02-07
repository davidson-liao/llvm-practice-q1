# M2W1D2 · 周二 · MLIR ODS / Interface

核心期第 2 天：定义 Interface、Op 验证逻辑 Verifier、Trait 的使用。

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
| `lib/` | OpInterface、ExternalModel、Verifier |
| `tools/` | 可执行工具 |
| `test/` | 非法 IR 验证、Canonicalize 行为 |
| `plan.md` | 本日学习与代码任务 |

## 今日目标

- 学：Concept-Model、OpInterface、Verifier、Trait 与 Interface 区别。
- 写：自定义 OpInterface（如 MyFoldable）、Verifier、Trait + DRR。
