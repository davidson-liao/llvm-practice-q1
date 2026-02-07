# M2W1D4 学习与代码计划

## 学什么

- 循环平铺 (Tiling) 理论：工作集与 L1/L2/L3 容量、Tile 形状与伪共享 (False Sharing)。
- 缓存一致性：写穿、缓存行、多核下 Tile 边界对齐。
- Linalg 到 MemRef 的降级：linalg.generic (tensor) -> one-shot-bufferize -> linalg.generic (memref) -> convert-linalg-to-loops -> scf.for。

## 需要工具

| 工具 | 用途 |
|------|------|
| mlir-opt：-one-shot-bufferize、-convert-linalg-to-loops 等 | 跑降级管线 |
| Linalg 与 Bufferization 文档 | 理解 tensor→memref 与循环生成 |

## 需要写的代码

1. **Tiling**
   - 对一个小型 linalg.generic（如 matmul 或 fill）做 2D/3D tiling，生成 scf.for 嵌套；尝试不同 tile 尺寸，观察生成的循环边界与步长。
2. **降级管线**
   - 写一段从 linalg (tensor) 到 scf.for + memref 的完整 pipeline（one-shot-bufferize + convert-linalg-to-loops 等），用 FileCheck 检查关键步骤的 IR。
3. **（可选）性能**
   - 固定一个问题规模，对比「不同 tile 大小」在 mlir-cpu-runner 或生成 LLVM 后的运行时间，体会「工作集适配缓存」的效果。
