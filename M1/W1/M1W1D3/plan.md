# M1W1D3 学习与代码计划

## 学什么

- 规范化 (Canonicalization) 概念：图重写、等价变换、不动点。
- PatternRewrite 基础：Match-Rewrite、GreedyPatternRewriteDriver、Worklist。
- 手写 C++ RewritePattern 与声明式 DRR（TableGen Pat<>）。

## 需要工具

| 工具 | 用途 |
|------|------|
| MLIR 源码：GreedyPatternRewriteDriver、PatternRewriter | 理解驱动与 API |
| mlir-opt | 跑 Canonicalize 等 Pass |
| FileCheck | 做 Lit 回归测试、检查 IR 片段 |

## 需要写的代码

1. **C++ Pattern**
   - 实现一个 C++ RewritePattern：匹配「addi x, 0」或「muli x, 1」并重写为 x；在自定义 Pass 里用 `GreedyPatternRewriteDriver` 跑。
2. **声明式 DRR**
   - 用 TableGen 的 `Pat<>` 写 2～3 条 DRR（如 add 与 0、mul 与 1），生成 C++ 并注册到 Canonicalization；用 `mlir-opt -canonicalize` 验证。
3. **测试**
   - 写一个 Lit 测试：输入 .mlir、跑 canonicalize、用 FileCheck 检查关键 Op 是否被消掉或替换。
