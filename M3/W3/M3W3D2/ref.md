# M3W3D2 参考资料

> 对照 M3W1D2 深化练习：Dialect Conversion、TypeConverter、Materialization。

---

## 一、基础资料（必先完成 M3W1D2）

请先阅读 **M3/W1/M3W1D2/ref.md**，掌握：
- ConversionTarget、TypeConverter、ConversionPattern
- Materialization、unrealized_conversion_cast
- 自定义 Dialect 降到 LLVM 的小管线

---

## 二、深化任务所需资料

### 2.1 深化 Dialect Conversion

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **多级 Conversion** | mlir/lib/Conversion/ | 多方言链式转换 |
| **Region 与 Block 转换** | DialectConversion 文档 | Region 内类型、Block 参数 |
| **失败处理与回滚** | applyPartialConversion | 部分合法化、Diagnostic |

### 2.2 深化 TypeConverter

- 复合类型（tensor of tensor、memref 嵌套）的转换
- Attribute 与 Type 一起转换
- 自定义 Materialization 策略

### 2.3 参考

- `mlir/lib/Conversion/` 中复杂 Conversion
- `mlir/test/Conversion/` 多步管线用例

---

## 三、推荐阅读顺序

1. 复习 M3W1D2/ref.md（约 10 分钟）
2. Dialect Conversion 进阶（约 30 分钟）
3. 实现或分析一条多级 Conversion 管线（约 35 分钟）

---

## 四、代码组织提示

- `lib/`：TypeConverter、多 Op 的 ConversionPattern
- `tools/`：mlir-opt 多步 Conversion 管线
- `test/`：.mlir 输入、FileCheck 验证各阶段 IR

---

*在 M3W1D2 基础上，按本 ref 完成 Dialect Conversion 深化任务。*
