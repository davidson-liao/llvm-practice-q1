# M1W3D4 参考资料

> 对照 M1W1D4 深化：Vector dialect、transfer_read/write 进阶。

---

## 一、基础资料（必先完成 W1D4/W2D4）

请先阅读 **M1/W1/M1W1D4/ref.md** 与 **M1/W2/M1W2D4/ref.md**，掌握：
- vector.transfer_read/write、Padding 语义
- 多维 transfer、不同 vector 宽度

---

## 二、深化任务所需资料

### 2.1 Vector Dialect 进阶

| 资料 | 链接/位置 | 用途 |
|------|-----------|------|
| **Vector Dialect 完整文档** | https://mlir.llvm.org/docs/Dialects/VectorOps/ | contract、reduction、mask |
| **vector.load/store** | Vector 文档 | 简单一维 load/store |
| **Lowering 管线** | convert-vector-to-llvm、convert-vector-to-gpu | 向量 IR 降级 |

### 2.2 transfer 进阶

| 资料 | 链接/位置 | 用途 |
|------|-----------|------|
| **permutation_map** | Vector 文档 | 多维索引映射、转置 |
| **mask 与 padding 组合** | Vector 文档 | 可控越界行为 |
| **mlir/test/Dialect/Vector/** | MLIR 源码 | 完整用例 |

### 2.3 建议深化方向

- 写带 permutation_map 的多维 transfer
- 实现简单向量归约（如 vector.reduction add）
- 组合 transfer + contract 做小块矩阵乘

---

## 三、推荐阅读顺序

1. 复习 M1W1D4/ref.md、M1W2D4/ref.md（约 10 分钟）
2. Vector Dialect 文档中 contract、reduction（约 25 分钟）
3. `mlir/test/Dialect/Vector/` 相关用例（约 20 分钟）

---

## 四、代码组织

- `lib/`、`tools/`：MLIR 构建与执行
- `test/`：.mlir + FileCheck

---

*在 W1/W2 基础上，完成 Vector dialect 深化任务。*
