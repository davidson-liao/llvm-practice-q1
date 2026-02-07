# M2W1 学习与代码计划（按天分节）

## D1 · 周一 · Alias Analysis

### 学什么

- LLVM 内存优化分析：为何需要别名信息、LICM/向量化对 NoAlias 的依赖。
- Alias Analysis：BasicAA、TBAA、SCEV AA；MustAlias / NoAlias / MayAlias 三种结果。
- 自定义 Alias Analysis Pass：继承 AAResultBase、实现 alias()、在 PassManager 中注册。

### 需要写的代码

1. 写一段带指针参数的 C/LLVM IR，用 `opt -basic-aa -aa-eval` 看 Must/No/MayAlias 输出。
2. 实现一个简单的 Module/Function AA：对特定函数或全局命名约定返回 NoAlias；写测试验证 LICM 能因此多移动一条负载。
3. （可选）C++ 模板元编程：区分不同 Kind 的指针类型，与 TBAA 结合。

---

## D2 · 周二 · Interface / Verifier / Trait

### 学什么

- 接口 (Interface)：Concept-Model、OpInterface、ExternalModel；Pass 如何通过 Interface 操作多种 Op。
- Op 验证逻辑 (Verifier)：ODS 里 C++ 代码块、verify() 中检查类型/维度/属性一致性。
- 特征 (Trait)：NoSideEffect、Commutative、SymbolTable 等。

### 需要写的代码

1. 定义 OpInterface（如 `MyFoldable`），声明 fold() 方法；为 1～2 个 Op 实现；写 Pass 调用 fold。
2. 在某个自定义 Op 的 ODS 里加 C++ Verifier；写测试故意构造非法 IR，确认 verify 报错。
3. 给自定义 Op 加上 HasFolder、Commutative 等 Trait，观察 Canonicalize 是否自动应用对应规则。

---

## D3 · 周三 · 算子融合 (Fusion)

### 学什么

- 算子融合：生产者-消费者、数据局部性、减少 Load/Store 次数。
- Linalg Tile-and-Fuse：Tiling 消费端、Slice Analysis 推导生产者区域。
- 数据流/使用-定义分析：循环携带依赖、融合合法性。

### 需要写的代码

1. 写两个连续的 Linalg Op（如 matmul + add），先不融合跑一遍，再用手动 tiling 或 fusion 脚本融合，对比 load/store 数量。
2. 对「Consumer 的某个 Tile」写小工具：根据索引映射推导 Producer 需要的数据块，输出索引范围。
3. 用 Transform Dialect 或 C++：对 Producer-Linalg -> Consumer-Linalg 应用 tile-and-fuse，用 FileCheck 检查循环嵌套。

---

## D4 · 周四 · 循环平铺 (Tiling) / 降级管线

### 学什么

- 循环平铺理论：工作集与 L1/L2/L3 容量、Tile 形状与伪共享。
- 缓存一致性：写穿、缓存行、多核下 Tile 边界对齐。
- Linalg 到 MemRef 的降级：linalg.generic (tensor) -> one-shot-bufferize -> convert-linalg-to-loops -> scf.for。

### 需要写的代码

1. 对小型 linalg.generic（如 matmul 或 fill）做 2D/3D tiling，生成 scf.for 嵌套；尝试不同 tile 尺寸。
2. 写从 linalg (tensor) 到 scf.for + memref 的完整 pipeline，用 FileCheck 检查关键步骤。
3. （可选）固定问题规模，对比不同 tile 大小在 mlir-cpu-runner 或生成 LLVM 后的运行时间。

---

## D5 · 周五 · MLIR Python 绑定 / 脚本自动化

### 学什么

- MLIR Python 绑定：C-API 封装、用 Python 构建 IR、跑 Pass、查看结果。
- 脚本自动化：不同输入规模下跑同一管线，收集时间/吞吐。

### 需要写的代码

1. 用 Python 绑定创建简单 Module：几个 Linalg 或自定义 Dialect 的 Op，跑 canonicalize 或自定义 Pass，打印 IR。
2. 写脚本：对矩阵乘法或向量加，规模从 64 到 1024 变化，记录时间并输出 CSV 或表格。
3. 若有 C++ 跑通管线，在 Python 里用同一份 .mlir 或同一参数，对比 C++ 与 Python 路径的结果一致。
