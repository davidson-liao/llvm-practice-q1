# M1W2D4 参考资料

> 对照 M1W1D4 深化练习：多维 vector transfer、不同 vector 宽度 padding、更多 AVX 组合。

---

## 一、基础资料（必先完成 M1W1D4）

请先阅读 **M1/W1/M1W1D4/ref.md**，掌握：
- vector.transfer_read/write、Padding 语义
- arith.addf、in_bounds
- AVX intrinsic 基础

---

## 二、深化任务所需资料

### 2.1 多维 Vector 的 transfer

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **Vector Dialect 多维** | https://mlir.llvm.org/docs/Dialects/VectorOps/ | vector<2x4xf32>、permutation_map |
| **transfer_read 多维索引** | Vector 文档 | 从 memref<8x16xf32> 读 vector<4x4xf32> |
| **Linalg 测试** | `mlir/test/Dialect/Vector/` | 多维 transfer 用例 |

### 2.2 不同 Vector 宽度的 Padding 用例

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **Out-of-bounds 文档** | Vector Dialect 文档 | padding 值、mask 语义 |
| **vector<4> vs vector<8>** | 同一 memref 不同 tile | 边界处 padding 行为差异 |
| **mask 与 padding 组合** | Vector 文档 | 显式 mask 读写 |

建议：构造 memref<17xf32>，分别用 vector<4> 和 vector<8> 读，验证最后一块的 padding。

### 2.3 更多 AVX Intrinsic 组合

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **Intel Intrinsics Guide** | https://www.intel.com/content/www/us/en/docs/intrinsics-guide/ | _mm256_mul_ps、fma、blend |
| **向量化模式** | 常见：load->op->store、reduce、horizontal add | 组合多种 intrinsic |
| **-mavx2、-mfma** | 编译选项 | 启用更多指令集 |

---

## 三、推荐阅读顺序

1. 复习 M1W1D4/ref.md（约 10 分钟）
2. Vector Dialect 多维与 permutation_map（约 25 分钟）
3. `mlir/test/Dialect/Vector/` 中多维与 padding 用例（约 20 分钟）
4. Intel Intrinsics Guide 浏览更多 AVX 指令（约 15 分钟）

---

## 四、代码组织提示

- `lib/`、`tools/`：生成/执行 MLIR 或 C++ intrinsic 的代码
- `test/`：.mlir + FileCheck 验证 transfer 与 lowering

---

*在 M1W1D4 基础上，按本 ref 完成多维 transfer、不同宽度 padding、AVX 组合的深化任务。*
