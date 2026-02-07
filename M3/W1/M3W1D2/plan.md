# M3W1D2 学习与代码计划

## 学什么

- 完整 Dialect 层级：Builtin、Linalg、Vector、MemRef、LLVM 等角色；Tensor -> MemRef -> LLVM 的层次。
- 跨方言转换 (Conversion)：TypeConverter、Pattern 里类型转换、Materialization、unrealized_conversion_cast 的插入与消除。

## 需要工具

| 工具 | 用途 |
|------|------|
| MLIR Dialect Conversion 文档与源码 | ConversionTarget、TypeConverter、Pattern |
| mlir-opt：-convert-*-to-llvm 等 | 观察多步 Conversion |

## 需要写的代码

1. **TypeConverter**
   - 写一个从「自定义类型 A」到「MemRef 或 LLVM 类型」的 TypeConverter，并实现对应的 ConversionPattern，在测试里跑通一小段 IR。
2. **Materialization**
   - 在 Conversion 中故意制造「使用者尚未转换」的场景，观察框架插入的 unrealized_conversion_cast；确认在全部合法化后这些 cast 被消除或报错。
3. **小管线**
   - 把「自定义 Dialect 的 2～3 个 Op」通过 Conversion 降到 LLVM Dialect，用 mlir-opt 跑通并生成 LLVM IR。
