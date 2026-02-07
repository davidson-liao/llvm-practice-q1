# M1W2D2 参考资料

> 对照 M1W1D2 深化练习：更多 Op、更复杂 Verifier、第二个自定义 Type。

---

## 一、基础资料（必先完成 M1W1D2）

请先阅读 **M1/W1/M1W1D2/ref.md**，掌握：
- ODS 定义 Op（Operand、Attribute、Result）
- Traits、C++ Verifier
- 自定义 Attribute/Type 的 Storage 与 Uniquer

---

## 二、深化任务所需资料

### 2.1 增加更多 Op

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **ODS 高级语法** | https://mlir.llvm.org/docs/DefiningDialects/Operations/ | Variadic、Optional、默认值 |
| **Arithmetic Dialect** | `mlir/include/mlir/Dialect/Arithmetic/IR/ArithmeticOps.td` | add/sub/mul/div 等参考 |
| **Linalg 结构化 Op** | `mlir/include/mlir/Dialect/Linalg/IR/` | 复杂 Operand 与 Region |

### 2.2 更复杂 Verifier

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **ODS Verifier** | ODS 文档中 `hasVerifier`、`let verifier` | 在 .td 中声明 |
| **verify() 实现** | `mlir/lib/Dialect/*/IR/*Ops.cpp` | 检查维度、类型、属性范围 |
| **emitOpError** | `mlir/include/mlir/Support/LogicalResult.h` | 返回有意义的错误信息 |

示例：检查张量维度匹配、属性在合法范围内。

### 2.3 第二个自定义 Type 并参与 Op 约束

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **Defining Attributes and Types** | https://mlir.llvm.org/docs/DefiningDialects/AttributesAndTypes/ | 第二个 Type 的 Storage |
| **Type 约束** | ODS 中 `ins MyCustomType:$x` | 让 Op 只接受该类型 |
| **Tensor Dialect 自定义类型** | `mlir/include/mlir/Dialect/Tensor/IR/` | 参考 RankedTensorType 等 |

### 2.4 参考 Dialect

- `mlir/examples/toy/` — 完整 Dialect + 多种 Op
- `mlir/include/mlir/Dialect/Tensor/IR/` — 自定义 Type 与约束

---

## 三、推荐阅读顺序

1. 复习 M1W1D2/ref.md（约 15 分钟）
2. ODS 文档中 Variadic、Optional、Verifier 小节（约 20 分钟）
3. 浏览 Arithmetic / Tensor 的 .td 与 .cpp（约 25 分钟）

---

## 四、代码组织提示

- `lib/`：Dialect 实现、Op 实现、Type/Attribute Storage
- `tools/`：测试工具或 mlir-opt 入口
- `test/`：合法/非法 IR 用例，验证 Verifier 与解析/打印

---

*在 M1W1D2 基础上，按本 ref 完成更多 Op、复杂 Verifier、第二自定义 Type 的深化任务。*
