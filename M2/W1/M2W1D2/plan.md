# M2W1D2 学习与代码计划

## 学什么

- 接口 (Interface)：Concept-Model、OpInterface、ExternalModel；Pass 如何通过 Interface 操作多种 Op。
- Op 验证逻辑 (Verifier)：ODS 里 C++ 代码块、verify() 中检查类型/维度/属性一致性。
- 特征 (Trait)：NoSideEffect、Commutative、SymbolTable 等；与 Interface 的区别（声明式 vs 可查询方法）。

## 需要工具

| 工具 | 用途 |
|------|------|
| MLIR 文档：Interfaces、Traits | 定义与注册方式 |
| mlir-tblgen（OpInterface、Trait） | 生成 Interface 的 C++ |
| 已有 Dialect（如 linalg、tensor） | 参考 Interface/Trait 用法 |

## 需要写的代码

1. **定义 Interface**
   - 定义一个 OpInterface（如 `MyFoldable`），声明一个 `fold()` 方法；为本周 Dialect 的 1～2 个 Op 实现该 Interface（或 ExternalModel）。
   - 写一个 Pass：遍历 Op，用 `getOpInterface<MyFoldable>()` 调用 fold 并应用结果。
2. **Verifier**
   - 在某个自定义 Op 的 ODS 里加 C++ Verifier：检查操作数张量维度匹配或属性在合法范围内；写测试故意构造非法 IR，确认 verify 报错。
3. **Trait**
   - 给自定义 Op 加上 `HasFolder`、`Commutative` 等 Trait，观察 Canonicalize 是否自动应用对应规则；必要时补一条 DRR。
