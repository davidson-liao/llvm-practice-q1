# M1W2D3 参考资料

> 对照 M1W1D3 深化练习：更多 DRR、复杂 C++ Pattern、补充 Lit 用例。

---

## 一、基础资料（必先完成 M1W1D3）

请先阅读 **M1/W1/M1W1D3/ref.md**，掌握：
- Canonicalization、Match-Rewrite、GreedyPatternRewriteDriver
- C++ RewritePattern、声明式 DRR
- Lit + FileCheck 测试

---

## 二、深化任务所需资料

### 2.1 更多 DRR 规则（如 sub x, 0 -> x）

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **Arithmetic Canonicalization** | `mlir/include/mlir/Dialect/Arithmetic/IR/ArithmeticOps.td` | sub/and/or/xor 等 DRR |
| **Pat<> 约束** | https://mlir.llvm.org/docs/DeclarativeRewrites/ | NativeCodeCall、附加约束 |
| **replaceWithValue** | DRR 文档 | 单值替换 |

示例 DRR：`subi $x, 0` -> `$x`，`muli $x, 1` -> `$x`。

### 2.2 复杂子图的 C++ Pattern

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **matchAndRewrite 多 Op** | PatternRewriter 文档 | 匹配跨多个 Op 的子图 |
| **Pattern 匹配 API** | `matchPattern`、`llvm::dyn_cast` | 递归匹配嵌套结构 |
| **Linalg/SCF 的 C++ Pattern** | `mlir/lib/Dialect/*/Transforms/` | 复杂图重写参考 |

思路：匹配如 `(add (mul a, 0), b)` 这样的子图，重写为 `b`。

### 2.3 补充 Lit 用例

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **FileCheck 变量与 DAG** | https://llvm.org/docs/CommandGuide/FileCheck.html | `[[VAR]]`、`CHECK-DAG` |
| **split-input-file** | Lit 用法 | 一个文件多测试用例 |
| **Arithmetic canonicalize 测试** | `mlir/test/Dialect/Arithmetic/canonicalize.mlir` | 用例组织方式 |

建议：为每条 DRR 写一个正向用例（能消掉）和一个边界用例（不应消掉）。

---

## 三、推荐阅读顺序

1. 复习 M1W1D3/ref.md（约 10 分钟）
2. Arithmetic 的 .td 中 DRR 部分（约 25 分钟）
3. 选一个 C++ Pattern 复杂的 Dialect 浏览（约 20 分钟）
4. 补充 2～3 个 Lit 用例（实践）

---

## 四、代码组织提示

- `lib/`：C++ Pattern、Pass、生成的 DRR .inc
- `test/`：.mlir Lit 测试，覆盖各条规则

---

*在 M1W1D3 基础上，按本 ref 完成更多 DRR、复杂 Pattern、Lit 用例的深化任务。*
