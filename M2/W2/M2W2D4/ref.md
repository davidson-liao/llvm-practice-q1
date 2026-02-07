# M2W2D4 参考资料

> 对照 M2W1D4 深化练习：Tiling、降级管线、性能对比。

---

## 一、基础资料（必先完成 M2W1D4）

请先阅读 **M2/W1/M2W1D4/ref.md**，掌握：
- Linalg Tiling、one-shot-bufferize、convert-linalg-to-loops
- 降级管线顺序、FileCheck 验证
- 性能对比思路

---

## 二、深化任务所需资料

### 2.1 深化 Tiling

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **3D Tiling** | matmul 的 i,j,k 三维 | 分块矩阵乘法 |
| **Interchange** | 循环顺序交换 | 与 tiling 配合优化 |
| **Padding** | Tile 边界对齐 | 避免 remainder 分支 |

### 2.2 深化降级管线

- 加入 vectorize、lower-vector-to-llvm 等
- 完整 linalg → LLVM IR 的 pipeline
- 用 mlir-cpu-runner 执行并验证数值

### 2.3 深化性能对比

- 多组 tile size 系统对比
- 输出 GFLOPS 或带宽
- 与 NumPy/手写 C 的参考实现对比

### 2.4 参考

- `mlir/test/Integration/Dialect/Linalg/CPU/`
- MLIR 性能优化讨论

---

## 三、推荐阅读顺序

1. 复习 M2W1D4/ref.md（约 10 分钟）
2. Linalg 3D tiling、interchange 文档（约 25 分钟）
3. 完整降级管线示例（约 25 分钟）

---

## 四、代码组织提示

- `lib/`、`tools/`：管线代码、脚本
- `test/`：.mlir、FileCheck、性能脚本

---

*在 M2W1D4 基础上，按本 ref 完成 Tiling、降级、性能深化任务。*
