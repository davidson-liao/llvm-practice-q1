# M1W3D3 参考资料

> 对照 M1W1D3 深化：Canonicalization、DRR 进阶。

---

## 一、基础资料（必先完成 W1D3/W2D3）

请先阅读 **M1/W1/M1W1D3/ref.md** 与 **M1/W2/M1W2D3/ref.md**，掌握：
- Canonicalization、C++ RewritePattern、DRR
- Lit + FileCheck 测试

---

## 二、深化任务所需资料

### 2.1 Canonicalization 进阶

| 资料 | 链接/位置 | 用途 |
|------|-----------|------|
| **GreedyPatternRewriteDriver** | `mlir/include/mlir/Transforms/GreedyPatternRewriteDriver.h` | maxIterations、strictMode |
| **Pattern 优先级** | PatternRewriter 文档 | Benefit、PatternBenefit |
| **多 Op 子图 Pattern** | `mlir/lib/Dialect/*/Transforms/` | 复杂 matchAndRewrite |

### 2.2 DRR 进阶

| 资料 | 链接/位置 | 用途 |
|------|-----------|------|
| **DeclarativeRewrites** | https://mlir.llvm.org/docs/DeclarativeRewrites/ | NativeCodeCall、约束组合 |
| **Arithmetic Canonicalization** | `mlir/include/mlir/Dialect/Arithmetic/IR/ArithmeticOps.td` | 大量 DRR 示例 |
| **自定义约束** | DRR 文档 | 在 Pat 中加复杂条件 |

### 2.3 建议深化方向

- 写匹配多 Op 子图的 C++ Pattern
- DRR 中使用 NativeCodeCall 做非平凡转换
- 为 Pattern 设置 Benefit，控制应用顺序

---

## 三、推荐阅读顺序

1. 复习 M1W1D3/ref.md、M1W2D3/ref.md（约 10 分钟）
2. DRR 文档中 NativeCodeCall、约束（约 25 分钟）
3. 选一个复杂 Dialect 的 Transforms 浏览（约 20 分钟）

---

## 四、代码组织

- `lib/`：C++ Pattern、Pass、DRR 生成
- `test/`：Lit 用例，覆盖新规则

---

*在 W1/W2 基础上，完成 Canonicalization、DRR 深化任务。*
