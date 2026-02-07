# M3W3D4 参考资料

> 对照 M3W1D4 深化练习：GPU、gpu.launch、Shared Memory、barrier。

---

## 一、基础资料（必先完成 M3W1D4）

请先阅读 **M3/W1/M3W1D4/ref.md**，掌握：
- SIMT、Warp、gpu.launch、thread_id/block_id
- Shared Memory（memory space 3）、gpu.barrier
- 可选 Warp Divergence 与无分支等价

---

## 二、深化任务所需资料

### 2.1 深化 GPU 映射

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **scf/linalg → gpu** | mlir/lib/Conversion/ | 循环映射到 Grid/Block |
| **gpu-to-nvvm / gpu-to-rocdl** | mlir/lib/Conversion/ | 到 NVVM/ROCDL |
| **Warp 级原语** | CUDA/ROCm 文档 | warp shuffle、warp sync |

### 2.2 深化 Shared Memory 与 Barrier

- 多级 tile：global → shared → register 的完整 kernel
- Barrier 正确性：写 shared → barrier → 读 shared
- 与 Linalg Tiling 结合：block 尺寸与 tile 对齐

### 2.3 参考

- `mlir/lib/Conversion/GPUToNVVM/`
- `mlir/test/Conversion/GPU/`、`mlir/test/Dialect/GPU/`

---

## 三、推荐阅读顺序

1. 复习 M3W1D4/ref.md（约 10 分钟）
2. GPU lowering 文档或源码（约 30 分钟）
3. 完整 kernel（shared + barrier）跑通 NVVM/PTX（约 35 分钟）

---

## 四、代码组织提示

- `lib/`：若有自定义 GPU 映射或 kernel 工具
- `test/`：.mlir kernel、FileCheck 或运行验证

---

*在 M3W1D4 基础上，按本 ref 完成 GPU 深化任务。*
