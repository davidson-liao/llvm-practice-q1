# M3W1D5 学习与代码计划

## 学什么

- 全链路串联：Frontend（建图）-> Optimization（Fusion + Tiling）-> Bufferization -> Codegen（CPU 向量化 / GPU 映射）-> Runtime 验证。
- 性能与正确性：同一图在 CPU 与 GPU 上的结果一致、性能可测。

## 需要工具

| 工具 | 用途 |
|------|------|
| mlir-opt（多 Pass 组合） | 完整管线 |
| mlir-cpu-runner / mlir-vulkan-runner 或 JIT | 执行并验证数值 |
| Python/NumPy 或 C++ 参考实现 | 金标准对比 |

## 需要写的代码

1. **迷你算子图**
   - 实现 Conv2D + BiasAdd + ReLU 的 MLIR 图（用 Linalg 或 TOSA 等）：输入 MemRef/Tensor、输出 Tensor/MemRef；可先做「单 batch、单 channel、小尺寸」以快速跑通。
2. **优化管线**
   - 应用：Linalg Fusion（BiasAdd+ReLU 进 Conv）、Tiling（适配 CPU cache 或 GPU block）、One-Shot Bufferize（零中间 Tensor 分配）；用 FileCheck 或脚本检查关键步骤的 IR。
3. **Codegen 与运行**
   - CPU：lowering 到 LLVM、向量化到 AVX，用 mlir-cpu-runner 跑并打印部分结果。
   - GPU（若环境允许）：lowering 到 GPU/NVVM、生成 PTX 或跑 runner，与 CPU 结果对比。
4. **验收清单**
   - 文档或注释中写明：每个阶段使用的 Pass、输入/输出方言、如何验证数值正确、如何测量性能（规模、时间、带宽或 GFLOPS）。
