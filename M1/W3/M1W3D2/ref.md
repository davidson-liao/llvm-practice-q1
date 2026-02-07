# M1W3D2 参考资料

> 对照 M1W1D2 深化：ODS、Attribute/Type 进阶。

---

## 一、基础资料（必先完成 W1D2/W2D2）

请先阅读 **M1/W1/M1W1D2/ref.md** 与 **M1/W2/M1W2D2/ref.md**，掌握：
- ODS 定义 Op（Operand、Attribute、Result）
- Traits、Verifier、自定义 Attribute/Type

---

## 二、深化任务所需资料

### 2.1 ODS 进阶

| 资料 | 链接/位置 | 用途 |
|------|-----------|------|
| **ODS 完整文档** | https://mlir.llvm.org/docs/DefiningDialects/Operations/ | Variadic、Optional、DefaultVal |
| **Region / Block 参数** | ODS 文档 | SingleBlock、MultiBlock Region |
| **自定义 Builder** | ODS 文档 | 多态 build、 inferReturnTypes |

### 2.2 Attribute/Type 进阶

| 资料 | 链接/位置 | 用途 |
|------|-----------|------|
| **AttributesAndTypes** | https://mlir.llvm.org/docs/DefiningDialects/AttributesAndTypes/ | 复杂 Storage、参数化类型 |
| **Dialect 间类型引用** | MLIR 文档 | 跨 Dialect 的 Type 依赖 |
| **Linalg / Tensor** | `mlir/include/mlir/Dialect/` | 复杂 Attribute/Type 参考 |

### 2.3 建议深化方向

- 为 Op 增加 Region、或 Optional Operand
- 定义参数化 Type（如 `MyTensor<rank, elem_type>`）
- 实现 inferReturnTypes 或自定义 printer/parser

---

## 三、推荐阅读顺序

1. 复习 M1W1D2/ref.md、M1W2D2/ref.md（约 10 分钟）
2. ODS 文档中 Variadic、Region、Builder 小节（约 25 分钟）
3. 浏览 Linalg/Tensor 的 .td 定义（约 20 分钟）

---

## 四、代码组织

- `lib/`：Dialect、Op、Type/Attribute 实现
- `tools/`：测试工具
- `test/`：合法/非法 IR、parser/print 验证

---

*在 W1/W2 基础上，完成 ODS、Attribute/Type 深化任务。*
