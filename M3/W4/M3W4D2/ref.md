# M3W4D2 参考资料

> 对照 M3W1D2 深化练习：Dialect Conversion、TypeConverter、Materialization。

---

## 一、基础资料（必先完成 M3W1D2）

请先阅读 **M3/W1/M3W1D2/ref.md**，掌握：
- ConversionTarget、TypeConverter、ConversionPattern
- Materialization、unrealized_conversion_cast
- 自定义 Dialect 降到 LLVM 的小管线

---

## 二、深化任务所需资料

### 2.1 小结与综合

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **三月大纲第三部分** | 三月编译器学习大纲.md | 3.2 跨方言 Conversion、TypeConverter |
| **多级 Conversion 管线** | 已学 M3W1～W3 | 串联多方言转换 |
| **可选：自定义 TypeConverter** | 复杂类型、Attribute 转换 | 加深理解 |

### 2.2 综合练习建议

- 实现或分析一条「自定义 Dialect → Linalg/MemRef → LLVM」的多级 Conversion
- 观察 Materialization 在渐进合法化中的行为
- 写一段小结：TypeConverter 与 Materialization 在 Conversion 中的作用

### 2.3 参考

- `mlir/lib/Conversion/`、`mlir/test/Conversion/`
- M3W1D2～M3W3D2 的 ref 与代码

---

## 三、推荐阅读顺序

1. 复习 M3W1D2/ref.md 与 M3W2D2、M3W3D2/ref.md（约 15 分钟）
2. 三月大纲 3.2 回顾（约 15 分钟）
3. 综合练习或小结（约 40 分钟）

---

## 四、代码组织提示

- `lib/`：TypeConverter、ConversionPattern
- `tools/`：多步 Conversion 管线
- `test/`：.mlir 输入、FileCheck 验证各阶段 IR

---

*在 M3W1D2 基础上，按本 ref 完成 Dialect Conversion 小结或综合练习。*
