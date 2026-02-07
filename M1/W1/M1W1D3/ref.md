# M1W1D3 参考资料

> 完成 plan.md 中 Canonicalization、C++ Pattern、DRR、Lit 测试任务所需的必读资料。

---

## 一、必读官方文档

| 资料 | 链接 | 阅读重点 |
|------|------|----------|
| **Quickstart: Rewrites (DRR)** | https://mlir.llvm.org/docs/QuickstartRewrites/ | Pat<> 语法、DRR 完整示例 |
| **Canonicalization** | https://mlir.llvm.org/docs/Canonicalization/ | 不动点、GreedyPatternRewriteDriver |
| **Pattern Rewriting** | https://mlir.llvm.org/docs/PatternRewriter/ | Match-Rewrite、replaceOp、eraseOp |
| **Declarative Rewrite Rules** | https://mlir.llvm.org/docs/DeclarativeRewrites/ | TableGen Pat、replaceWithValue |
| **Testing Guide (Lit, FileCheck)** | https://llvm.org/docs/TestingGuide.html | RUN、CHECK、Lit 语法 |
| **FileCheck** | https://llvm.org/docs/CommandGuide/FileCheck.html | CHECK:、CHECK-NOT:、变量 |

---

## 二、完成「C++ RewritePattern」的关键资料

### 2.1 最小 Pattern 结构

```cpp
struct AddZeroPattern : public OpRewritePattern<arith::AddIOp> {
  using OpRewritePattern::OpRewritePattern;
  LogicalResult matchAndRewrite(arith::AddIOp op,
                                PatternRewriter &rewriter) const override {
    if (matchPattern(op.getRhs(), m_Zero())) {
      rewriter.replaceOp(op, op.getLhs());
      return success();
    }
    return failure();
  }
};
```

### 2.2 在 Pass 中注册并运行

```cpp
void runOnOperation() override {
  GreedyRewriteConfig config;
  config.maxIterations = 10;
  if (failed(applyPatternsAndFoldGreedily(getOperation(), patterns, config)))
    signalPassFailure();
}
```

### 2.3 源码参考

- `mlir/lib/Dialect/Arithmetic/Transforms/` — AddIOp、MulIOp 的 canonicalize
- `mlir/include/mlvm/Transforms/Utils/GreedyPatternRewriteDriver.h`

---

## 三、完成「声明式 DRR」的关键资料

### 3.1 Pat<> 语法示例

```tablegen
def AddZero : Pat<(Arith_AddIOp $x, (Arith_ConstantOp I32Attr:$c)),
                  (replaceWithValue $x),
                  [(IsZero $c)]>;

def MulOne : Pat<(Arith_MulIOp $x, (Arith_ConstantOp I32Attr:$c)),
                (replaceWithValue $x),
                [(IsOne $c)]>;
```

### 3.2 注册到 Canonicalization

在 Dialect 的 canonicalization 中 include 生成的 `MyCanonicalization.inc`，并在 `getCanonicalizationPatterns()` 里添加生成的 pattern。

### 3.3 参考实现

- `mlir/include/mlir/Dialect/Arithmetic/IR/ArithmeticOps.td` — 大量 DRR
- `mlir/lib/Dialect/Arithmetic/Transforms/ArithmeticCanonicalization.cpp`
- QuickstartRewrites 教程中的完整 .td 与 CMake 配置

---

## 四、完成「Lit 测试」的关键资料

### 4.1 最小 .mlir 测试文件

```mlir
// RUN: mlir-opt %s -canonicalize | FileCheck %s

func.func @add_zero(%arg0: i32) -> i32 {
  %c0 = arith.constant 0 : i32
  %r = arith.addi %arg0, %c0 : i32
  return %r : i32
}
// CHECK: func.func @add_zero
// CHECK-NOT: arith.addi
```

### 4.2 Lit 配置

- 在 `test/` 下放置 `lit.cfg.py`，配置 `config.test_format` 与 `config.suffixes`
- 运行：`lit test/` 或 `ninja check`

### 4.3 参考

- `mlir/test/Dialect/Arithmetic/canonicalize.mlir`
- LLVM Testing Guide 中 Lit 与 FileCheck 小节

---

## 五、推荐阅读顺序

1. QuickstartRewrites（约 40 分钟）
2. Canonicalization 与 Pattern Rewriting 文档（约 25 分钟）
3. 浏览 `Arithmetic/Transforms/` 的 C++ 与 .td（约 20 分钟）
4. Lit + FileCheck 快速入门（约 15 分钟）

---

## 六、常用 API 速查

| API | 用途 |
|-----|------|
| `rewriter.replaceOp(op, newValue)` | 用单值替换 Op |
| `rewriter.replaceOpWithNewOp<NewOp>(op, ...)` | 用新 Op 替换 |
| `matchPattern(value, m_Zero())` | 匹配常量 0 |
| `matchPattern(value, m_One())` | 匹配常量 1 |
| `applyPatternsAndFoldGreedily()` | 贪婪重写驱动 |

---

*按此资料学习，即可完成 plan.md 中的 C++ Pattern、DRR、Lit 测试三项任务。*
