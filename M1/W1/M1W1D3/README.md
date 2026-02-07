# M1W1D3 · 周三 · Pass / 融合基础

基建期第 3 天：Canonicalization、PatternRewrite、手写 C++ Pattern 与声明式 DRR。

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
| `lib/` | RewritePattern、DRR 生成代码 |
| `tools/` | mlir-opt 封装或测试入口 |
| `test/` | Lit + FileCheck 测试 |
| `plan.md` | 本日学习与代码任务 |

## 今日目标

- 学：Canonicalization、Match-Rewrite、GreedyPatternRewriteDriver、DRR。
- 写：C++ Pattern（addi x,0 -> x）、2～3 条 DRR、Lit 测试。
