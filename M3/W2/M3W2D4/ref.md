# M3W2D4 参考资料

> 对照 M3W1D4 深化练习：GPU、gpu.launch、Shared Memory、barrier。

---

## 一、基础资料（必先完成 M3W1D4）

请先阅读 **M3/W1/M3W1D4/ref.md**，掌握：
- SIMT、Warp、Grid/Block/Thread、Warp Divergence
- gpu.launch、gpu.thread_id、gpu.block_id
- Shared Memory（memory space 3）、gpu.barrier

---

## 二、深化任务所需资料

### 2.1 深化 GPU 映射

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **scf.parallel → gpu** | mlir/lib/Conversion/ | 循环映射到 Grid/Block |
| **gpu-to-nvvm / gpu-to-rocdl** | mlir/lib/Conversion/ | 到 NVVM/ROCDL 的 lowering |
| **Warp 级优化** | CUDA/ROCm 文档 | shuffle、warp 同步 |

### 2.2 深化 Shared Memory

- 多级 tile：global → shared → register 的典型模式
- Barrier 放置规则：写 shared 后 barrier，再读 shared
- 与 Linalg Tiling 结合：tile 尺寸与 block 尺寸对齐

### 2.3 参考

- `mlir/lib/Conversion/GPUToNVVM/`
- `mlir/test/Conversion/GPU/`

---

## 三、推荐阅读顺序

1. 复习 M3W1D4/ref.md（约 10 分钟）
2. GPU Dialect lowering 文档（约 25 分钟）
3. 完整 kernel（shared + barrier）跑通 NVVM/PTX（约 30 分钟）

---

## 四、代码组织提示

- `lib/`：若有自定义 GPU 映射 Pass
- `test/`：.mlir kernel、FileCheck 或运行验证

---

*在 M3W1D4 基础上，按本 ref 完成 GPU 深化任务。*
