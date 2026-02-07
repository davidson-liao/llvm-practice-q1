# M1W1D4 学习与代码计划

## 学什么

- Intel SIMD 指令集：SSE/AVX/AVX-512、Lane（通道）概念、标量 vs 向量吞吐。
- MLIR Vector 方言基础：多维向量、与 MemRef/Tensor 的关系。
- 向量加载/存储：`vector.transfer_read` / `vector.transfer_write`、Padding/Masking 语义。

## 需要工具

| 工具 | 用途 |
|------|------|
| Intel Intrinsics Guide 或 AVX 文档 | 查 vaddps 等指令与 Lane 宽度 |
| MLIR：vector dialect 文档与源码 | transfer_read/write、lowering |
| mlir-opt（-convert-vector-to-llvm 等） | 看向量 IR 如何降级 |

## 需要写的代码

1. **手写向量 IR**
   - 写一段 MLIR：用 `vector.transfer_read` 从 memref 读一块到 vector，做一次 `arith.addf`，再用 `vector.transfer_write` 写回；用 mlir-opt 跑通并（可选）降到 LLVM IR。
2. **边界语义**
   - 构造「长度不是 vector 宽度整数倍」的 memref，用 transfer_read 的 padding 语义读；确认越界部分被填 0（或指定值），无分支。
3. **（可选）C++ intrinsic**
   - 写一个小程序：用 AVX intrinsic（如 `_mm256_add_ps`）做 8 路 float 加，与标量循环对比结果一致。
