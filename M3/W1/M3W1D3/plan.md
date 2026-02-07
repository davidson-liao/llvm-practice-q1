# M3W1D3 学习与代码计划

## 学什么

- Bufferization 目标：Tensor 语义到 MemRef（内存）的映射；每结果一分配 vs 原位 (In-Place)。
- One-Shot Bufferization：Use-Def 分析、读后写 (RaW) 冲突检测、何时插入 Copy、何时复用 Buffer。
- Destination Passing Style (DPS)：显式输出 Buffer、与 Linalg/One-Shot 的配合。

## 需要工具

| 工具 | 用途 |
|------|------|
| MLIR Bufferization 文档：One-Shot、RaW、DPS | 算法与接口 |
| BufferizableOpInterface | 为自定义 Op 支持 bufferization |
| mlir-opt -one-shot-bufferize | 跑 One-Shot 并观察 alloc/copy |

## 需要写的代码

1. **观察 One-Shot**
   - 写两段 Linalg IR：一段可原位（如 elementwise 写回输入），一段有 RaW 依赖；分别跑 one-shot-bufferize，用 FileCheck 看 alloc/copy 数量差异。
2. **RaW 冲突**
   - 构造一个最小 RaW 用例（如 %0 = ...; use(%0); write(%0)），确认 One-Shot 插入 copy；再改 IR 消除依赖，确认 copy 消失。
3. **（可选）自定义 Op 的 BufferizableOpInterface**
   - 为一个简单自定义 Op 实现 BufferizableOpInterface，使其能参与 One-Shot 分析并正确分配或复用 Buffer。
