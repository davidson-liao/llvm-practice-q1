# M3W1D4 参考资料

> 完成 plan.md 中 GPU 并行模型、gpu.launch、Shared Memory、barrier、可选 Warp Divergence 任务所需的必读资料。

---

## 一、必读官方文档

| 资料 | 链接 | 阅读重点 |
|------|------|----------|
| **GPU Dialect** | https://mlir.llvm.org/docs/Dialects/GPU/ | gpu.launch、thread_id、block_id、alloc、barrier |
| **GPU to NVVM/ROCDL** | MLIR 文档 / 源码 | lowering 到 NVVM IR 或 PTX |
| **Memory Space** | GPU Dialect 文档 | 全局/共享/本地、memory space 3 为 shared |
| **SIMT / Warp** | CUDA 或 ROCm 文档 | 对照 Grid/Block/Warp、Warp Divergence |

---

## 二、完成「gpu.launch」的关键资料

### 2.1 基本结构

```mlir
gpu.launch blocks(%bx, %by, %bz) in (%grid_x, %grid_y, %grid_z)
           threads(%tx, %ty, %tz) in (%block_x, %block_y, %block_z) {
  gpu.terminator
}
```

- 在 kernel 内用 `gpu.thread_id`、`gpu.block_id` 计算线性索引。
- 做一次简单 load/store 或 arith，用 mlir-opt 跑 GPU 相关 lowering（gpu-to-nvvm 等）；若环境允许可跑到 NVVM/PTX。

### 2.2 索引计算

- 线性全局 id：`block_id * block_dim + thread_id`（各维可线性化）。
- 参考：`mlir/test/Dialect/GPU/`、`mlir/lib/Conversion/GPUToNVVM/`

---

## 三、完成「Shared Memory」的关键资料

### 3.1 分配与 memory space

```mlir
%shmem = memref.alloc() : memref<32x32xf32, 3>
// memory space 3 通常表示 GPU shared memory（以当前 MLIR 为准）
```

### 3.2 协作加载 + barrier

- 每个 block 内线程协作：把一块 global 数据 load 到 shared。
- **gpu.barrier**：在「所有线程写完 shared」与「所有线程开始读 shared」之间必须 barrier，避免竞态。
- 检查 barrier 位置：barrier 后无写 shared 再读、无读 shared 再写（同一阶段内）。

### 3.3 参考

- `mlir/docs/Dialects/GPU.md` 或源码中 gpu.alloc、memory space
- CUDA shared memory / `__syncthreads()` 对照

---

## 四、完成「（可选）Warp Divergence」的关键资料

### 4.1 含 if 的 kernel

- 同一 Warp 内若有的线程走 then、有的走 else，硬件会串行执行两分支 → Warp Divergence，性能下降。
- 写一段含 if 的 kernel IR，说明哪些分支会导致 divergence。

### 4.2 无分支等价

- 用 `arith.select` 或 mask 代替 if：所有线程执行相同指令，用 mask 屏蔽不需要的结果。
- 对比语义：正确性等价，但无分支版本无 divergence。

---

## 五、推荐阅读顺序

1. GPU Dialect 文档（约 30 分钟）
2. gpu.launch 与 thread_id/block_id 示例（约 20 分钟）
3. Shared memory 与 barrier 示例（约 25 分钟）

---

## 六、参考源码位置

- `mlir/include/mlir/Dialect/GPU/IR/`
- `mlir/lib/Conversion/GPUToNVVM/`
- `mlir/test/Dialect/GPU/`

---

*按此资料学习，即可完成 plan.md 中的 gpu.launch、Shared Memory、barrier、可选 Warp Divergence 任务。*
