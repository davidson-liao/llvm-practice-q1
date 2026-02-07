# M1W1 学习与代码计划（按天分节）

---

## D1 · 周一 · LLVM/C++

### 学什么

- LLVM 基础架构：Module / Function / BasicBlock / Instruction 层级、IR 的 SSA 形式。
- isa / cast / dyn_cast 工具库：轻量 RTTI、何时用 isa 检查、何时用 dyn_cast 做模式匹配、避免「先 isa 再 cast」的双重访问。
- 手写 LLVM IR 指令生成：IRBuilder、插入点、BasicBlock 内指令链、Phi 节点与多前驱合并。

### 需要工具

LLVM 源码/预编译包 (15+)、CMake 3.15+、C++17、LLVM Programmer's Manual。

### 需要写的代码

1. **isa/cast/dyn_cast 小练习**：遍历 Function，用 `isa<ConstantInt>` 统计常量整数；用 `dyn_cast<BinaryOperator>` 匹配二元运算。
2. **手写 IR**：用 IRBuilder 生成 max(a,b) 或 abs(x)，含 Phi 节点；用 lli 或 JIT 验证。

---

## D2 · 周二 · MLIR ODS

### 学什么

- TableGen 语法：def、class、dag、list。
- 用 ODS 定义自定义 Op：Operand、Attribute、Result。
- Attribute / Type 系统：Builtin 与自定义 Storage 类。

### 需要工具

MLIR 源码、mlir-tblgen、add_mlir_dialect_library。

### 需要写的代码

1. 在自定义 Dialect 里用 ODS 定义 2～3 个 Op，含 Traits 和 Verifier。
2. 定义自定义 Attribute 或 Type，实现 Storage 并注册。

---

## D3 · 周三 · Pass/融合基础

### 学什么

- Canonicalization 概念：图重写、等价变换、不动点。
- PatternRewrite：C++ RewritePattern、声明式 DRR (Pat<>)。

### 需要工具

GreedyPatternRewriteDriver、mlir-opt、FileCheck。

### 需要写的代码

1. C++ Pattern：匹配 addi x,0 / muli x,1 重写为 x。
2. DRR：用 Pat<> 写 2～3 条，mlir-opt -canonicalize 验证。
3. Lit 测试：FileCheck 检查 Op 消掉或替换。

---

## D4 · 周四 · 向量化/硬件

### 学什么

- Intel SIMD：SSE/AVX/AVX-512、Lane 概念。
- MLIR Vector 方言：transfer_read/write、Padding/Masking。

### 需要工具

Intel Intrinsics Guide、MLIR vector dialect、mlir-opt。

### 需要写的代码

1. 手写 MLIR：transfer_read → arith.addf → transfer_write；mlir-opt 跑通。
2. 边界语义：非整数倍长度 memref，验证 padding。
3. （可选）AVX intrinsic 做 8 路 float 加。

---

## D5 · 周五 · 工程/测试

### 学什么

- CMake 与 MLIR 构建：mlir_tablegen、依赖顺序。
- 单元测试：GTest。回归测试：Lit + FileCheck。

### 需要工具

CMake 3.15+、Ninja、lit、FileCheck、GTest。

### 需要写的代码

1. 完善 MLIR Dialect 工程，ninja check / ctest。
2. 为 Canonicalizer 写 GTest。
3. 为 Canonicalize 或 Vector 写 Lit 测试。
4. （可选）性能基准脚本。
