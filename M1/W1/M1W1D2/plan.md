# M1W1D2 学习与代码计划

## 学什么

- TableGen 语法：`def`、`class`、`dag`、`list`、字段与继承。
- 用 ODS 定义自定义 Op：名称、参数（Operand / Attribute）、结果、文档。
- 属性 (Attribute) 与类型 (Type) 系统：Builtin 的 IntegerAttr / StringAttr / DenseElementsAttr；自定义 Attribute/Type 的 Storage 类与 Uniquer。

## 需要工具

| 工具 | 用途 |
|------|------|
| MLIR 源码（llvm-project 中） | TableGen 定义、ODS 框架、Dialect 示例 |
| mlir-tblgen / llvm-tblgen | 从 .td 生成 .inc 与 C++ |
| CMake：add_mlir_dialect_library、mlir_tablegen | 构建 Dialect 与 Op |
| MLIR 官方文档：Defining Dialects、ODS、AttributesAndTypes | 查语法与约定 |

## 需要写的代码

1. **TableGen / ODS**
   - 在一个自定义 Dialect 里用 ODS 定义 2～3 个 Op（如 `my_dialect.add`、`my_dialect.const`），包含 Operand、Attribute、Result。
   - 为其中一个 Op 加 Traits（如 `NoSideEffect`、`Commutative`）和简单 C++ Verifier（如检查维度或类型）。
2. **Attribute / Type**
   - 定义一个自定义 Attribute（如「带上下界的范围」）或简单自定义 Type，实现 Storage 类并注册到 Dialect；写一段 IR 使用该 Attribute/Type 并解析/打印。
