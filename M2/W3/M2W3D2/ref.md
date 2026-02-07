# M2W3D2 参考资料

> 对照 M2W1D2 深化练习：Interface、Verifier、Trait。

---

## 一、基础资料（必先完成 M2W1D2）

请先阅读 **M2/W1/M2W1D2/ref.md**，掌握：
- OpInterface、Verifier、Trait
- Pass 通过 Interface 操作 Op

---

## 二、深化任务所需资料

### 2.1 深化方向

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **TypeInterface** | MLIR 文档 | 为自定义 Type 定义 Interface |
| **AttributeInterface** | 同上 | 为 Attribute 定义可查询方法 |
| **OpAsmInterface** | 自定义打印/解析 | 让 Op 有美观的 IR 格式 |

### 2.2 可选扩展

- 为 Dialect 定义 DialectInterface（Dialect 级别的接口）
- 复杂 Verifier：涉及多 Op、多 Region
- Trait 与 Canonicalize 的完整联动

### 2.3 参考

- `mlir/include/mlir/IR/OpImplementation.h`（打印/解析）
- M2W2D2/ref.md 中的多方法 Interface

---

## 三、推荐阅读顺序

1. 复习 M2W1D2/ref.md（约 10 分钟）
2. 复习 M2W2D2/ref.md（约 10 分钟）
3. TypeInterface / AttributeInterface 或 OpAsmInterface（约 30 分钟）

---

## 四、代码组织提示

- `lib/`、`tools/`、`test/`

---

*在 M2W1D2、M2W2D2 基础上，按本 ref 完成 Interface、Verifier、Trait 进一步深化。*
