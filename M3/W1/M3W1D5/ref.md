# M3W1D5 参考资料

> 完成 plan.md 中 Conv+Add+ReLU 迷你图、优化管线、Codegen 与运行、验收清单任务所需的必读资料。

---

## 一、必读官方文档

| 资料 | 链接 | 阅读重点 |
|------|------|----------|
| **Linalg** | https://mlir.llvm.org/docs/Dialects/Linalg/ | linalg.conv、linalg.generic（add/relu） |
| **Bufferization** | https://mlir.llvm.org/docs/Bufferization/ | One-Shot、零中间分配 |
| **mlir-cpu-runner** | MLIR 文档 | 执行 LLVM IR、验证数值 |
| **IREE / Linalg 教程** | 社区博客 | 全链路示例 |

---

## 二、完成「迷你算子图」的关键资料

### 2.1 Conv2D + BiasAdd + ReLU

- **Frontend 建图**：用 Linalg 或 TOSA 表示 Conv2D、BiasAdd、ReLU；输入 MemRef/Tensor、输出 Tensor/MemRef。
- **简化**：单 batch、单 channel、小尺寸（如 8x8、16x16）便于快速跑通。
- 参考：`mlir/test/Integration/Dialect/Linalg/`、IREE 的 Linalg 示例。

### 2.2 图结构

```
Input → Conv2D → BiasAdd → ReLU → Output
```

- Conv2D：linalg.conv 或 linalg.generic 实现 2D 卷积。
- BiasAdd：elementwise add bias（broadcast）。
- ReLU：max(0, x) 用 linalg.generic 或 arith 表示。

---

## 三、完成「优化管线」的关键资料

### 3.1 应用顺序

1. **Linalg Fusion**：将 BiasAdd、ReLU 融合进 Conv 的循环内部（Tile-and-Fuse 或等价 Pass）。
2. **Tiling**：适配 CPU cache（如 32x32 tile）或 GPU block。
3. **One-Shot Bufferize**：零中间 Tensor 分配，BiasAdd/ReLU 原位复用 Conv 输出 buffer。

### 3.2 验证

- FileCheck 或脚本：检查关键步骤后 IR 中 linalg 数量、alloc/copy 数量、scf.for 或 gpu 结构。
- 参考：`mlir/test/Integration/`、Transform Dialect 的 tile-and-fuse。

---

## 四、完成「Codegen 与运行」的关键资料

### 4.1 CPU

- Lowering 到 LLVM（convert-linalg-to-loops、one-shot-bufferize、convert-*-to-llvm 等）。
- 向量化到 AVX（如 vectorize、lower-vector-to-llvm）。
- 用 **mlir-cpu-runner** 执行并打印部分结果；与 Python/NumPy 或 C++ 参考实现对比。

### 4.2 GPU（若环境允许）

- Lowering 到 GPU/NVVM，生成 PTX 或跑 mlir-vulkan-runner 等。
- 与 CPU 结果对比（同一输入、相同数值）。

### 4.3 参考

- `mlir/test/Integration/Dialect/Linalg/CPU/`
- MLIR 文档中 ExecutionEngine、runner

---

## 五、完成「验收清单」的关键资料

### 5.1 文档/注释建议

- **每阶段 Pass**：列出使用的 Pass、输入/输出方言。
- **数值验证**：如何对比（金标准、最大误差）。
- **性能测量**：规模（N、C、H、W）、时间、带宽或 GFLOPS（可选）。

### 5.2 清单模板

| 阶段 | Pass / 工具 | 输入方言 | 输出方言 | 验证方式 |
|------|-------------|----------|----------|----------|
| 建图 | — | — | Linalg | IR 检查 |
| Fusion | linalg-fusion / transform | Linalg | Linalg | FileCheck |
| Tiling | linalg-tile / transform | Linalg | SCF+Linalg | IR 检查 |
| Bufferize | one-shot-bufferize | Tensor | MemRef | alloc 数量 |
| Codegen | convert-*-to-llvm 等 | MemRef/SCF | LLVM | 运行+数值 |
| 运行 | mlir-cpu-runner | LLVM | — | 与参考对比 |

---

## 六、推荐阅读顺序

1. Linalg Conv + elementwise 示例（约 25 分钟）
2. 集成测试目录浏览（约 30 分钟）
3. 从建图到 runner 跑通最小管线（约 60 分钟）

---

## 七、参考源码位置

- `mlir/test/Integration/Dialect/Linalg/`
- `mlir/lib/Conversion/`（LinalgToLLVM、GPU 等）
- IREE 相关教程与示例

---

*按此资料学习，即可完成 plan.md 中的迷你算子图、优化管线、Codegen 与运行、验收清单任务。*
