# M3W4D4 参考资料

> 对照 M3W1D4 深化练习：GPU、gpu.launch、Shared Memory、barrier。

---

## 一、基础资料（必先完成 M3W1D4）

请先阅读 **M3/W1/M3W1D4/ref.md**，掌握：
- SIMT、Warp、gpu.launch、thread_id/block_id
- Shared Memory（memory space 3）、gpu.barrier
- 可选 Warp Divergence 与无分支等价

---

## 二、深化任务所需资料

### 2.1 小结与综合

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **三月大纲第三部分** | 三月编译器学习大纲.md | 3.4 GPU、SIMT、Shared Memory、barrier |
| **Linalg/SCF → GPU 管线** | 已学 M3W1～W3 | 循环映射到 GPU |
| **可选：NVVM/PTX 跑通** | gpu-to-nvvm、mlir-vulkan-runner | 端到端验证 |

### 2.2 综合练习建议

- 从 Linalg 或 scf.parallel 到 gpu.launch 的完整 lowering
- Shared Memory + barrier 的完整 kernel 与正确性验证
- 写一段小结：SIMT、Shared Memory、barrier 在 GPU 编程中的作用

### 2.3 参考

- `mlir/lib/Conversion/GPUToNVVM/`、`mlir/test/Conversion/GPU/`
- M3W1D4～M3W3D4 的 ref 与代码

---

## 三、推荐阅读顺序

1. 复习 M3W1D4/ref.md 与 M3W2D4、M3W3D4/ref.md（约 15 分钟）
2. 三月大纲 3.4 回顾（约 15 分钟）
3. 综合练习或小结（约 40 分钟）

---

## 四、代码组织提示

- `lib/`：若有 GPU 映射或 kernel 工具
- `test/`：.mlir kernel、FileCheck 或运行验证

---

*在 M3W1D4 基础上，按本 ref 完成 GPU 小结或综合练习。*
