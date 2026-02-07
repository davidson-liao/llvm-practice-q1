# M3W1D4 学习与代码计划

## 学什么

- GPU 并行模型：SIMT、Warp、Grid/Block/Thread、Warp Divergence 对性能的影响。
- gpu.launch、gpu.thread_id、gpu.block_id；从 scf.parallel 或 linalg 映射到 GPU 层次。
- 多级存储：Global (HBM)、Shared、Local (Register)；gpu.alloc 的 memory space、gpu.barrier 同步。

## 需要工具

| 工具 | 用途 |
|------|------|
| MLIR GPU Dialect 文档 | gpu.launch、allocation、barrier |
| CUDA 或 ROCm 概念（可选） | 对照 Grid/Block/Warp |
| mlir-opt -gpu-map-parallel-loops 等 | 看循环如何映射到 GPU |

## 需要写的代码

1. **gpu.launch**
   - 写一段 MLIR：用 gpu.launch 启动 1 个 block、若干 thread，在 kernel 里用 gpu.thread_id 计算线性索引并做一次简单 load/store 或 arith；用 mlir-opt 跑通 GPU 相关 lowering（若环境允许可跑到 NVVM/PTX）。
2. **Shared Memory**
   - 在 kernel 里用 memref.alloc 指定 memory space 3（或当前 GPU 的 shared space），实现「每个 block 协作把一块 global 数据搬到 shared、barrier、再计算」的片段；检查 gpu.barrier 的位置是否正确。
3. **（可选）Warp Divergence**
   - 写一段含 if 的 kernel IR，说明在 SIMT 下会如何造成 warp divergence；再写一个等价的无分支版本（如用 select/mask），对比语义。
