# M3W1 学习与代码计划（按天分节）

## D1 · 周一 · 后端 Codegen 概览

### 学什么

- 编译器后端 Codegen 概览：IR -> 指令选择 -> 调度 -> 寄存器分配 -> 发射。
- 指令选择 (ISel)：SelectionDAG 与 GlobalISel、模式匹配、合法化。
- 寄存器分配：图着色 vs 线性扫描、虚拟寄存器到物理寄存器、溢出。

### 需要写的代码

1. 用 `llc` 把 LLVM IR 编到 x86/ARM，加 `-debug-only=isel` 或 `-print-after-all`，找到指令选择与寄存器分配后的 MIR。
2. （可选）在 TableGen 里为一个简单目标加一条指令描述和一条 SelectionDAG 匹配规则。
3. 写简短笔记：ISel 输入/输出、RegAlloc 输入/输出、与 MLIR lowering 到 LLVM 的衔接点。

---

## D2 · 周二 · 跨方言转换 (Conversion)

### 学什么

- 完整 Dialect 层级：Builtin、Linalg、Vector、MemRef、LLVM 等；Tensor -> MemRef -> LLVM 的层次。
- 跨方言转换：TypeConverter、Pattern 里类型转换、Materialization、unrealized_conversion_cast 的插入与消除。

### 需要写的代码

1. 写一个从「自定义类型 A」到 MemRef 或 LLVM 的 TypeConverter，实现对应 ConversionPattern，在测试里跑通。
2. 在 Conversion 中故意制造「使用者尚未转换」的场景，观察 unrealized_conversion_cast；确认在全部合法化后这些 cast 被消除或报错。
3. 把「自定义 Dialect 的 2～3 个 Op」通过 Conversion 降到 LLVM Dialect，用 mlir-opt 跑通并生成 LLVM IR。

---

## D3 · 周三 · Bufferization

### 学什么

- Bufferization 目标：Tensor 语义到 MemRef（内存）的映射；每结果一分配 vs 原位 (In-Place)。
- One-Shot Bufferization：Use-Def 分析、读后写 (RaW) 冲突检测、何时插入 Copy、何时复用 Buffer。
- Destination Passing Style (DPS)：显式输出 Buffer、与 Linalg/One-Shot 的配合。

### 需要写的代码

1. 写两段 Linalg IR：一段可原位，一段有 RaW 依赖；分别跑 one-shot-bufferize，用 FileCheck 看 alloc/copy 数量差异。
2. 构造最小 RaW 用例，确认 One-Shot 插入 copy；再改 IR 消除依赖，确认 copy 消失。
3. （可选）为简单自定义 Op 实现 BufferizableOpInterface。

---

## D4 · 周四 · GPU 并行模型

### 学什么

- GPU 并行模型：SIMT、Warp、Grid/Block/Thread、Warp Divergence。
- gpu.launch、gpu.thread_id、gpu.block_id；从 scf.parallel 或 linalg 映射到 GPU 层次。
- 多级存储：Global、Shared、Local；gpu.alloc 的 memory space、gpu.barrier 同步。

### 需要写的代码

1. 写 MLIR：用 gpu.launch 启动 1 个 block、若干 thread，在 kernel 里用 gpu.thread_id 计算线性索引并做 load/store 或 arith；用 mlir-opt 跑通 GPU lowering。
2. 在 kernel 里用 memref.alloc 指定 shared space，实现「每个 block 协作搬数据、barrier、再计算」的片段；检查 gpu.barrier 的位置。
3. （可选）写含 if 的 kernel IR，说明 warp divergence；再写等价的无分支版本（select/mask），对比语义。

---

## D5 · 周五 · 全链路串联

### 学什么

- 全链路串联：Frontend -> Optimization（Fusion + Tiling）-> Bufferization -> Codegen（CPU 向量化 / GPU 映射）-> Runtime 验证。
- 性能与正确性：同一图在 CPU 与 GPU 上的结果一致、性能可测。

### 需要写的代码

1. **迷你算子图**：实现 Conv2D + BiasAdd + ReLU 的 MLIR 图（Linalg 或 TOSA），单 batch、单 channel、小尺寸。
2. **优化管线**：应用 Linalg Fusion、Tiling、One-Shot Bufferize；用 FileCheck 或脚本检查关键步骤的 IR。
3. **Codegen 与运行**：CPU lowering 到 LLVM、向量化到 AVX，用 mlir-cpu-runner 跑；GPU（若允许）lowering 到 NVVM、与 CPU 结果对比。
4. **验收清单**：写明每个阶段使用的 Pass、输入/输出方言、如何验证数值正确、如何测量性能。
