# M3W2D2 参考资料

> 对照 M3W1D2 深化练习：Dialect Conversion、TypeConverter、Materialization。

---

## 一、基础资料（必先完成 M3W1D2）

请先阅读 **M3/W1/M3W1D2/ref.md**，掌握：
- ConversionTarget、TypeConverter、ConversionPattern
- Materialization、unrealized_conversion_cast 的插入与消除
- 自定义 Dialect 2～3 个 Op 降到 LLVM 的小管线

---

## 二、深化任务所需资料

### 2.1 深化 TypeConverter

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **多类型转换链** | 多个 addConversion | 复合类型、嵌套类型 |
| **Attribute 转换** | AttributeConverter | 属性随类型一起转换 |
| **Region 内类型** | convertRegionTypes | Block 参数、Region 内 SSA 类型 |

### 2.2 深化 Conversion

- 跨多级 Dialect：MyDialect → Linalg → MemRef → LLVM
- PartialConversion 与渐进合法化
- 错误处理：转换失败时的 Diagnostic、回滚

### 2.3 参考

- `mlir/lib/Conversion/` 中多步 Conversion
- `mlir/test/Conversion/` 端到端用例

---

## 三、推荐阅读顺序

1. 复习 M3W1D2/ref.md（约 10 分钟）
2. Dialect Conversion 进阶小节（约 25 分钟）
3. 选一个多步 Conversion 浏览（约 30 分钟）

---

## 四、代码组织提示

- `lib/`：TypeConverter、ConversionPattern 实现
- `tools/`：mlir-opt 管线或独立工具
- `test/`：.mlir 输入、FileCheck 验证转换后 IR

---

*在 M3W1D2 基础上，按本 ref 完成 Dialect Conversion 深化任务。*
